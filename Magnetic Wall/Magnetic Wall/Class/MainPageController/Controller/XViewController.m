//
//  XViewController.m
//  Fresh Wall
//
//  Created by 肖坚伟 on 16/4/9.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import "XViewController.h"
#import "DetailViewController.h"
#import "XCollectionView.h"
#import "XCollectionViewCell.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "MBProgressHUD.h"
#import <MobAPI/MobAPI.h>
#import "MJRefresh.h"
#import "Reachability.h"
#import "MJDIYHeader.h"

@interface XViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic , strong) NSMutableArray *dataArrayM;

@property (weak, nonatomic) IBOutlet XCollectionView *collectionView;

@property (nonatomic ,strong) UIButton *toTopButton;

@property (nonatomic ,strong) MBProgressHUD *hud;

@property (nonatomic ,strong) SDWebImageManager *manager;


@end

@implementation XViewController

-(NSMutableArray *)dataArrayM
{
    if (_dataArrayM == nil) {
        _dataArrayM = [NSMutableArray array];
    }
    return _dataArrayM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //更新app的图片数量
//        [self putDataToSever]; 
    
    [self createUI];
    [self requestData];
}

//上传数据
-(void)putDataToSever
{
    NSString *key = [[API_KEY dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    
    NSString * value = [[IMGNUM dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    value = [value stringByReplacingOccurrencesOfString:@"=" withString:@""];
    
    [MobAPI sendRequest:[MOBAKvRequest kvPutRequest:API_TABLE key:key value:value] onResult:^(MOBAResponse *response) {
        if (!response.error) {
            NSLog(@"id ---------> %@",response.responder);
        }else
        {
            NSLog(@"error ---------> %@",response.error);
        }
    }];
}

-(void)createUI
{
    self.view.backgroundColor = [UIColor colorWithRed:51/255.f green:55/255.f blue:61/255.f alpha:1.f];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gengduologo"]];
    imageView.frame = CGRectMake(0, 0, 90, 90);
    imageView.center = self.view.center;
    imageView.alpha = 0.8;
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    
    [self.collectionView setUpCollectionView];
    __weak typeof(self) weakSelf = self;
    [self.collectionView setSelectedItemClick:^(NSInteger index) {
        NSString *imageUrl = [[NSString stringWithFormat:IMGNAME,(long) weakSelf.dataArrayM.count - 1 - index] componentsSeparatedByString:@"_"][0];
        //判断是否存在缓存中
        if ([[SDImageCache sharedImageCache] diskImageExistsWithKey:imageUrl]) {
            UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageUrl];
            [weakSelf presentToDetailViewControllerWith:image];
            return ;
        }
        
        Reachability *connect = [Reachability reachabilityForInternetConnection];
        if (connect.currentReachabilityStatus != ReachableViaWiFi) {
            
            //判断本地是否有用户选择的记录
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"UseWithNoWiFi"] == YES) {
                [weakSelf requestDetailImageDataWith:imageUrl];
                return;
            }
            
            //未连接wifi,提示图片比较大
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"图片文件较大，继续在非WiFi环境下浏览？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UseWithNoWiFi"];
                [weakSelf requestDetailImageDataWith:imageUrl];
            }];
            [alertController addAction:okAction];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else
        {
            [weakSelf requestDetailImageDataWith:imageUrl];
        }
    }];
    
    self.collectionView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    
    UIButton *toTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    toTopButton.frame = CGRectMake(SCREENWIDTH - 60, SCREENHEIGHT - 60, 30, 30);
    [toTopButton setBackgroundImage:[UIImage imageNamed:@"zhiding"] forState:UIControlStateNormal];
    [self.view addSubview:toTopButton];
    [toTopButton addTarget:self action:@selector(toTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.toTopButton = toTopButton;
    toTopButton.alpha = 0.0;
    [self.collectionView setScrollViewDidScroll:^(UIScrollView *scrollView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > 1000) {
            if (toTopButton.alpha == 0.0) {
                [UIView animateWithDuration:0.8 animations:^{
                    toTopButton.alpha = 0.51;
                }];
            }
        }else
        {
            if (toTopButton.alpha >= 0.5) {
                [UIView animateWithDuration:0.8 animations:^{
                    toTopButton.alpha = 0.0;
                }];
            }
        }
    }];
    
    //注册3Dtouch
    [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
}

-(void)toTopButtonClick:(UIButton *)button
{
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)requestDetailImageDataWith:(NSString *)imageUrl
{
    [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(jugdeProgress:) userInfo:nil repeats:NO];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    self.manager = manager;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"Loading...";
    self.hud = hud;
    
    [manager downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        hud.progress = receivedSize * 1.0 / expectedSize;
        NSLog(@"hud.progress ---------> %f",hud.progress);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [hud hideAnimated:YES];
        NSLog(@"error ---------> %@",error);
        [self presentToDetailViewControllerWith:image];
    }];
}

/** 取消下载图片 */
-(void)cancelWork:(UIButton *)button
{
    [self.manager cancelAll];
    [self.hud hideAnimated:YES];
}

/** 判断是否超时 */
-(void)jugdeProgress:(NSTimer *)time
{
    NSLog(@" ---------> 定时器调用");
    if (self.hud.progress < 1) {
        [self.hud.button setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.hud.button addTarget:self action:@selector(cancelWork:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)presentToDetailViewControllerWith:(UIImage *)image
{
    if (!image) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"图片加载失败" message:@"请检查您的网络连接噢" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    DetailViewController *detailCtl = [[DetailViewController alloc] init];
    detailCtl.showImage = image;
    [self presentViewController:detailCtl animated:YES completion:^{
    }];
}

-(void)requestData
{
    [self.dataArrayM removeAllObjects];
    __weak XViewController *theViewController = self;
    NSString *key = [[API_KEY dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    [MobAPI sendRequest:[MOBAKvRequest kvGetRequest:API_TABLE key:key] onResult:^(MOBAResponse *response) {
        NSInteger imageNum = [response.responder[@"v"] integerValue];
        [theViewController.collectionView.mj_header endRefreshing];
        if (response.error) {
            NSLog(@"error ---------> %@",response.error);
            imageNum = [[NSUserDefaults standardUserDefaults] integerForKey:@"imageNum"];
        }
        
        //存入本地
        [[NSUserDefaults standardUserDefaults] setInteger:imageNum forKey:@"imageNum"];
        
        for (NSInteger i = 0; i <= imageNum; i++) {
            NSString *imageUrl = [NSString stringWithFormat:IMGNAME,(long)i];
            [theViewController.dataArrayM addObject:imageUrl];
        }
        NSEnumerator *enumer = [theViewController.dataArrayM reverseObjectEnumerator];
        theViewController.dataArrayM = [enumer allObjects].mutableCopy;
        if (theViewController.dataArrayM.count > 0) {
            theViewController.collectionView.dataArray = [theViewController.dataArrayM copy];
        }
    }];
}

//字典转json格式字符串：
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 3DTouch
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    DetailViewController *detailCtl = [[DetailViewController alloc] init];
    NSIndexPath *index = [self.collectionView indexPathForItemAtPoint:CGPointMake(location.x, location.y + self.collectionView.contentOffset.y)];
    if (index == NULL) {
        return nil;
    } else {
        [self.hud hideAnimated:YES];
        XCollectionViewCell *cell = (XCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:index];
        detailCtl.showImage = cell.backgroundImageView.image;
        NSString *imageUrl = [[NSString stringWithFormat:IMGNAME,(long) self.dataArrayM.count - 1 - index.row] componentsSeparatedByString:@"_"][0];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        self.manager = manager;
        [manager downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            detailCtl.showImage = image;
        }];
        return detailCtl;
    }
}

-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}
 


@end

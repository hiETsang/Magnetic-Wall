//
//  DetailViewController.m
//  Fresh Wall
//
//  Created by 肖坚伟 on 16/4/27.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import "DetailViewController.h"

#import "MoreOptionsView.h"

#import "MBProgressHUD.h"

#import "UIImage+ClipSubImage.h"

#import <MessageUI/MessageUI.h>

#import <Social/Social.h>

#import "AddPhoneAlbumTool.h"

#import "MWActivity.h"

#define BOTTOMHEIGHT 45

@interface DetailViewController ()<UIScrollViewDelegate,MoreOptionsViewDelegate,MFMailComposeViewControllerDelegate>
/** 预览图ImageView */
@property (nonatomic , strong) UIImageView *coverImageView;
/** 更多界面 */
@property (nonatomic ,strong) MoreOptionsView *optionView;
/** 默认展示的界面 */
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) UIView *leftView;
@property (nonatomic ,strong) UIView *rightView;
@property (nonatomic ,strong) UIImageView *contentImageView;

@end

@implementation DetailViewController

-(void)setShowImage:(UIImage *)showImage
{
    _showImage = showImage;
    CGSize imageSize = self.showImage.size;
    float imageX = (SCREENWIDTH - SCREENWIDTH * (SCREENHEIGHT - BOTTOMHEIGHT)/SCREENHEIGHT) * 0.5;
    float imageY = 0;
    float imageW = imageSize.width * (SCREENHEIGHT - BOTTOMHEIGHT)/imageSize.height;
    float imageH = self.scrollView.frame.size.height;
    self.contentImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    self.contentImageView.image = self.showImage;
    self.scrollView.contentSize = CGSizeMake(imageW + imageX * 2, imageH);
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width/2 - SCREENWIDTH/2, 0)];
}

-(void)setShowMode:(ImageViewShowMode)showMode
{
    if (showMode != _showMode) {
        _showMode = showMode;
        [self updateContentView];
    }
}

/** 重新更新界面 */
- (void)updateContentView
{
    switch (self.showMode) {
        case ImageViewShowModeIPhone:
        {
            self.leftView.hidden = NO;
            self.rightView.hidden = NO;
            CGSize imageSize = self.showImage.size;
            float imageX = (SCREENWIDTH - SCREENWIDTH * (SCREENHEIGHT - BOTTOMHEIGHT)/SCREENHEIGHT) * 0.5;
            float imageY = 0;
            float imageW = imageSize.width * (SCREENHEIGHT - BOTTOMHEIGHT)/imageSize.height;
            float imageH = self.scrollView.frame.size.height;
            self.contentImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            self.scrollView.contentSize = CGSizeMake(imageW + imageX * 2, imageH);
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width/2 - SCREENWIDTH/2, 0)];
        }
            break;
            case ImageViewShowModeOrgin:
        {
            CGSize imageSize = self.showImage.size;
            self.leftView.hidden = YES;
            self.rightView.hidden = YES;
            self.contentImageView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.width * (imageSize.height/imageSize.width));
            self.contentImageView.center = self.scrollView.center;
            self.scrollView.contentSize = CGSizeMake(0, 0);
            self.coverImageView.image = nil;
        }
            break;
        default:
            break;
    }
}

-(MoreOptionsView *)optionView
{
    if (_optionView == nil) {
        _optionView = [[MoreOptionsView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT)];
        _optionView.delegate = self;
        [self.view addSubview:_optionView];
    }
    return _optionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI
{
    //UI
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - BOTTOMHEIGHT)];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.decelerationRate = 0.1f;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGSize imageSize = self.showImage.size;
    float imageX = (SCREENWIDTH - SCREENWIDTH * (SCREENHEIGHT - BOTTOMHEIGHT)/SCREENHEIGHT) * 0.5;
    float imageY = 0;
    float imageW = imageSize.width * (SCREENHEIGHT - BOTTOMHEIGHT)/imageSize.height;
    float imageH = scrollView.frame.size.height;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    imageView.image = self.showImage;
    [scrollView addSubview:imageView];
    self.contentImageView = imageView;
    scrollView.contentSize = CGSizeMake(imageW + imageX * 2, imageH);
    [scrollView setContentOffset:CGPointMake(scrollView.contentSize.width/2 - SCREENWIDTH/2, 0)];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageX, scrollView.frame.size.height)];
    leftView.backgroundColor = [UIColor blackColor];
    leftView.alpha = 0.3;
    [self.view addSubview:leftView];
    self.leftView = leftView;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH - imageX, 0, imageX, scrollView.frame.size.height)];
    rightView.backgroundColor = [UIColor blackColor];
    rightView.alpha = 0.3;
    [self.view addSubview:rightView];
    self.rightView = rightView;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame), SCREENWIDTH, BOTTOMHEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    
    NSArray *buttonImgArray = @[@"jixing.png",@"yulan.png",@"xiazai.png",@"gengduo.png"];
    float buttonX = 0;
    float buttonY = 0;
    float buttonW = SCREENWIDTH/4;
    float buttonH = BOTTOMHEIGHT;
    for (NSInteger i = 0; i < 4; i++) {
        buttonX = i * buttonW;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button setImage:[UIImage imageNamed:buttonImgArray[i]] forState:UIControlStateNormal];
        [bottomView addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIImageView *coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, 0, scrollView.frame.size.width - imageX * 2, scrollView.frame.size.height + 2)];
    self.coverImageView = coverImageView;
    [self.view addSubview:coverImageView];
    
    NSInteger num = [[NSUserDefaults standardUserDefaults] integerForKey:@"showDetailControllerCount"];
    if (num < 4) {
        //提示
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.userInteractionEnabled = NO;
        hud.offset = CGPointMake(0.f, - MBProgressMaxOffset);
        [hud hideAnimated:YES afterDelay:3.f];
        switch (num) {
            case 0:
            {
                hud.label.text = @"下滑返回，记好啦！";
                num ++;
            }
                break;
            case 1:
            {
                hud.label.text = @"怕你忘了，最后一次，下滑返回！";
                num ++;
            }
                break;
            case 2:
            {
                hud.label.text = @"突然想再来一次！哈哈↓↓↓";
                num ++;
            }
                break;
            case 3:
            {
                hud.label.text = @"我是一个正经的提示框！";
                num ++;
            }
                break;
            default:
                break;
        }
        [[NSUserDefaults standardUserDefaults] setInteger:num forKey:@"showDetailControllerCount"];
    }
   
    //action
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissToViewControler:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [scrollView addGestureRecognizer:recognizer];
}

#pragma mark -底部按钮点击
- (void)buttonClick:(UIButton *)button
{
    switch (button.tag) {
        case 0:
            [self changeDifferentDevice];
            break;
        case 1:
            [self previewPicture];
            break;
        case 2:
            [self savePhoto];
            break;
        case 3:
            [self moreOptions];
            break;
        default:
            break;
    }
}

//更换不同的设备
- (void)changeDifferentDevice
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择壁纸尺寸" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *iPhoneAction = [UIAlertAction actionWithTitle:@"iPhone" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.showMode = ImageViewShowModeIPhone;
    }];
    UIAlertAction *orginAction = [UIAlertAction actionWithTitle:@"原图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.showMode = ImageViewShowModeOrgin;
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:iPhoneAction];
    [alertController addAction:orginAction];
    if (self.showMode == ImageViewShowModeOrgin) {
        [orginAction setValue:[NSNumber numberWithBool:YES] forKey:@"_checked"];
        [iPhoneAction setValue:[NSNumber numberWithBool:NO] forKey:@"_checked"];
    }else
    {
        [iPhoneAction setValue:[NSNumber numberWithBool:YES] forKey:@"_checked"];
        [orginAction setValue:[NSNumber numberWithBool:NO] forKey:@"_checked"];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

//预览壁纸
- (void)previewPicture
{
    if (self.showMode != ImageViewShowModeIPhone) {
        //展示提示
        return;
    }
    [self.coverImageView.layer addAnimation:[self createTransitionAnimation] forKey:nil];
    
    NSArray *array = @[[UIImage imageNamed:@"yulanzuomian"],[UIImage imageNamed:@"suoping"]];
    if (self.coverImageView.image == nil) {
        self.coverImageView.image = array[0];
    }else
    {
        for (NSInteger i = 0;i < array.count;i++) {
            UIImage *image = array[i];
            if ([image isEqual:self.coverImageView.image]) {
                if (i == array.count - 1) {
                    self.coverImageView.image = nil;
                    break;
                }else
                {
                    self.coverImageView.image = array[i + 1];
                    break;
                }
            }
        }
    }
}

//下载壁纸
- (void)savePhoto
{
    switch (self.showMode) {
        case ImageViewShowModeIPhone:
        {
            CGSize imageSize = self.showImage.size;
            float imageX = (SCREENWIDTH - SCREENWIDTH * (SCREENHEIGHT - BOTTOMHEIGHT)/SCREENHEIGHT) * 0.5;
            float imageW = imageSize.width * (SCREENHEIGHT - BOTTOMHEIGHT)/imageSize.height;
            
            float clipImageX = imageSize.width * self.scrollView.contentOffset.x/imageW;
            float clipImageW = imageSize.width * (self.scrollView.frame.size.width - 2 * imageX)/imageW;
            CGRect rect = CGRectMake(clipImageX * self.showImage.scale, 0, clipImageW, imageSize.height);
            UIImage *clipImage = [self.showImage getSubImage:rect];
            [self saveImageToPhotosWithImage:clipImage];
        }
            break;
        case ImageViewShowModeOrgin:
        {
            [self saveImageToPhotosWithImage:self.showImage];
        }
            break;
        default:
            break;
    }
}

-(void) saveImageToPhotosWithImage:(UIImage *)image
{
    [AddPhoneAlbumTool createAlbumInPhoneAlbumWithImage:image completionBlock:^{
        NSString *successStr = @"保存成功";
//        NSString *failStr = @"保存失败";
        NSString *okStr = @"好的";
        NSString *openPhoto = @"打开相册";
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        alertController.title = successStr;
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:okStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:openPhoto style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"photos-redirect://"]];
        }];
        [alertController addAction:okAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

//更多选项
- (void)moreOptions
{
    [self.optionView show];
}

#pragma mark - 更多页面cell点击
/** 请喝咖啡 */
-(void)pleaseAuthorDrinkCoffee
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://qr.alipay.com/aptk8zgk0a7xtf6xdb"]];
}

/** 分享朋友 */
-(void)shareToFriends
{
    UIActivityViewController *activeViewController = [[UIActivityViewController alloc]initWithActivityItems:@[[UIImage imageNamed:@"mw@2x "],@"Magnetic Wall",[NSURL URLWithString:@"http://fir.im/dpn9"]] applicationActivities:nil];
    //不显示哪些分享平台(具体支持那些平台，可以查看Xcode的api)
    activeViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
    [self presentViewController:activeViewController animated:YES completion:nil];
    //分享结果回调方法
    UIActivityViewControllerCompletionWithItemsHandler myblock = ^(NSString *activityType, BOOL completed, NSArray * returnedItems, NSError * activityError){
        
    };
    activeViewController.completionWithItemsHandler = myblock;
}

/** 评论 */
-(void)giveCommentToMagneticWall
{
    //暂时换成提示框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    alertController.title = @"上线中，敬请期待";
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

/** 反馈 */
-(void)sendEMailToCanoe
{
    if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
        [self sendEmailAction]; // 调用发送邮件的代码
    }
}

/** 跳转博客 */
-(void)jumpToCanoesBlog
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://xcanoe.top"]];
}


#pragma mark -反馈发送邮件
- (void)sendEmailAction
{
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置邮件主题
    [mailCompose setSubject:@"Magnetic Wall 反馈信息"];
    // 设置收件人
    [mailCompose setToRecipients:@[@"canoe_likecode@163.com"]];
    // 设置正文内容
    NSString *emailContent = @"->请尽可能详细的描述你所遇到的问题或者给我的建议，我会认真阅读回复您，谢谢。";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 弹出邮件发送视图
    [self presentViewController:mailCompose animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
 动画类型
 fade 淡出效果
 moveIn 新视图移动到旧视图
 push   新视图推出旧视图
 reveal 移开旧视图
 cube   立方体翻转效果
 oglFlip    翻转效果
 suckEffect 收缩效果
 rippleEffect   水滴波纹效果
 pageCurl   向下翻页
 pageUnCurl 向上翻页
 */
-(CATransition *)createTransitionAnimation
{
    NSArray *array = @[@"fade",@"rippleEffect"];
    //创建CATransition动画对象
    CATransition *animation = [CATransition animation];
    //设置动画的类型:
    animation.type = array[arc4random() % 2];
    //设置动画的方向
    animation.subtype = kCATransitionFromRight;
    //设置动画的持续时间
    animation.duration = 0.8;
    //设置动画速率(可变的)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    //动画添加到切换的过程中
    return animation;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dismissToViewControler:(UISwipeGestureRecognizer *)recoginer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 3DTouch
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"保存图片" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self savePhoto];
    }];
    
    // 可以添加多个选项
    
    NSArray *arr = @[action1];
    
    return arr;
}

@end

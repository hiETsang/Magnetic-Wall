//
//  MoreOptionsView.m
//  Fresh Wall
//
//  Created by 肖坚伟 on 16/5/2.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import "MoreOptionsView.h"
#import "OptionsHeaderView.h"
#import "OptionsFooterView.h"
#import "OptionViewCell.h"

#define TIME 0.3

@interface MoreOptionsView ()<UITableViewDelegate,UITableViewDataSource>

//返回按钮
@property (nonatomic , strong) UIButton *backButton;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic ,strong) NSArray *dataArray;


@end

@implementation MoreOptionsView

-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[@"请喝饮料",@"分享给朋友",@"去App Store评论",@"反馈"];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)show
{
    [UIView animateWithDuration:TIME animations:^{
        self.frame  = self.superview.bounds;
    }];
}

-(void)hide
{
    [UIView animateWithDuration:TIME animations:^{
        self.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT);
    }];
}

- (void)createUI
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.bounds;
    [self addSubview:effectView];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:self.tableView];
    
    //backButton
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(24, 24, 25, 25);
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backToDetailView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    
    OptionsHeaderView *headerView = [OptionsHeaderView optionsHeaderView];
    headerView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 347);
    self.tableView.tableHeaderView = headerView;
    
    OptionsFooterView *footerView = [OptionsFooterView optionsFooterView];
    footerView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 70);
    self.tableView.tableFooterView = footerView;
    
    __weak typeof(self) weakSelf = self;
    [footerView setJumpToMyBlog:^(OptionsFooterView *view) {
        [weakSelf.delegate jumpToCanoesBlog];
    }];
}


#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionViewCell *cell = [OptionViewCell optionCellWithTableView:tableView];
    cell.titleLabel.text = self.dataArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            [self.delegate pleaseAuthorDrinkCoffee];
            break;
        case 1:
            [self.delegate shareToFriends];
            break;
        case 2:
            [self.delegate giveCommentToMagneticWall];
            break;
        case 3:
            [self.delegate sendEMailToCanoe];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)backToDetailView:(UIButton *)button
{
    [self hide];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= -120) {
        [self hide];
    }
}



@end

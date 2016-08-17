//
//  MJDIYHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJDIYHeader.h"
#import "DGActivityIndicatorView.h"
#import "UIView+Visible.h"

@interface MJDIYHeader()
@property (weak, nonatomic) DGActivityIndicatorView *activityIndicatorView;

@property (nonatomic ,strong) NSArray *typeArray;
@end

@implementation MJDIYHeader

-(NSArray *)typeArray
{
    if (_typeArray == nil) {
        _typeArray = @[@(DGActivityIndicatorAnimationTypeNineDots), @(DGActivityIndicatorAnimationTypeTriplePulse),
                       @(DGActivityIndicatorAnimationTypeFiveDots), @(DGActivityIndicatorAnimationTypeRotatingSquares),
                       @(DGActivityIndicatorAnimationTypeDoubleBounce), @(DGActivityIndicatorAnimationTypeTwoDots)];
    }
    return _typeArray;
}
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)[self.typeArray[arc4random() % 6] integerValue] tintColor:[UIColor whiteColor] size:20.0f];
    self.activityIndicatorView = activityIndicatorView;
    [self addSubview:activityIndicatorView];
    [self.activityIndicatorView startAnimating];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.activityIndicatorView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
//        NSLog(@"大小 ---------> %@",change);
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
//    NSLog(@"状态 ---------> %@",change);
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;

    switch (state) {
        case MJRefreshStateIdle:

            break;
        case MJRefreshStatePulling:

            break;
        case MJRefreshStateRefreshing:

            break;
            case MJRefreshStateNoMoreData:
            
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}

@end

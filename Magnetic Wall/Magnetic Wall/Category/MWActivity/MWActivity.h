//
//  MWActivity.h
//  Magnetic Wall
//
//  Created by 肖坚伟 on 16/5/13.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWActivity : UIActivity
///**
//这个方法就是告诉系统这个 Activity 是 Action 类型还是 Share 类型，默认是 Action，所以我们这里要返回 UIActivityCategoryShare。
// */
//+ (UIActivityCategory)activityCategory;
///**
//用来区分不同 activity 的字符串，用你的 bundle id 做前缀就会避免冲突
// */
//- (NSString *)activityType;
///**
//显示在选项图标下的文字
// */
//- (NSString *)activityTitle;
///**
//图标素材，这里要注意的是，目前只有 iOS 8 才支持显示彩色的图标，在这之前，你所提供的素材其实是作为 mask 来使用的，显示的则是黑白效果
// */
//- (UIImage *)activityImage;
///**
//这里就是你通过 items 来判断当前 Activity 是否支持，如果不支持（返回No），则当前选项不会在界面中显示出来
// */
//- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems;
///**
//为分享做准备，你必须在这里把这些 items 保存下来，然后做一些适当的准备工作
// */
//- (void)prepareWithActivityItems:(NSArray *)activityItems;
///**
//真正执行 share 动作的地方，这里要注意的是，不管分享成功与否，都要在结束后调用
// */
//- (void)performActivity;
@end

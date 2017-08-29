//
//  AppDelegate.m
//  Fresh Wall
//
//  Created by 肖坚伟 on 16/4/9.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import "AppDelegate.h"
#import <MobAPI/MobAPI.h>
#import "XViewController.h"
#import "WXTwitterLikeZoomer.h"

@interface AppDelegate ()
@property (strong, nonatomic) WXTwitterLikeZoomer *zoomer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //mob
    [MobAPI registerApp:@"127b6ae13968c"];
    
    //分享
    [OpenShare connectQQWithAppId:@"1103194207"];
    [OpenShare connectWeiboWithAppKey:@"402180334"];
    [OpenShare connectWeixinWithAppId:@"wxd930ea5d5a258f4f"];
    [OpenShare connectRenrenWithAppId:@"228525" AndAppKey:@"1dd8cba4215d4d4ab96a49d3058c1d7f"];
    
    //3Dtouch
    //催更
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"notification" localizedTitle:@"催更" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"notification"] userInfo:nil];
    //喜欢
    UIApplicationShortcutItem * itemThird = [[UIApplicationShortcutItem alloc]initWithType:@"love" localizedTitle:@"喜欢" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"favorite"] userInfo:nil];
    [UIApplication sharedApplication].shortcutItems = @[item, itemThird];

    //初始化controller
    XViewController *viewController = [[XViewController alloc] initWithNibName:NSStringFromClass([XViewController class]) bundle:nil];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    
    //启动画面
    self.zoomer = [WXTwitterLikeZoomer addToView:viewController.view withImage:[UIImage imageNamed:@"gengduologo"] backgroundColor:[UIColor blackColor]];
    [self.zoomer startAnimation];

    return YES;
}


/** 3Dtouch点击触发 */
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    
    //判断唯一标识
    //提醒更新
    if([shortcutItem.type isEqualToString:@"notification"]){
        [OpenShare chatWithQQNumber:@"781276284"];
    }
    //喜欢
    if ([shortcutItem.type isEqualToString:@"love"]) {
        //暂时换成提示框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        alertController.title = @"上线中，敬请期待";
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:okAction];
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    }else
    {
        return NO;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

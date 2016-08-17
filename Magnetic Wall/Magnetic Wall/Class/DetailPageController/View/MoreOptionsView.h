//
//  MoreOptionsView.h
//  Fresh Wall
//
//  Created by 肖坚伟 on 16/5/2.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreOptionsViewDelegate <NSObject>

-(void)pleaseAuthorDrinkCoffee;

-(void)shareToFriends;

-(void)giveCommentToMagneticWall;

-(void)sendEMailToCanoe;

-(void)jumpToCanoesBlog;

@end

@interface MoreOptionsView : UIView

@property (nonatomic ,weak) id <MoreOptionsViewDelegate> delegate;

-(void)show;

-(void)hide;

@end

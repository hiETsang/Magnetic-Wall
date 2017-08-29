//
//  OptionsFooterView.h
//  Magnetic Wall
//
//  Created by 肖坚伟 on 16/5/9.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionsFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *tipButton;
@property (weak, nonatomic) IBOutlet UIImageView *jumpImageView;

/** 点击回调 */
@property (nonatomic,copy) void (^jumpToMyBlog)(id);

+(id)optionsFooterView;

@end

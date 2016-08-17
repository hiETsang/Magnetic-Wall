//
//  DetailViewController.h
//  Fresh Wall
//
//  Created by 肖坚伟 on 16/4/27.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImageViewShowMode) {
    ImageViewShowModeIPhone,
    ImageViewShowModeOrgin,
};

@interface DetailViewController : UIViewController

@property (nonatomic ,strong) UIImage *showImage;

@property (nonatomic ,assign) ImageViewShowMode showMode;

@end

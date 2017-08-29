//
//  OptionsHeaderView.h
//  Magnetic Wall
//
//  Created by 肖坚伟 on 16/5/9.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionsHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

+ (id)optionsHeaderView;

@end

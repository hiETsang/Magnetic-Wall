//
//  OptionsHeaderView.m
//  Magnetic Wall
//
//  Created by 肖坚伟 on 16/5/9.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import "OptionsHeaderView.h"

@implementation OptionsHeaderView

+(id)optionsHeaderView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

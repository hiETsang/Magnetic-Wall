//
//  MWActivity.m
//  Magnetic Wall
//
//  Created by 肖坚伟 on 16/5/13.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import "MWActivity.h"

@implementation MWActivity

+(UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

-(NSString *)activityTitle
{
    return @"Magnetic Wall";
}

-(NSString *)activityType
{
    return @"canoe.Magnetic-Wall";
}

-(UIImage *)activityImage
{
    return [UIImage imageNamed:@"mw@2x "];
}

@end

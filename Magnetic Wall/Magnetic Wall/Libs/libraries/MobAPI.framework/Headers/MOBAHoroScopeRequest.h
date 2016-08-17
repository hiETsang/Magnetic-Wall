//
//  MOBAHoroScopeRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBAHoroScopeRequest : MOBARequest

/**
 *  八字信息查询
 *
 *  @param date 生日日期(年的范围1900-2099)，格式:yyyy-MM-dd，必填项，不允许为nil
 *  @param hour 出生的小时时间，必填项，不允许为nil
 *
 *  @return 请求对象
 */
+ (MOBAHoroScopeRequest *)horoScopeRequestWithDate:(NSString *)date hour:(NSString *)hour;

@end

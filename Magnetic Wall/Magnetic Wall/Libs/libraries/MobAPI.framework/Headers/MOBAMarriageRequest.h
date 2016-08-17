//
//  MOBAMarriageRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBAMarriageRequest : MOBARequest

/**
 *  婚姻匹配查询
 *
 *  @param manDate   男出生日期(年范围1900-2099)，格式:yyyy-MM-dd，必填项，不允许为nil
 *  @param manHour   	男：出生小时时间(数据：0-23之间)，必填项，不允许为nil
 *  @param womanDate 出生日期(年范围1900-2099)，格式:yyyy-MM-dd，必填项，不允许为nil
 *  @param womanHour 出生小时时间(数据：0-23之间)，必填项，不允许为nil
 *
 *  @return 请求的对象
 */
+ (MOBAMarriageRequest *)marriageRequestWithManDate:(NSString *)manDate
                                            manHour:(NSString *)manHour
                                          womanDate:(NSString *)womanDate
                                          womanHour:(NSString *)womanHour;

@end

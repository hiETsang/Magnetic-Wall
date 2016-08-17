//
//  MOBABoxOfficeRequest.h
//  MobAPI
//
//  Created by ShengQiangLiu on 16/3/30.
//  Copyright © 2016年 mob. All rights reserved.
//

#import <MobAPI/MobAPI.h>

@interface MOBABoxOfficeRequest : MOBARequest

/**
 *  实时票房查询
 *
 *  @param area 查询地区（内地=CN,北美=US,香港=HK），目前仅支持内地。必填参数，不允许为nil
 *
 *  @return 请求对象
 */
+ (MOBABoxOfficeRequest *) boxofficeDayRequestByArea:(NSString *)area;

/**
 *  周票房查询
 *
 *  @param area 查询地区（内地=CN,北美=US,香港=HK），目前仅支持内地和香港。必填参数，不允许为nil
 *
 *  @return 请求对象
 */
+ (MOBABoxOfficeRequest *) boxofficeWeekRequestByArea:(NSString *)area;

/**
 *  周末票房查询
 *
 *  @param area 查询地区（内地=CN,北美=US,香港=HK），目前仅支持内地和香港。必填参数，不允许为nil
 *
 *  @return 请求对象
 */
+ (MOBABoxOfficeRequest *) boxofficeWeekEndRequestByArea:(NSString *)area;


@end

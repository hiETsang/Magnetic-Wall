//
//  MOBAHistoryRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBAHistoryRequest : MOBARequest

/**
 *  历史上的今天查询
 *
 *  @param day 日期(格式:MMdd)，必填项，不允许为nil
 *
 *  @return 请求的对象
 */
+ (MOBAHistoryRequest *)historyRequestWithDay:(NSString *)day;

@end

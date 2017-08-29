//
//  MOBALaohuangliRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBALaohuangliRequest : MOBARequest

/**
 *  老黄历信息查询
 *
 *  @param date 日期(日期年的范围1900-2099)，格式:yyyy-MM-dd，必填项，不允许为nil
 *
 *  @return 请求的对象
 */
+ (MOBALaohuangliRequest *)laohuangliRequestWithDate:(NSString *)date;

@end

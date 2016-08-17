//
//  MOBADreamRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBADreamRequest : MOBARequest

/**
 *  周公解梦查询
 *
 *  @param name 梦源关键字，必填项，不允许为nil
 *  @param page 当前页（默认为1）
 *  @param size 每页显示大小（默认为20）
 *
 *  @return 请求的对象
 */
+ (MOBADreamRequest *)dreamRequestWithKeyword:(NSString *)name
                                         page:(NSString *)page
                                         size:(NSString *)size;

@end

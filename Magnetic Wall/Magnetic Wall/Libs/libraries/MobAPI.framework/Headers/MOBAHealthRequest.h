//
//  MOBAHealthRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBAHealthRequest : MOBARequest

/**
 *  健康知识查询
 *
 *  @param name 关键字，必填项，不允许为nil
 *  @param page 当前页（默认为1）
 *  @param size 每页显示页大小（默认位20）
 *
 *  @return 请求的对象
 */
+ (MOBAHealthRequest *)healthRequestWithKeyword:(NSString *)name
                                           page:(NSString *)page
                                           size:(NSString *)size;

@end

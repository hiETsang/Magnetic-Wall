//
//  MOBAKvRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBAKvRequest : MOBARequest

/**
 *  k-v存储
 *
 *  @param table 集合名称，一个用户只能拥有5个自定义的table。必填项，不允许为nil
 *  @param k     标准base64编码，且为URLSafe模式。必填项，不允许为nil
 *  @param v     1、JSON数据格式的base64编码，且URLSafe模式   2、长度最大限制为2KB    必填项，不允许为nil
 *
 *  @return 请求的对象
 */
+ (MOBAKvRequest *)kvPutRequest:(NSString *)table
                            key:(NSString *)k
                          value:(NSString *)v;

/**
 *  k-v查询
 *
 *  @param table 集合名称。必填项，不允许为nil
 *  @param k     标准base64编码，且为URLSafe模式。必填项，不允许为nil
 *
 *  @return 请求的对象
 */
+ (MOBAKvRequest *)kvGetRequest:(NSString *)table key:(NSString *)k;

@end

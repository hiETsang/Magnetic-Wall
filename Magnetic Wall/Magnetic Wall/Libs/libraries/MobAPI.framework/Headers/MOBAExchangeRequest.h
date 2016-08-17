//
//  MOBAExchangeRequest.h
//  MobAPI
//
//  Created by ShengQiangLiu on 16/3/30.
//  Copyright © 2016年 mob. All rights reserved.
//

#import <MobAPI/MobAPI.h>

@interface MOBAExchangeRequest : MOBARequest

/**
 *  人民币汇率数据查询
 *
 *  @param bank 0:工商银行,1:招商银行,2:建设银行,3:中国银行,4:交通银行,5:农业银行, 默认为:中国银行 (不填默认是3:中国银行)。
 *
 *  @return 请求对象
 */
+ (MOBAExchangeRequest *) exchangeRmbQuotRequestByBank:(NSString *)bank;

/**
 *  主要国家货币代码查询
 *
 *  @return 请求对象
 */
+ (MOBAExchangeRequest *) exchangeCurrencyRequest;

/**
 *  根据货币代码查询汇率数据
 *
 *  @param code 两个国家货币代码 (比如CNYHKD)。必填参数，不允许为nil
 *
 *  @return 请求对象
 */
+ (MOBAExchangeRequest *) exchangeCodeRequestByCode:(NSString *)code;

/**
 *  分页查询汇率实时数据
 *
 *  @param page 当前页数，默认是1
 *  @param size 每页显示多少条记录，默认是50条记录
 *
 *  @return 请求对象
 */
+ (MOBAExchangeRequest *) exchangeByPage:(NSInteger)page size:(NSInteger)size;

@end

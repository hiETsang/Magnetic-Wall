//
//  MOBApiCloud.h
//  MOBApiCloud
//
//  Created by fenghj on 15/10/9.
//  Copyright © 2015年 mob. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MOBARequest.h"
#import "MOBAPostcodeRequest.h"
#import "MOBAPhoneRequest.h"
#import "MOBACookRequest.h"
#import "MOBAWeatherRequest.h"
#import "MOBAIdRequest.h"
#import "MOBAStationRequest.h"
#import "MOBAEnvironmentRequest.h"
#import "MOBAIpRequest.h"
#import "MOBAKvRequest.h"
#import "MOBACalendarRequest.h"
#import "MOBAMobileLuckyRequest.h"
#import "MOBABankCardRequest.h"
#import "MOBALaohuangliRequest.h"
#import "MOBAHealthRequest.h"
#import "MOBAMarriageRequest.h"
#import "MOBAHistoryRequest.h"
#import "MOBADreamRequest.h"
#import "MOBAIdiomRequest.h"
#import "MOBADictionaryRequest.h"
#import "MOBAHoroScopeRequest.h"
#import "MOBAProvinceoilRequest.h"
#import "MOBALotteryRequest.h"
#import "MOBAWxArticleRequest.h"
#import "MOBABoxOfficeRequest.h"
#import "MOBAGoldRequest.h"
#import "MOBAExchangeRequest.h"

#import "MOBAResponse.h"

/**
 *  MOB云Api
 *
 *  @author vimfung
 */
@interface MobAPI : NSObject

/**
 *  注册应用, 只允许调用一次
 *
 *  @param appKey 应用Key
 */
+ (void) registerApp:(NSString *)appKey;

/**
 *  发送请求
 *
 *  @param request       请求信息
 *  @param resultHandler 返回回调事件处理
 */
+ (void) sendRequest:(MOBARequest *)request
            onResult:(void(^)(MOBAResponse *response))resultHandler;

/**
 *  自定义接口发送请求
 *
 *  @author liyc
 *
 *  @param interface     接口名称
 *  @param param         参数
 *  @param resultHandler 返回回调事件处理
 */
+ (void) sendRequestWithInterface:(NSString *)interface
                            param:(NSDictionary *)param
                         onResult:(void (^)(MOBAResponse *response))resultHandler;

/**
 *  api查询请求
 *
 *  @param resultHandler 返回回调事件处理
 */
+ (void) apiQueryWithResult:(void (^)(MOBAResponse *response))resultHandler;

@end

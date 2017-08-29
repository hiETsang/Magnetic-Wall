//
//  MOBAGoldRequest.h
//  MobAPI
//
//  Created by ShengQiangLiu on 16/3/30.
//  Copyright © 2016年 mob. All rights reserved.
//

#import <MobAPI/MobAPI.h>

@interface MOBAGoldRequest : MOBARequest

/**
 *  期货黄金数据查询
 *
 *  @return 请求的对象
 */
+ (MOBAGoldRequest *) goldFutureRequest;

/**
 *  现货黄金实时数据查询
 *
 *  @return 请求的对象
 */
+ (MOBAGoldRequest *) goldSpotRequest;

@end

//
//  MOBAIpRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBAIpRequest : MOBARequest

/**
 *  查询IP对应的省市区信息
 *
 *  @param ip 	要查询的IP地址，必填项，不允许为nil
 *
 *  @return 请求的对象
 */
+ (MOBAIpRequest *) addressRequestForIp:(NSString *)ip;

@end

//
//  MOBABankCardRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBABankCardRequest : MOBARequest

/**
 *  银行卡信息查询
 *
 *  @param card 银行卡号，必填项，不允许为nil
 *
 *  @return 请求的对象
 */
+ (MOBABankCardRequest *)bankCardRequestWithCard:(NSString *)card;

@end

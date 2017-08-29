//
//  MOBAMobileLuckyRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBAMobileLuckyRequest : MOBARequest

/**
 *  手机号码查吉凶
 *
 *  @param mobile 手机号，必填项，不允许为nil
 *
 *  @return 请求的对象
 */
+ (MOBAMobileLuckyRequest *)mobileLuckyRequestByMobile:(NSString *)mobile;

@end

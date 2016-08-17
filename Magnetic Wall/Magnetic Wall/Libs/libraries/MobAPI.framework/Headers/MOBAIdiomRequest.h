//
//  MOBAIdiomRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBAIdiomRequest : MOBARequest

/**
 *  成语查询
 *
 *  @param name 成语(全称)，必填项，不允许为nil
 *
 *  @return 请求对象
 */
+ (MOBAIdiomRequest *)idiomRequestWithName:(NSString *)name;

@end

//
//  MOBADictionaryRequest.h
//  MobAPI
//
//  Created by liyc on 16/2/16.
//  Copyright © 2016年 mob. All rights reserved.
//

#import "MOBARequest.h"

@interface MOBADictionaryRequest : MOBARequest

/**
 *  新华字典查询
 *
 *  @param name 要查询的汉字，必填项，不允许为nil
 *
 *  @return 请求的对象
 */
+ (MOBADictionaryRequest *)dictionaryRequestWithName:(NSString *)name;

@end

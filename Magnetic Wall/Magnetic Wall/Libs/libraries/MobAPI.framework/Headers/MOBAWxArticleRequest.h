//
//  MOBAWxArticleRequest.h
//  MobAPI
//
//  Created by ShengQiangLiu on 16/3/30.
//  Copyright © 2016年 mob. All rights reserved.
//

#import <MobAPI/MobAPI.h>

@interface MOBAWxArticleRequest : MOBARequest

/**
 *  微信精选分类查询
 *
 *  @return 请求对象
 */
+ (MOBAWxArticleRequest *) wxarticleCategoryRequest;

/**
 *  微信精选列表查询
 *
 *  @param cid  分类id，必填项，不允许为nil
 *  @param page 起始页，默认为1
 *  @param size 每页显示数，默认为20
 *
 *  @return 请求对象
 */
+ (MOBAWxArticleRequest *) wxarticleListRequestByCID:(NSString *)cid
                                                page:(NSInteger)page
                                                size:(NSInteger)size;

@end

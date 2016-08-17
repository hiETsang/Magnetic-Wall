//
//  AddPhoneAlbumTool.h
//  Magnetic Wall
//
//  Created by 肖坚伟 on 16/5/13.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddPhoneAlbumTool : NSObject

+ (void)createAlbumInPhoneAlbumWithImage:(UIImage *)image completionBlock:(void (^)(void))completionBlock;

@end

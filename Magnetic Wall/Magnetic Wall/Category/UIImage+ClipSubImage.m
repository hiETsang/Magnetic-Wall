//
//  UIImage+ClipSubImage.m
//  Magnetic Wall
//
//  Created by 肖坚伟 on 16/5/4.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import "UIImage+ClipSubImage.h"

@implementation UIImage (ClipSubImage)

//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage,
                                                          CGRectMake(rect.origin.x,
                                                                     rect.origin.y,
                                                                     rect.size.width * self.scale,
                                                                     rect.size.height * self.scale));
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    //UIGraphicsBeginImageContext(smallBounds.size);
    UIGraphicsBeginImageContextWithOptions(smallBounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}


@end

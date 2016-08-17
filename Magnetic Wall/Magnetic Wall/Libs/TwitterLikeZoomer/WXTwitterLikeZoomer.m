//
//  WXTwitterLikeZoomer.m
//  TwitterLikeStartup
//
//  Created by Welkin Xie on 4/25/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  https://github.com/WelkinXie/WXTwitterLikeZoomer
//

#import "WXTwitterLikeZoomer.h"

@interface WXTwitterLikeZoomer ()

@property (weak, nonatomic) UIView *view;
@property (strong, nonatomic) UIImageView *imageView;
@property (nonatomic ,strong) UIImageView *bgImageView;

@end

@implementation WXTwitterLikeZoomer

+ (instancetype)addToView:(UIView *)view withImage:(UIImage *)image backgroundColor:(UIColor *)backgroundColor {
    WXTwitterLikeZoomer *zoomer = [[WXTwitterLikeZoomer alloc] initWithFrame:view.frame];
    zoomer.view = view;
    zoomer.imageView = [[UIImageView alloc] initWithImage:image];
    zoomer.imageView.frame = CGRectMake(0, 0, 90, 90);
    zoomer.imageView.center = view.center;
    zoomer.backgroundColor = backgroundColor;
    zoomer.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic23.jpg"]];
    zoomer.bgImageView.frame = view.bounds;
    zoomer.bgImageView.alpha = 0.0;
    zoomer.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [zoomer addSubview:zoomer.bgImageView];
    [zoomer addSubview:zoomer.imageView];
    [view addSubview:zoomer];
    return zoomer;
}

- (void)startAnimation {
    [self zoomOut];
}

- (void)zoomOut {
    [UIView animateWithDuration:0.3 animations:^{
//        self.imageView.frame = CGRectMake(0, 0, 60, 60);
//        self.imageView.center = self.view.center;
        self.bgImageView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(zoomIn) withObject:nil afterDelay:1.0];
    }];
}

- (void)zoomIn {
    [UIView animateWithDuration:1.0 animations:^{
        self.imageView.frame = CGRectMake(0, 0, 300, 300);
        self.imageView.center = self.view.center;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self animationFinished];
    }];
}

- (void)animationFinished {
    [self removeFromSuperview];
}

@end

//
//  XCollectionViewCell.m
//  Fresh Wall
//
//  Created by 肖坚伟 on 16/4/20.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import "XCollectionViewCell.h"

@interface XCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *overlayView;

@end

@implementation XCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    CGFloat featuredHeight = 280.f;
    CGFloat standardHeight = 100.f;
    
    CGFloat delta = 1 - ((featuredHeight - CGRectGetHeight(self.frame)) / (featuredHeight - standardHeight));
    
    CGFloat minAlpha = 0.0f;
    CGFloat maxAlpha = 0.6f;
    
    CGFloat alpha = maxAlpha - (delta * (maxAlpha - minAlpha));
    self.overlayView.alpha = alpha;
    
    CGFloat scale = MAX(delta, 0.5f);
    self.titleLabel.transform = CGAffineTransformMakeScale(scale, scale);
    
    self.descriptionLabel.alpha = delta;
}

@end

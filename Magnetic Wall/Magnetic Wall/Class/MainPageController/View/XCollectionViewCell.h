//
//  XCollectionViewCell.h
//  Fresh Wall
//
//  Created by 肖坚伟 on 16/4/20.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

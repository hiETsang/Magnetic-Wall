//
//  XCollectionView.m
//  Fresh Wall
//
//  Created by 肖坚伟 on 16/4/20.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import "XCollectionView.h"
#import "XCollectionViewCell.h"

#import "UIImageView+WebCache.h"

#import "SFFocusViewLayout.h"

CGFloat const kXFocusViewLayoutStandardHeight = 300;

static NSString * const kXCollectionViewReuseIdentifier = @"__kXCollectionViewReuseIdentifier";

@interface XCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation XCollectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpCollectionView];
    }
    return self;
}


-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self reloadData];
}

-(void)setUpCollectionView
{
    self.delegate = self;
    self.dataSource = self;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    
    UINib *collectionViewcellNib = [UINib nibWithNibName:NSStringFromClass(XCollectionViewCell.class)
                                                  bundle:nil];
    [self registerNib:collectionViewcellNib
          forCellWithReuseIdentifier:kXCollectionViewReuseIdentifier];
    
    self.backgroundColor = [UIColor clearColor];
}


#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXCollectionViewReuseIdentifier forIndexPath:indexPath];
    cell.backgroundImageView.contentMode = UIViewContentModeCenter;
    [cell.backgroundImageView sd_setImageWithURL:self.dataArray[indexPath.row] placeholderImage:[UIImage imageNamed:@"beijin"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            cell.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        }
    }];
    return cell;
}

#pragma mark - UICollectionViewDelegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SFFocusViewLayout *focusViewLayout = (SFFocusViewLayout *)collectionView.collectionViewLayout;
    
    CGFloat offset = focusViewLayout.dragOffset * indexPath.item;
    if (collectionView.contentOffset.y != offset) {
        [collectionView setContentOffset:CGPointMake(0, offset) animated:YES];
    }else
    {
        //点击回调
        if (self.selectedItemClick) {
            self.selectedItemClick(indexPath.row);
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollViewDidScroll) {
        self.scrollViewDidScroll(scrollView);
    }
}

@end

//
//  XCollectionView.h
//  Fresh Wall
//
//  Created by 肖坚伟 on 16/4/20.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCollectionView : UICollectionView

@property (nonatomic ,strong) NSArray *dataArray;

/** 点击正在放大显示的图片 */
@property (nonatomic,copy) void (^selectedItemClick)(NSInteger index);
-(void)setSelectedItemClick:(void (^)(NSInteger index))selectedItemClick;

/** 滚动时回调，用于判断是否显示置顶按钮 */
@property (nonatomic,copy) void (^scrollViewDidScroll)(UIScrollView *scrollView);
- (void)setScrollViewDidScroll:(void (^)(UIScrollView * scrollView))scrollViewDidScroll;

-(void)setUpCollectionView;
@end

//
//  OptionViewCell.h
//  Magnetic Wall
//
//  Created by 肖坚伟 on 16/5/5.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (id)optionCellWithTableView:(UITableView *)tableView;

@end

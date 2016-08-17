//
//  OptionViewCell.m
//  Magnetic Wall
//
//  Created by 肖坚伟 on 16/5/5.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import "OptionViewCell.h"

@implementation OptionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(id)optionCellWithTableView:(UITableView *)tableView
{
    NSString *nibName = [NSString stringWithFormat:@"%@",self.class];
    [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
    return [tableView dequeueReusableCellWithIdentifier:nibName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

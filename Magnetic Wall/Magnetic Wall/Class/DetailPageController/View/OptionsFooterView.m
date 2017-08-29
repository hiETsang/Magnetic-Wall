//
//  OptionsFooterView.m
//  Magnetic Wall
//
//  Created by 肖坚伟 on 16/5/9.
//  Copyright © 2016年 轻舟. All rights reserved.
//

#import "OptionsFooterView.h"

@implementation OptionsFooterView

+(id)optionsFooterView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]lastObject];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //给按钮添加下划线
    [self makeDottedLine];
    //给图片添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToMyBlog:)];
    [self.jumpImageView addGestureRecognizer:tap];
}

#pragma mark 制作虚线
- (void)makeDottedLine{
    //lab
//    NSString *str = @"更多精彩 · 轻舟Canoe";
//    float strFont = 13.0f;
//    CGRect labRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:strFont]} context:nil];
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-labRect.size.width)/2, 100, labRect.size.width,labRect.size.height)];
//    lab.textColor = [UIColor whiteColor];
//    lab.text = str;
//    lab.font = [UIFont systemFontOfSize:strFont];
//    [self.view addSubview:lab];
    
    //layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.tipButton.bounds];
    [shapeLayer setPosition:self.tipButton.frame.origin];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    
    //设置虚线的颜色 - 颜色请必须设置
    [shapeLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
    
    //设置虚线的高度
    [shapeLayer setLineWidth:1.0f];
    
    //设置类型
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    /*
     10.f=每条虚线的长度
     3.f=每两条线的之间的间距
     */
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:5.f],
      [NSNumber numberWithInt:4.f],nil]];
    
    // Setup the path
    CGMutablePathRef path1 = CGPathCreateMutable();
    
    /*
     代表初始坐标的x，y
     x:写-2,是为了视觉上，虚线比文字稍长一点。
     y:要和下面的y一样。
     */
    CGPathMoveToPoint(path1, NULL,- 12 - self.tipButton.frame.size.width/2, 3);
    
    /*
     代表坐标的x，y
     lab.frame.size.width+2：我觉得他代表的意思可以理解为线的长度。
     lab.frame.size.height：要与上面的y大小一样，才能使平行的线，不然会画出斜线呦~
     */
    CGPathAddLineToPoint(path1, NULL, self.tipButton.frame.size.width/2 - 5,3);
    
    //赋值给shapeLayer
    [shapeLayer setPath:path1];
    
    //清除
    CGPathRelease(path1);
    
    //可以把self改成任何你想要的UIView.
    [[self.tipButton layer] addSublayer:shapeLayer];
    
}

- (IBAction)jumpToMyBlog:(id)sender {
    if (self.jumpToMyBlog) {
        self.jumpToMyBlog(self);
    }
    
}

@end

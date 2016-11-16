//
//  WeekTableViewCell.m
//  JNSL
//
//  Created by zw on 2016/11/14.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "WeekTableViewCell.h"

@implementation WeekTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)layoutSubviews
{
    [self addViews];
}
-(void)addViews
{
    NSInteger x=0;
    NSInteger h=self.frame.size.height;
    self.dayView1 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView1.delegate = self;
    [self addSubview:self.dayView1];
    
    x+=screenWidth/7;
    self.dayView2 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView2.delegate = self;
    [self addSubview:self.dayView2];
    
    x+=screenWidth/7;
    self.dayView3 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView3.delegate = self;
    [self addSubview:self.dayView3];
    
    x+=screenWidth/7;
    self.dayView4 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView4.delegate = self;
    [self addSubview:self.dayView4];
    
    x+=screenWidth/7;
    self.dayView5 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView5.delegate = self;
    [self addSubview:self.dayView5];
    
    x+=screenWidth/7;
    self.dayView6 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView6.delegate = self;
    [self addSubview:self.dayView6];
    
    x+=screenWidth/7;
    self.dayView7 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView7.delegate = self;
    [self addSubview:self.dayView7];
}
-(void)setDayDict:(NSDictionary*)dict
{
    
}
-(void)DayViewSelected:(NSInteger)dayNum
{
    [self.delegate WeekTableViewCellSelectedIndex:dayNum];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

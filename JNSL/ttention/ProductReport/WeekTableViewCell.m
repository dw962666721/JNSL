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
    self.dayView1.tag = 991;
    self.dayView1.delegate = self;
    [self addSubview:self.dayView1];
    
    x+=screenWidth/7;
    self.dayView2 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView2.delegate = self;
    self.dayView2.tag = 992;
    [self addSubview:self.dayView2];
    
    x+=screenWidth/7;
    self.dayView3 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView3.delegate = self;
    self.dayView3.tag = 993;
    [self addSubview:self.dayView3];
    
    x+=screenWidth/7;
    self.dayView4 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView4.delegate = self;
    self.dayView4.tag = 994;
    [self addSubview:self.dayView4];
    
    x+=screenWidth/7;
    self.dayView5 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView5.delegate = self;
    self.dayView5.tag = 995;
    [self addSubview:self.dayView5];
    
    x+=screenWidth/7;
    self.dayView6 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView6.delegate = self;
    self.dayView6.tag = 996;
    [self addSubview:self.dayView6];
    
    x+=screenWidth/7;
    self.dayView7 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView7.delegate = self;
    self.dayView7.tag = 997;
    [self addSubview:self.dayView7];
}
-(void)setDayDict:(NSMutableDictionary*)data
{
      for (NSInteger i =1; i<8; i++) {
          NSString *day = [data objectForKey:[NSString stringWithFormat:@"%ld",(long)i]];
          NSString *lastDay = [data objectForKey:@"totalDays"];
          DayView *dayView = [self viewWithTag:990+i];
          NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
          [dict setObject:day forKey:@"dayNum"];
          if (i==1) {
              [dict setObject:@"周报" forKey:@"weekReport"];
          }
          
          if (day==lastDay) {
              [dict setObject:@"月报" forKey:@"monthReport"];
          }
         
          [dayView setData:dict];
      }
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

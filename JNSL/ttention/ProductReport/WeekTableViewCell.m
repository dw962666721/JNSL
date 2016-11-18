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
    DayView *view1 =  [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    view1.tag = 991;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)];
    view1.userInteractionEnabled=YES;
    [view1 addGestureRecognizer:tap1];
    view1.delegate = self;
    [self addSubview:view1];
    self.dayView1 = view1;
    
    x+=screenWidth/7;
    self.dayView2 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView2.delegate = self;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)];
    self.dayView2.userInteractionEnabled=YES;
    [self.dayView2 addGestureRecognizer:tap2];
    self.dayView2.tag = 992;
    [self addSubview:self.dayView2];
    
    x+=screenWidth/7;
    self.dayView3 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView3.delegate = self;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)];
    self.dayView3.userInteractionEnabled=YES;
    [self.dayView3 addGestureRecognizer:tap3];
    self.dayView3.tag = 993;
    [self addSubview:self.dayView3];
    
    x+=screenWidth/7;
    self.dayView4 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView4.delegate = self;
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)];
    self.dayView4.userInteractionEnabled=YES;
    [self.dayView4 addGestureRecognizer:tap4];
    self.dayView4.tag = 994;
    [self addSubview:self.dayView4];
    
    x+=screenWidth/7;
    self.dayView5 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView5.delegate = self;
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)];
    self.dayView5.userInteractionEnabled=YES;
    [self.dayView5 addGestureRecognizer:tap5];
    self.dayView5.tag = 995;
    [self addSubview:self.dayView5];
    
    x+=screenWidth/7;
    self.dayView6 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView6.delegate = self;
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)];
    self.dayView6.userInteractionEnabled=YES;
    [self.dayView6 addGestureRecognizer:tap6];
    self.dayView6.tag = 996;
    [self addSubview:self.dayView6];
    
    x+=screenWidth/7;
    self.dayView7 = [[DayView alloc] initWithFrame:CGRectMake(x, 0, screenWidth/7, h)];
    self.dayView7.delegate = self;
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)];
    self.dayView7.userInteractionEnabled=YES;
    [self.dayView7 addGestureRecognizer:tap7];
    self.dayView7.tag = 997;
    [self addSubview:self.dayView7];
}
-(void)setDayDict:(NSMutableDictionary*)data
{
    self.dayData=data;
    self.frame = CGRectMake(0, 0, screenWidth, 60);
      for (NSInteger i =1; i<8; i++) {
          DayView *dayView = [self viewWithTag:990+i];
          NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
          dict=[self getDict:i data:self.dayData];
          [dayView setData:dict];
          dayView.dayData=dict;
      }
}
-(NSMutableDictionary*)getDict:(NSInteger)i data:(NSMutableDictionary*)data
{
    NSString *noUseDaysStr = [data objectForKey:@"unUseDays"];
    NSArray *unUseDaysArray = [noUseDaysStr componentsSeparatedByString:@"|"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *day = [data objectForKey:[NSString stringWithFormat:@"%ld",(long)i]];
    NSString *lastDay = [data objectForKey:@"totalDays"];
    
    [dict setObject:day forKey:@"dayNum"];
    if (i==1) {
        [dict setObject:@"周报" forKey:@"weekReport"];
    }
    
    if (day==lastDay) {
        [dict setObject:@"月报" forKey:@"monthReport"];
    }
    
    for (NSString *unDay in unUseDaysArray) {
        if (unDay==[NSString stringWithFormat:@"%d",day]) {
            [dict setObject:@"NO" forKey:@"noUseDay"];
        }
    }
    for (NSInteger j=0; j<unUseDaysArray.count; j++) {
        NSString *unDay=unUseDaysArray[j];
        if ([unDay compare:day]==NSOrderedSame) {
            [dict setObject:@"NO" forKey:@"noUseDay"];
            if (unUseDaysArray.count>1&&j==unUseDaysArray.count-1&&i!=7) {
                [dict setObject:@"月报" forKey:@"monthReport"];
            }
        }
    }
    return dict;
}
-(void)selectedAction:(UITapGestureRecognizer *)sender
{
    DayView *dayView = (DayView*)sender.view;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict=[self getDict:dayView.tag-990 data:self.dayData];
    if ([dict valueForKey:@"noUseDay"]) {
        return;
    }
    [dayView selected:YES];
     NSString *day = [self.dayData objectForKey:[NSString stringWithFormat:@"%d",dayView.tag-990]];
    [self.delegate WeekTableViewCellSelectedIndex:day.integerValue];
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

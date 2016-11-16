//
//  DayView.m
//  JNSL
//
//  Created by zw on 2016/11/14.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "DayView.h"

@implementation DayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UILabel*)dayLb
{
    if (!_dayLb) {
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 15)];
        label.text=@"1";
        [self addSubview:label];
        _dayLb=label;
    }
    return _dayLb;
}
-(UILabel*)dayReportLb
{
    if (!_dayReportLb) {
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.frame.size.width, 15)];
        label.text=@"日报";
        [self addSubview:label];
        _dayReportLb=label;
    }
    return _dayReportLb;
}
-(UILabel*)weekReportLb
{
    if (!_weekReportLb) {
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, 15)];
        label.text=@"周报";
        [self addSubview:label];
        _weekReportLb=label;
    }
    return _weekReportLb;
}
-(UILabel*)monthReportLb
{
    if (!_monthReportLb) {
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, 15)];
        label.text=@"月报";
        [self addSubview:label];
        _monthReportLb=label;
    }
    return _monthReportLb;
}
-(void)setData:(NSDictionary *)data
{
    if ([data valueForKey:@"dayNum"]) {
        self.dayLb.text=[data valueForKey:@"dayNum"];
    }
    
    if ([data valueForKey:@"dayReport"]) {
        self.dayReportLb.text=@"日报";
    }
    if ([data valueForKey:@"weekReport"]) {
        self.weekReportLb.text=@"周报";
    }
    
    if ([data valueForKey:@"monthReport"]) {
        self.monthReportLb.text=@"月报";
    }
}
@end

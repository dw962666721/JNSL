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
        if (IPHONE6PLUS||IPHONE6) {
            label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        }
        label.text=@"";
        label.textColor = ColorWithRGB(0x0079d9);
        label.textAlignment=NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:label];
        _dayLb=label;
    }
    return _dayLb;
}
-(UILabel*)dayReportLb
{
    if (!_dayReportLb) {
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.frame.size.width, 15)];
        if (IPHONE6PLUS||IPHONE6) {
            label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 20)];
        }
        label.text=@"日报";
        label.textAlignment=NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:label];
        _dayReportLb=label;
    }
    return _dayReportLb;
}
-(UILabel*)weekReportLb
{
    if (!_weekReportLb) {
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, 15)];
        if (IPHONE6PLUS||IPHONE6) {
            label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, 20)];
        }
        label.text=@"周报";
        label.textAlignment=NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:label];
        _weekReportLb=label;
    }
    return _weekReportLb;
}
-(UILabel*)monthReportLb
{
    if (!_monthReportLb) {
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, 15)];
        if (IPHONE6PLUS||IPHONE6) {
            label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, 20)];
        }
        label.text=@"月报";
        label.textAlignment=NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor = ColorWithRGB(0x0079d9);
        [self addSubview:label];
        _monthReportLb=label;
    }
    return _monthReportLb;
}
-(UILabel*)yearReportLb
{
    if (!_yearReportLb) {
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, 15)];
        if (IPHONE6PLUS||IPHONE6) {
            label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.frame.size.width, 20)];
        }
        label.text=@"年报";
        label.textAlignment=NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor = ColorWithRGB(0x0079d9);
        [self addSubview:label];
        _yearReportLb=label;
    }
    return _yearReportLb;
}

-(UIView*)selectedView
{
    if (!_selectedView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        if (IPHONE6PLUS||IPHONE6) {
            view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20*5)];
        }
        view.layer.cornerRadius = self.frame.size.width/2;
        view.backgroundColor = RGBA(70, 41, 244, 0.5);
        view.hidden=YES;
        [self addSubview:view];
        _selectedView=view;
    }
    return _selectedView;
}
-(NSMutableDictionary*)dayData
{
    if (!_dayData) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        _dayData=data;
    }
    return _dayData;
}
-(void)selected:(BOOL)selected
{
    if ([self.dayData valueForKey:@"noUseDay"]) {
        
    }
    else
    {
        if (selected) {
//            NSString *day = [self.dayData valueForKey:@"dayNum"];
//            [self.delegate DayViewSelected:day.integerValue];
        }
        [self sendSubviewToBack:self.selectedView];
//        self.selectedView.hidden=!selected;
        
    }
}
-(void)setData:(NSMutableDictionary*)data;
{
    self.dayData = data;
    if ([self.dayData valueForKey:@"dayNum"]) {
        self.dayLb.text=[self.dayData valueForKey:@"dayNum"];
    }
    
//    if ([data valueForKey:@"dayReport"]) {
        self.dayReportLb.text=@"日报";
//    }
    if ([self.dayData valueForKey:@"weekReport"]) {
        self.weekReportLb.text=@"周报";
    }
    else
    {
        self.weekReportLb.text=@"";

    }
    
    
    if ([self.dayData valueForKey:@"monthReport"]) {
        self.monthReportLb.text=@"月报";
    }
    else
    {
         self.monthReportLb.text=@"";
    }
    if([self.dayData valueForKey:@"yearReport"])
    {
        self.yearReportLb.text=@"年报";
    }
    else
    {
        self.yearReportLb.text=@"";
    }
    if ([self.dayData valueForKey:@"selected"]) {
        NSString *flag = [self.dayData valueForKey:@"selected"];
        if ([flag compare:@"YES"]==NSOrderedSame) {
           self.selectedView.hidden=NO;
        }
        else
        {
            self.selectedView.hidden=YES;
        }
    }
    else
    {
        self.selectedView.hidden = NO;
    }
    if ([self.dayData valueForKey:@"noUseDay"]) {
        NSString *day =[self.dayData valueForKey:@"noUseDay"];
        NSString *dayNum = [self.dayData valueForKey:@"dayNum"];
        if ([day compare:dayNum] == NSOrderedSame) {
            self.dayLb.textColor = [UIColor lightGrayColor];
            self.dayReportLb.textColor = [UIColor lightGrayColor];
            self.weekReportLb.textColor = [UIColor lightGrayColor];
            self.monthReportLb.textColor = [UIColor lightGrayColor];
            self.yearReportLb.textColor = [UIColor lightGrayColor];
            self.selectedView.hidden=YES;
        }
    }
    else
    {
        if ([self.dayData valueForKey:@"weekReport"]) {
            self.dayLb.textColor = [UIColor redColor];
            self.weekReportLb.textColor = [UIColor redColor];
            self.monthReportLb.textColor = [UIColor redColor];
            self.yearReportLb.textColor = [UIColor redColor];
        }
        else
        {
            self.dayLb.textColor = ColorWithRGB(0x0079d9);
            self.dayReportLb.textColor = [UIColor blackColor];
            self.weekReportLb.textColor = [UIColor blackColor];
            self.monthReportLb.textColor = ColorWithRGB(0x0079d9);
            self.yearReportLb.textColor = ColorWithRGB(0x0079d9);

        }
    }
    
}
@end

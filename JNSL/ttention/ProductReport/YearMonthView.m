//
//  YwaeMonthView.m
//  JNSL
//
//  Created by zw on 2016/11/12.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "YearMonthView.h"
#define H1 45
#define H2 25
@implementation YearMonthView
-(void)layoutSubviews
{
    self.yearMonthLb.backgroundColor = RGBA(245, 245, 245, 1);
    self.weekView.backgroundColor = [UIColor whiteColor];
    self.lastMonthImageView.image = [UIImage imageNamed:@"arrow_left3"];
    self.nextMonthImageView.image = [UIImage imageNamed:@"arrow_right"];
}
-(UILabel*)yearMonthLb
{
    if (!_yearMonthLb) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 45)];
        label.text=@"yyyy年MM月";
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = ColorWithRGB(0x0079d9);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _yearMonthLb = label;
    }
    return _yearMonthLb;
}
-(UIImageView*)lastMonthImageView
{
    if (!_lastMonthImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        imageView.image = [UIImage imageNamed:@"arrow_left3"];
        imageView.contentMode = UIViewContentModeCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lastMonth)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        _lastMonthImageView=imageView;
    }
    return _lastMonthImageView;
}
-(UIImageView*)nextMonthImageView
{
    if (!_nextMonthImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-80, 0, 80, 50)];
        imageView.image = [UIImage imageNamed:@"arrow_right"];
        imageView.contentMode = UIViewContentModeCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextMonth)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        _nextMonthImageView=imageView;
    }
    return _nextMonthImageView;
}
-(UIView*)weekView
{
    if (!_weekView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, H1, screenWidth, H2)];
        for (NSInteger i =0; i<7; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/7*i, 0, screenWidth/7, H2)];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            switch (i) {
                case 0:
                    label.text=@"日";
                    label.textColor = ColorWithRGB(0x0079d9);
                    break;
                case 1:
                    label.text=@"一";
                    break;
                case 2:
                    label.text=@"二";
                    break;
                case 3:
                    label.text=@"三";
                    break;
                case 4:
                    label.text=@"四";
                    break;
                case 5:
                    label.text=@"五";
                    break;
                case 6:
                    label.text=@"六";
                    break;
                default:
                    break;
            }
            [view addSubview:label];
        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, H2-1, screenWidth, 0.7)];
        line.layer.borderColor = [UIColor lightGrayColor].CGColor;
        line.layer.borderWidth=0.7;
        [view addSubview:line];
        [self addSubview:view];
        _weekView=view;
    }
    return _weekView;
}
// 上个月
-(void)lastMonth
{
    [self changeLastDateStr];
    [self.delegate YearMonthViewLastYear:self.dateStr];
}
// 下个月
-(void)nextMonth
{
    [self changeNextDateStr];
    [self.delegate YearMonthViewNextYear:self.dateStr];
}
// 上个月
-(void)changeLastDateStr
{
    NSArray *dateList = [self.dateStr componentsSeparatedByString:@"-"];
    if (dateList.count>=2) {
        NSInteger year = ((NSString*)dateList[0]).integerValue;
        NSInteger month = ((NSString*)dateList[1]).integerValue;
        if (month==1) {
            year-=1;
            month=12;
        }else
        {
            month-=1;
        }
        [self setCurrentDateStr:[NSString stringWithFormat:@"%ld%@%ld",(long)year,@"-",(long)month]];
    }
}
// 下个月
-(void)changeNextDateStr
{
    NSArray *dateList = [self.dateStr componentsSeparatedByString:@"-"];
    if (dateList.count>=2) {
        NSInteger year = ((NSString*)dateList[0]).integerValue;
        NSInteger month = ((NSString*)dateList[1]).integerValue;
        if (month==12) {
            year+=1;
            month=1;
        }else
        {
            month+=1;
        }
        [self setCurrentDateStr:[NSString stringWithFormat:@"%ld%@%ld",(long)year,@"-",(long)month]];
    }
}
-(void)setCurrentDateStr:(NSString *)dateStr
{
    self.dateStr = dateStr;
    NSArray *dateList = [self.dateStr componentsSeparatedByString:@"-"];
    if (dateList.count>=2) {
        self.yearMonthLb.text=[NSString stringWithFormat:@"%@%@%@%@",dateList[0],@"年",dateList[1],@"月"];
    }
}
-(NSString*)getDateStr
{
    return  self.dateStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

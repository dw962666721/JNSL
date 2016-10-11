//
//  MyMessageTableViewCell.m
//  JNSL
//
//  Created by zw on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "MyMessageTableViewCell.h"

@implementation MyMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(UILabel*)pollSourceNameLb
{
    if (!_pollSourceNameLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, self.frame.size.width, 20)];
        temp.tag = 990;
        temp.textColor = [UIColor blackColor];
        temp.font = [UIFont systemFontOfSize:12];
        temp.textAlignment=NSTextAlignmentCenter;
        [self addSubview:temp];
        _pollSourceNameLb = temp;
    }
    return _pollSourceNameLb;
}
-(UILabel*)facilityNameLb
{
    if (!_facilityNameLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
        temp.tag = 990;
        temp.textColor = [UIColor blackColor];;
        temp.font = [UIFont systemFontOfSize:11];
        temp.textAlignment=NSTextAlignmentCenter;
        [self addSubview:temp];
        _facilityNameLb = temp;
    }
    return _facilityNameLb;
}
-(UILabel*)alarmTypeNameLb
{
    if (!_alarmTypeNameLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
        temp.tag = 990;
        temp.textColor = [UIColor redColor];
        temp.font = [UIFont systemFontOfSize:11];
        temp.textAlignment=NSTextAlignmentCenter;
        [self addSubview:temp];
        _alarmTypeNameLb = temp;
    }
    return _alarmTypeNameLb;
}
-(UILabel*)alarmCausesLb
{
    if (!_alarmCausesLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
        temp.tag = 990;
        temp.textColor = TextColor;
        temp.font = [UIFont systemFontOfSize:11];
        temp.textAlignment=NSTextAlignmentCenter;
        [self addSubview:temp];
        _alarmCausesLb = temp;
    }
    return _alarmCausesLb;
}
-(UILabel*)beginDateLb
{
    if (!_beginDateLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
        temp.tag = 990;
        temp.textColor = TextColor;
        temp.font = [UIFont systemFontOfSize:10];
        temp.textAlignment=NSTextAlignmentLeft;
        [self addSubview:temp];
        _beginDateLb = temp;
    }
    return _beginDateLb;
}
-(UILabel*)endDateLb
{
    if (!_endDateLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
        temp.tag = 990;
        temp.textColor = TextColor;
        temp.font = [UIFont systemFontOfSize:10];
        temp.textAlignment=NSTextAlignmentRight;
        [self addSubview:temp];
        _endDateLb = temp;
    }
    return _endDateLb;
}
-(void)loadDate:(NSDictionary *)date
{
    self.backgroundColor = [UIColor whiteColor];
    if ([date objectForKey:@"pollSourceName"]) {
        self.pollSourceNameLb.text = [date objectForKey:@"pollSourceName"];
    }
    if ([date objectForKey:@"facilityName"]) {
        self.facilityNameLb.text = [date objectForKey:@"facilityName"];
    }
    if ([date objectForKey:@"alarmTypeName"]) {
                self.alarmTypeNameLb.text = [date objectForKey:@"alarmTypeName"];
    }
    if ([date objectForKey:@"alarmCauses"]) {
                self.alarmCausesLb.text = [NSString stringWithFormat:@"%@%@%@",@"(",[date objectForKey:@"alarmCauses"],@")"];
    }
    if ([date objectForKey:@"beginDate"]) {
                self.beginDateLb.text = [NSString stringWithFormat:@"%@%@",@"起:",[date objectForKey:@"beginDate"]];
    }
    if ([date objectForKey:@"endDate"]) {
                self.endDateLb.text = [NSString stringWithFormat:@"%@%@",@"止:",[date objectForKey:@"endDate"]];
    }
    
    CGSize pollSourceNameSize = [self.pollSourceNameLb.text sizeWithAttributes:@{NSFontAttributeName:self.pollSourceNameLb.font}];
    CGSize facilityNameSize = [self.facilityNameLb.text sizeWithAttributes:@{NSFontAttributeName:self.facilityNameLb.font}];
    CGSize alarmTypeNameSize = [self.alarmTypeNameLb.text sizeWithAttributes:@{NSFontAttributeName:self.alarmTypeNameLb.font}];
    CGSize endDateSize = [self.endDateLb.text sizeWithAttributes:@{NSFontAttributeName:self.endDateLb.font}];
    
    self.pollSourceNameLb.frame = CGRectMake(15, 10, pollSourceNameSize.width, pollSourceNameSize.height);
    self.facilityNameLb.frame = CGRectMake(self.pollSourceNameLb.frame.origin.x, CGRectGetMaxY(self.pollSourceNameLb.frame)+2, facilityNameSize.width, facilityNameSize.height);
    self.alarmTypeNameLb.frame = CGRectMake(screenWidth-15-alarmTypeNameSize.width, 10, alarmTypeNameSize.width, 15);
    self.alarmCausesLb.frame = CGRectMake(CGRectGetMaxX(self.facilityNameLb.frame), self.facilityNameLb.frame.origin.y, alarmTypeNameSize.width, 15);
    self.beginDateLb.frame = CGRectMake(self.pollSourceNameLb.frame.origin.x, CGRectGetMaxY(self.facilityNameLb.frame)+2, endDateSize.width+20, endDateSize.height);
    self.endDateLb.frame = CGRectMake(screenWidth - 15 - endDateSize.width, CGRectGetMaxY(self.facilityNameLb.frame)+2, endDateSize.width, endDateSize.height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

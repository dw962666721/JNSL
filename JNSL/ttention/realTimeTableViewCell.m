//
//  realTimeTableViewCell.m
//  JNSL
//
//  Created by zw on 16/10/14.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "realTimeTableViewCell.h"

@implementation realTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 20)];
        self.datastatue = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-100, 10, 100, 20)];
        self.datastatue.textColor = [UIColor redColor];
        self.jizu = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, 20)];
        self.jizu.font =[UIFont systemFontOfSize:14];
        self.sdate = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, screenWidth/2-10, 15)];
        self.edate = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2, 45, screenWidth/2, 15)];
        self.sdate.font =[UIFont systemFontOfSize:13];
        self.edate.font =[UIFont systemFontOfSize:13];
        self.sdate.textColor = [UIColor lightGrayColor];
        self.edate.textColor = [UIColor lightGrayColor];
        
        [self addSubview:self.name];
        [self addSubview:self.datastatue];
        [self addSubview:self.jizu];
        [self addSubview:self.sdate];
        [self addSubview:self.edate];
    }
    return self;
    
}

-(void)setData:(NSDictionary *)data{
    self.name.text = [data objectForKey:@"pollSourceName"];
    self.datastatue.text = [data objectForKey:@"alarmTypeName"];
    self.jizu.text = [data objectForKey:@"facilityName"];
    self.sdate.text = [data objectForKey:@"beginDate"];
    self.edate.text = [data objectForKey:@"endDate"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

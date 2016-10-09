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
-(void)addViews
{
    self.titleLb = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, self.frame.size.width, 15)];
    self.titleLb.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.titleLb];
    
    self.descriptionLb = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.titleLb.frame), self.frame.size.width, 10)];
    self.descriptionLb.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.descriptionLb];
}
-(void)loadDate:(NSDictionary *)date
{
    if ([date objectForKey:@""]) {
        self.titleLb.text = [date objectForKey:@""];
    }
    if ([date objectForKey:@""]) {
        self.descriptionLb.text = [date objectForKey:@""];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

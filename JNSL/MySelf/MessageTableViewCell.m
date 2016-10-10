//
//  MessageTableViewCell.m
//  JNSL
//
//  Created by zw on 16/10/9.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(UILabel*)titleLb
{
    if (!_titleLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
        temp.tag = 990;
        temp.textColor = [UIColor blackColor];
        temp.font = [UIFont systemFontOfSize:12];
        [self addSubview:temp];
        _titleLb = temp;
    }
    return _titleLb;
}

-(UILabel*)descriptionLb
{
    if (!_descriptionLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, self.frame.size.width, 15)];
        temp.tag = 990;
        temp.textColor = [UIColor lightGrayColor];
        temp.font = [UIFont systemFontOfSize:10];
        [self addSubview:temp];
        _descriptionLb = temp;
    }
    return _descriptionLb;
}
-(void)setData:(NSDictionary*)dict
{
    if ([dict objectForKey:@"problem"]) {
        self.titleLb.text = [dict objectForKey:@"problem"];
    }
    if ([dict objectForKey:@"answer"]) {
        self.descriptionLb.text = [dict objectForKey:@"answer"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

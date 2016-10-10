//
//  HomeDetailTableViewCell.m
//  JNSL
//
//  Created by zw on 16/10/10.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "HomeDetailTableViewCell.h"

@implementation HomeDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)layoutSubviews
{
    CGFloat lbwid1 = 50;
    CGFloat lbwid2 = (screenWidth-50*2)*2/3;
    CGFloat lbwid3 = (screenWidth-50*2)*1/3;
    CGFloat lbwid4 = 50;
    
    self.idLb.frame =  CGRectMake(0, 0, lbwid1, self.frame.size.height);
    self.nameLb.frame =  CGRectMake(CGRectGetMaxX(self.idLb.frame), 0, lbwid2, self.frame.size.height);
    self.valueLb.frame =  CGRectMake(CGRectGetMaxX(self.nameLb.frame), 0, lbwid3, self.frame.size.height);
    self.unitLb.frame =  CGRectMake(CGRectGetMaxX(self.valueLb.frame), 0, lbwid4, self.frame.size.height);
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.7, self.frame.size.width, 0.7)];
    line.layer.borderColor = [UIColor lightGrayColor].CGColor;
    line.layer.borderWidth=0.7;
    [self addSubview:line];
}
-(UILabel*)idLb
{
    if (!_idLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
        temp.tag = 990;
        temp.textColor = TextColor;
        temp.textAlignment=NSTextAlignmentCenter;
        temp.font = [UIFont systemFontOfSize:12];
        [self addSubview:temp];
        _idLb = temp;
    }
    return _idLb;
}

-(UILabel*)nameLb
{
    if (!_nameLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
        temp.tag = 990;
        temp.textColor = TextColor;
        temp.font = [UIFont systemFontOfSize:12];
        temp.textAlignment=NSTextAlignmentCenter;
        [self addSubview:temp];
        _nameLb = temp;
    }
    return _nameLb;
}

-(UILabel*)valueLb
{
    if (!_valueLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
        temp.tag = 990;
        temp.textColor = TextColor;
        temp.font = [UIFont systemFontOfSize:12];
        temp.textAlignment=NSTextAlignmentCenter;
        [self addSubview:temp];
        _valueLb = temp;
    }
    return _valueLb;
}

-(UILabel*)unitLb
{
    if (!_unitLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
        temp.tag = 990;
        temp.textColor = TextColor;
        temp.font = [UIFont systemFontOfSize:12];
        temp.textAlignment=NSTextAlignmentCenter;
        [self addSubview:temp];
        _unitLb = temp;
    }
    return _unitLb;
}
-(void)setCellData:(NSDictionary*)dict row:(NSInteger)row
{
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    dict1[@"id"]=@"1";
    dict1[@"name"]=@"热网供水温度";
    dict1[@"value"]=@"15.98";
    dict1[@"unit"]=@"C";
    if (row%2==0) {
        self.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.backgroundColor = RGBA(230, 230, 230, 1);
    }
    
    if ([dict1 objectForKey:@"id"]) {
        self.idLb.text = [dict1 objectForKey:@"id"];
    }
    if ([dict1 objectForKey:@"name"]) {
        self.nameLb.text = [dict1 objectForKey:@"name"];
    }

    if ([dict1 objectForKey:@"value"]) {
        self.valueLb.text = [dict1 objectForKey:@"value"];
    }
    
    if ([dict1 objectForKey:@"unit"]) {
        self.unitLb.text = [dict1 objectForKey:@"unit"];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

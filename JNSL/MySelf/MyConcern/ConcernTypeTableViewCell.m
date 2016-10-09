//
//  ConcernTypeTableViewCell.m
//  JNSL
//
//  Created by zw on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ConcernTypeTableViewCell.h"

@implementation ConcernTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//-(instancetype)init
//{
//    self = [super init];
//    return self;
//}
//-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    return self;
//}
//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    return self;
//}
//-(id)initWithFrame:(CGRect)frame
//{
//    self=[super initWithFrame:frame];
//    return self;
//}
-(void)layoutSubviews
{
    [self addViews];
}
-(UILabel*)titleLb
{
    if (!_titleLb) {
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(5, (self.frame.size.height-20)/2, self.frame.size.width-30, 20)];
        temp.font = [UIFont systemFontOfSize:11];
        temp.textColor =RGBA(118, 118, 118, 1);
        [self addSubview:temp];
        _titleLb = temp;
    }
    return _titleLb;
}
-(UIImageView*)rightImageView
{
    if (!_rightImageView) {
        UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-20, (self.frame.size.height-10)/2, 10, 10)];
        temp.tag = 990;
        temp.image = [UIImage imageNamed:@"add_city"];
        [self addSubview:temp];
        _rightImageView = temp;
    }
    return _rightImageView;
}
-(void)addViews
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    self.lineView = line;
}
-(void)setState
{
    if (self.rightImageView.tag==990) {
        self.rightImageView.tag=991;
        self.rightImageView.image = [UIImage imageNamed:@"added_city"];
    }
    else
    {
        self.rightImageView.tag=990;
        self.rightImageView.image = [UIImage imageNamed:@"add_city"];

    }
}
-(void)setData:(NSDictionary *)date last:(Boolean)isLast
{
    if ([date objectForKey:@"name"]) {
        self.titleLb.text = [date objectForKey:@"name"];
    }
    if ([date objectForKey:@"isCheck"]) {
        if ([[date objectForKey:@"isCheck"] isEqual:@"0"]) {
             self.rightImageView.image = [UIImage imageNamed:@"add_city"];
        }
        else
        {
            self.rightImageView.tag=991;
             self.rightImageView.image = [UIImage imageNamed:@"added_city"];
        }
    }
    if (isLast) {
        self.lineView.hidden = YES;
    }
    else
    {
        self.lineView.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

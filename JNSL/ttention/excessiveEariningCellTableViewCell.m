//
//  excessiveEariningCellTableViewCell.m
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "excessiveEariningCellTableViewCell.h"

@implementation excessiveEariningCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth/4, 50)];
        self.lb2 = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/4, 0, screenWidth/4, 50)];
        self.lb3 = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/4*2, 0, screenWidth/4, 50)];
        self.lb4 = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/4*3, 0, screenWidth/4, 50)];
        self.lb1.font  = [UIFont systemFontOfSize:11];
        self.lb2.font  = [UIFont systemFontOfSize:11];
        self.lb3.font  = [UIFont systemFontOfSize:11];
        self.lb4.font  = [UIFont systemFontOfSize:11];
        self.lb1.textAlignment = NSTextAlignmentCenter;
        self.lb2.textAlignment = NSTextAlignmentCenter;
        self.lb3.textAlignment = NSTextAlignmentCenter;
        self.lb4.textAlignment = NSTextAlignmentCenter;
        self.lb1.numberOfLines = 0;
        self.lb2.numberOfLines = 0;
        self.lb3.numberOfLines = 0;
        self.lb4.numberOfLines = 0;
        [self addSubview:self.lb1];
        [self addSubview:self.lb2];
        [self addSubview:self.lb3];
        [self addSubview:self.lb4];
    }
    return self;
    
}

-(void)setData:(NSDictionary *)data{
    self.lb1.text = [data objectForKey:@"pollSourceName"];
    self.lb2.text = [data objectForKey:@"begin_time"];
    self.lb3.text = [data objectForKey:@"pollutantName"];
    self.lb4.text = [data objectForKey:@"fact_out_nd"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

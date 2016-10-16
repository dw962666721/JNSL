//
//  overproofReportDetailsTableViewCell.m
//  JNSL
//
//  Created by zw on 16/10/15.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "overproofReportDetailsTableViewCell.h"

@implementation overproofReportDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
        self.titlelb.font = [UIFont systemFontOfSize:14];
        self.titlelb.textAlignment = NSTextAlignmentCenter;
        self.timelb = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, screenWidth/2-10, 15)];
        self.wuranwu = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2, 30, screenWidth/2-10, 15)];
        self.wuranwu.textAlignment = NSTextAlignmentRight;
        self.chaobiao = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, screenWidth/2-10-10, 15)];
        self.nongdu = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2, 45, screenWidth/2-10, 15)];
        self.nongdu.textAlignment = NSTextAlignmentRight;
        self.timelb.font = [UIFont systemFontOfSize:13];
        self.wuranwu.font = [UIFont systemFontOfSize:13];
        self.chaobiao.font = [UIFont systemFontOfSize:13];
        self.nongdu.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.titlelb];
        [self addSubview:self.timelb];
        [self addSubview:self.wuranwu];
        [self addSubview:self.chaobiao];
        [self addSubview:self.nongdu];
        
        self.timelb.textColor = ColorWithRGB(0x999999);
        self.wuranwu.textColor = ColorWithRGB(0x999999);
        self.chaobiao.textColor = ColorWithRGB(0x999999);
        self.nongdu.textColor = ColorWithRGB(0x999999);
    }
    return self;
    
}


-(void)setData:(NSDictionary *)data{
    self.titlelb.text = [data objectForKey:@"poll_source_name"];
    self.timelb.text = [data objectForKey:@"begin_time"];
    self.wuranwu.text = [[NSString alloc] initWithFormat:@"%@%@",@"污染物：",[data objectForKey:@"pollutant_name"]];
    self.chaobiao.text =  [[NSString alloc] initWithFormat:@"%@%@",@"超标倍数：",[data objectForKey:@"overtimes"]];
    self.nongdu.text = [[NSString alloc] initWithFormat:@"%@%@",@"超标浓度：",[data objectForKey:@"overchroma"]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

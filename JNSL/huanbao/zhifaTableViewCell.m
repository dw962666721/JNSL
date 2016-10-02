//
//  zhifaTableViewCell.m
//  JNSL
//
//  Created by wangjiang on 16/10/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "zhifaTableViewCell.h"

@implementation zhifaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.logoimg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self addSubview:self.logoimg];
        self.filename = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 250, 20)];
        [self addSubview:self.filename];
        self.downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth-110, 20, 50, 20)];
        self.seeBrn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth-55, 20, 40, 20)];
        [self addSubview:self.downloadBtn];
        [self addSubview:self.seeBrn];
        //设置样式
        self.logoimg.image = [UIImage imageNamed:@"arrow_left3"];
        self.filename.text = @"desktop.ini";
        [self.downloadBtn setTitle:@"已下载" forState:UIControlStateNormal];
        [self.seeBrn setTitle:@"查看" forState:UIControlStateNormal];
        [self.downloadBtn setTitleColor:ColorWithRGB(0x1381f5) forState:UIControlStateNormal];
        [self.seeBrn setTitleColor:ColorWithRGB(0x1381f5) forState:UIControlStateNormal];
        self.downloadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.seeBrn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.downloadBtn addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchDown];
        [self.seeBrn addTarget:self action:@selector(see) forControlEvents:UIControlEventTouchDown];
    }
    return self;

}

-(void)download{
    
}
-(void)see{

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

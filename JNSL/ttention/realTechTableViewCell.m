//
//  realTechTableViewCell.m
//  JNSL
//
//  Created by zw on 16/10/14.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "realTechTableViewCell.h"

@implementation realTechTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 50)];
        [self addSubview:self.lb];
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-50, 0, 50, 50)];
        self.img.image = [UIImage imageNamed:@"arrow_right"];
        [self addSubview:self.img];
    }
    return self;
    
}

-(void)setText:(NSString *)text{
    self.lb.text = text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

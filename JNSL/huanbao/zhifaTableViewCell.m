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
        
        [self.downloadBtn setTitle:@"" forState:UIControlStateNormal];
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

-(void)setDownText{
    self.filename.text = self.cellFilename;
    if ([self isexsitFile:self.cellFilename]) {
        [self.downloadBtn setTitle:@"已下载" forState:UIControlStateNormal];
    }else{
        [self.downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    }
}

-(void)download{
    //判断是否已经下载
    if ([self isexsitFile:self.cellFilename]) {
        //如果已经下载 直接打开
        [self see];
        
    }else{
        if (self.zprotocal != nil) {
            [self.zprotocal cellClick:self.cellIndex withUrl:self.cellUrl withName:self.cellFilename withindexpath:self.ipath];
        }
    
    }
}
-(void)see{
    //根据filename查找对应的文件路径
    [self.zprotocal cellSee:self.cellIndex withfilename:self.cellFilename];
}

-(BOOL) isexsitFile:(NSString *)docName{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    //2.创建资源存储路径
    NSString *appendPath = [NSString stringWithFormat:@"%@%@",@"/",docName];
    NSString *file = [documentsPath stringByAppendingString:appendPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    bool isexsit = [manager fileExistsAtPath:file];
    return isexsit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

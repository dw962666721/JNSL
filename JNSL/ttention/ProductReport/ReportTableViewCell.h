//
//  zhifaTableViewCell.h
//  JNSL
//
//  Created by wangjiang on 16/10/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zhifaProtocal.h"
@interface ReportTableViewCell : UITableViewCell
@property UIImageView *logoimg;
@property UILabel *filename;
@property UIButton *downloadBtn;
@property UIButton *seeBrn;
@property NSInteger *cellIndex;
@property NSString *cellUrl;
@property NSString *cellFilename;
@property id<zhifaProtocal> zprotocal;
@property NSIndexPath *ipath;
@property NSString *fileId;
-(void)setDownText;
@end

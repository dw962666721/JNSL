//
//  overproofReportDetailsTableViewCell.h
//  JNSL
//
//  Created by zw on 16/10/15.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface overproofReportDetailsTableViewCell : UITableViewCell
@property UILabel *titlelb;
@property UILabel *timelb;
@property UILabel *wuranwu;
@property UILabel *chaobiao;
@property UILabel *nongdu;
-(void)setData:(NSDictionary *)data;
@end

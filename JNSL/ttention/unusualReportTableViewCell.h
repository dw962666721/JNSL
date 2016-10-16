//
//  unusualReportTableViewCell.h
//  JNSL
//
//  Created by zw on 16/10/14.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface unusualReportTableViewCell : UITableViewCell
@property UILabel  *lb1;
@property UILabel  *lb2;
@property UILabel  *lb3;
@property UILabel  *lb4;
@property UILabel  *lb5;

-(void)setData:(NSDictionary *)data;

@end

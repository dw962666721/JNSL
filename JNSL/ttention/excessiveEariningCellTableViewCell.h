//
//  excessiveEariningCellTableViewCell.h
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface excessiveEariningCellTableViewCell : UITableViewCell

@property UILabel  *lb1;
@property UILabel  *lb2;
@property UILabel  *lb3;
@property UILabel  *lb4;

-(void)setData:(NSDictionary *)data;

@end

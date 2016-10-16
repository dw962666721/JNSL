//
//  realTimeTableViewCell.h
//  JNSL
//
//  Created by zw on 16/10/14.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface realTimeTableViewCell : UITableViewCell
@property UILabel *name;
@property UILabel *datastatue;
@property UILabel *jizu;
@property UILabel *sdate;
@property UILabel *edate;

-(void)setData:(NSDictionary *)data;
@end

//
//  MyMessageTableViewCell.h
//  JNSL
//
//  Created by zw on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageTableViewCell : UITableViewCell
@property (strong,nonatomic) UILabel *pollSourceNameLb;
@property (strong,nonatomic) UILabel *facilityNameLb;
@property (strong,nonatomic) UILabel *alarmTypeNameLb;
@property (strong,nonatomic) UILabel *alarmCausesLb;
@property (strong,nonatomic) UILabel *beginDateLb;
@property (strong,nonatomic) UILabel *endDateLb;
-(void)loadDate:(NSDictionary *)date;
@end

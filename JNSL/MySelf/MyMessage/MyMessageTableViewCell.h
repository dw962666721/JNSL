//
//  MyMessageTableViewCell.h
//  JNSL
//
//  Created by zw on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageTableViewCell : UITableViewCell
@property (strong,nonatomic) UILabel *titleLb;
@property (strong,nonatomic) UILabel *descriptionLb;
-(void)loadDate:(NSDictionary *)date;
@end

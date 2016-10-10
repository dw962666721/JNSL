//
//  MessageTableViewCell.h
//  JNSL
//
//  Created by zw on 16/10/9.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (strong,nonatomic) UILabel *titleLb;
@property (strong,nonatomic) UILabel *descriptionLb;
-(void)setData:(NSDictionary*)dict;
@end

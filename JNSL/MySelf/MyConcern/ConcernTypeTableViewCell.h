//
//  ConcernTypeTableViewCell.h
//  JNSL
//
//  Created by zw on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConcernTypeTableViewCell : UITableViewCell
@property (strong,nonatomic) UILabel *titleLb;
@property (strong,nonatomic) UIImageView *rightImageView;
@property (strong,nonatomic) UIView *lineView;
-(void)setData:(NSDictionary *)date last:(Boolean)isLast;
-(void)setState;
@end

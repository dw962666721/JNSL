//
//  HomeDetailTableViewCell.h
//  JNSL
//
//  Created by zw on 16/10/10.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDetailTableViewCell : UITableViewCell
@property (strong,nonatomic) UILabel *idLb;
@property (strong,nonatomic) UILabel *nameLb;
@property (strong,nonatomic) UILabel *valueLb;
@property (strong,nonatomic) UILabel *unitLb;
-(void)setCellData:(NSDictionary*)dict row:(NSInteger)row;
@end

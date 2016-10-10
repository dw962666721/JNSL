//
//  HomeDetailViewController.h
//  JNSL
//
//  Created by zw on 16/10/9.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailTableViewCell.h"
@interface HomeDetailViewController : baseViewController<UITableViewDataSource,UITableViewDelegate>
-(void)setVCType:(NSInteger)type;
@end

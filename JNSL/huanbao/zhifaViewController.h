//
//  zhifaViewController.h
//  JNSL
//
//  Created by wangjiang on 16/10/1.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
#import "MJRefresh.h"
#import "zhifaTableViewCell.h"
#import "zhifaDetailsViewController.h"

@interface zhifaViewController : baseViewController<UITableViewDataSource,UITableViewDelegate>

@property UITableView *DataTable;
@end

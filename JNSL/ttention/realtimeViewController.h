//
//  realtimeViewController.h
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "baseViewController.h"
#import "MJRefresh.h"
#import "excessiveEariningCellTableViewCell.h"
#import "realTimeTableViewCell.h"
#import "realTimeSearchViewController.h"


@interface realtimeViewController : baseViewController<UITableViewDataSource,UITableViewDelegate>
@property UITableView *datatable;
@end

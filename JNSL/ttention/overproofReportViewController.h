//
//  overproofReportViewController.h
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "baseViewController.h"
#import "MJRefresh.h"
#import "excessiveEariningCellTableViewCell.h"
#import "overproofReportDetailsViewController.h"
#import "overproofSeachViewController.h"


@interface overproofReportViewController : baseViewController<UITableViewDataSource,UITableViewDelegate,overproofSearchProtocal>
@property UITableView *datatable;
@end

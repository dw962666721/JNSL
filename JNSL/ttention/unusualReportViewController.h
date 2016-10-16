//
//  unusualReportViewController.h
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "baseViewController.h"
#import "MJRefresh.h"
#import "excessiveEariningCellTableViewCell.h"
#import "unusualReportTableViewCell.h"
#import "unusualReportDetailsViewController.h"
#import "excessiveSearchViewController.h"

@interface unusualReportViewController : baseViewController<UITableViewDataSource,UITableViewDelegate,excessiveSearchProtocal>
@property UITableView *datatable;
@end

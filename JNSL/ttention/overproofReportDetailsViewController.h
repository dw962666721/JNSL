//
//  overproofReportDetailsViewController.h
//  JNSL
//
//  Created by zw on 16/10/15.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "baseViewController.h"
#import "MJRefresh.h"
#import "overproofReportDetailsTableViewCell.h"

@interface overproofReportDetailsViewController : baseViewController<UITableViewDataSource,UITableViewDelegate>
@property UITableView *datatable;
@property NSString *pollutantName;
@property NSString *checkDate;
@property NSString *crewId;

@end

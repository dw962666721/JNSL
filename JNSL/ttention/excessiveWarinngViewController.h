//
//  excessiveWarinngViewController.h
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "baseViewController.h"
#import "excessiveEariningCellTableViewCell.h"

//超标预警
@interface excessiveWarinngViewController : baseViewController<UITableViewDataSource,UITableViewDelegate>
@property UITableView *datatable;
@end

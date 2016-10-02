//
//  gongkuangViewController.h
//  JNSL
//
//  Created by wangjiang on 16/10/1.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
#import "gongkuangDetailsViewController.h"
#import "yuanliDetailsViewController.h"
#import "zuoyongDetalsViewController.h"


@interface gongkuangViewController : baseViewController<UITableViewDataSource,UITableViewDelegate>

@property UITableView *DataTable;


@end

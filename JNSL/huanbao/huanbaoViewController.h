//
//  huanbaoViewController.h
//  JNSL
//
//  Created by wangjiang on 16/10/1.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
#import "huanbaoWebViewController.h"

@interface huanbaoViewController : baseViewController<UITableViewDataSource,UITableViewDelegate>

@property UITableView *DataTable;

@end

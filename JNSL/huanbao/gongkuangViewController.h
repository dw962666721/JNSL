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
#import "zuoyongDetalsViewController.h"
#import "wulaio1ViewController.h"
#import "wulaio2ViewController.h"
#import "wulaio3ViewController.h"
#import "wulaio4ViewController.h"
#import "guizeViewController.h"
#import "yiyiViewController.h"


@interface gongkuangViewController : baseViewController<UITableViewDataSource,UITableViewDelegate>

@property UITableView *DataTable;


@end

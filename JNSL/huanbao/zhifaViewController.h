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
#import "zhifaProtocal.h"
#import "MBProgressHUD.h"
#import "fileReaderViewController.h"


@interface zhifaViewController : baseViewController<UITableViewDataSource,UITableViewDelegate,zhifaProtocal,NSURLSessionDownloadDelegate,NSURLSessionDelegate>

@property UITableView *DataTable;
@property (nonatomic,strong) NSMutableData* fileData;
@property NSInteger pageindex;
@property (strong, nonatomic)           NSURLSession *currentSession;    // 当前会话
@property (strong, nonatomic) NSURLSessionDownloadTask *cancellableTask; // 可取消的下载任务
@property MBProgressHUD *HUD;
@property NSString *viewtype;
@end

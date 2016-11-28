//
//  ReportViewController.h
//  JNSL
//
//  Created by wangjiang on 16/11/20.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zhifaViewController.h"
#import "ReportTableViewCell.h"
@interface ReportViewController : baseViewController<UITableViewDataSource,UITableViewDelegate,zhifaProtocal,NSURLSessionDownloadDelegate,NSURLSessionDelegate>
@property (nonatomic,strong) NSString*dayStr;
@property UITableView *DataTable;
@property (nonatomic,strong) NSMutableData* fileData;
@property NSInteger pageindex;
@property (strong, nonatomic)           NSURLSession *currentSession;    // 当前会话
@property (strong, nonatomic) NSURLSessionDownloadTask *cancellableTask; // 可取消的下载任务
@property MBProgressHUD *HUD;
@property NSString *viewtype;
-(NSString*)getUrl:(BOOL)type;
-(NSMutableDictionary*)getDict:(BOOL)type;
-(void)setData:(NSString*)dateStr;
@end

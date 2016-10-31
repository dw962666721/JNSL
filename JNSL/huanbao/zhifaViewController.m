//
//  zhifaViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/1.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "zhifaViewController.h"

@interface zhifaViewController ()
{

    NSString *currentFilename;
    NSString *currentIndexpath;
    NSMutableArray *dataArr;
}
@end

@implementation zhifaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageindex = 0;
    dataArr = [[NSMutableArray alloc] init];
    self.DataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65)];
    self.DataTable.dataSource = self;
    self.DataTable.delegate = self;
    self.DataTable.tableHeaderView = [[UIView alloc] init];
    self.DataTable.tableFooterView = [[UIView alloc] init];
    [self.DataTable registerClass:[zhifaTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.DataTable];
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    __weak __typeof(self) weakSelf = self;
    self.DataTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    self.DataTable.footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    // 马上进入刷新状态
    [self.DataTable.header beginRefreshing];
    //[self createProgress];
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    [self loadData:true];
    //[self.DataTable.mj_header endRefreshing];
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    [self loadData:false];
    //[self.DataTable.mj_footer endRefreshing];
}

//加载数据
-(void)loadData:(BOOL)type{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (type) {
        //刷新数据
        dict[@"start"]= [NSString stringWithFormat:@"%d",0];
    }else{
        //加载数据
        dict[@"start"]= [NSString stringWithFormat:@"%ld",(long)dataArr.count];
    }
    
    NSString *urlstr = @"";
    if ([self.viewtype  isEqual: @"zhifa"]) {
        urlstr =  zhifaURL;
        dict[@"fileTypeId"] = @"ZFAL";
    }else{
        urlstr = gongkuangURL;
    }
    
    [AFNetworkTool postJSONWithUrl:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,urlstr] parameters:dict success:^(id responseObject) {
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableArray *resultEntityArray = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"resultEntity"]];
            if (resultEntityArray.count>0) {
                NSMutableDictionary *resultEntityDict = resultEntityArray[0];
                NSArray *resultArray = resultEntityDict[@"data"];
                if (type) {
                    dataArr = [[NSMutableArray alloc] initWithArray:resultArray];
                    [self.DataTable.header endRefreshing];
                    if (dataArr.count == 0) {
                        [MBProgressHUD showError:@"暂无数据"];
                    }
                }else{
                    [dataArr addObjectsFromArray:resultArray];
                    [self.DataTable.footer endRefreshing];
                }
                
                [self.DataTable reloadData];
                //self.pageindex = self.pageindex + 1;
            }
        }
        
    } fail:^{
        [MBProgressHUD showError:@"获取数据失败"];
        [self.DataTable.header endRefreshing];
        [self.DataTable.footer endRefreshing];
    }];
    
}




//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;//返回标题数组中元素的个数来确定分区的个数
    
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    zhifaDetailsViewController *zhifaDetails = [[zhifaDetailsViewController alloc] init];
    [self.navigationController pushViewController:zhifaDetails animated:true];
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    zhifaTableViewCell *cell = (zhifaTableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
            cell = [[zhifaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
    cell.cellIndex = indexPath.row;
    NSString *datafileurl = [dataArr[indexPath.row] objectForKey:@"fileUrl"];
    NSString *fileurl = [[NSString alloc] initWithFormat:@"%@%@", userInfoJNSL.ip, datafileurl ];
    cell.cellUrl = fileurl;
    NSLog(@"fileurl");
    NSLog(fileurl);
    cell.cellFilename = [dataArr[indexPath.row] objectForKey:@"fileName"];
    cell.ipath = indexPath;
    cell.zprotocal = self;
    cell.fileId = [dataArr[indexPath.row] objectForKey:@"fileId"];
    [cell setDownText];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//委托

-(void)cellSee:(NSInteger)index withfilename:(NSString *)filename{
    fileReaderViewController *filereader = [[fileReaderViewController alloc] init];
    filereader.filename = filename;
    [self.navigationController pushViewController:filereader animated:true];
}
-(void)cellClick:(NSInteger)index withUrl:(NSString *)url withName:(NSString *)filename withindexpath:(NSIndexPath *)indexpath{
        //下载
        [self createProgress];
        if (!self.currentSession) {
            [self createCurrentSession];
        }
    currentFilename = filename;
    currentIndexpath = indexpath;
        //NSString *fileurl = @"http://farm6.staticflickr.com/5505/9824098016_0e28a047c2_b_d.jpg";
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        self.cancellableTask = [self.currentSession downloadTaskWithRequest:request];
        [self.cancellableTask resume];
}

/* 创建当前的session */
- (void)createCurrentSession {
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.currentSession = [NSURLSession sessionWithConfiguration:defaultConfig delegate:self delegateQueue:nil];
    self.currentSession.sessionDescription = @"description";
}



#pragma mark 下载过程
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    //获取下载进度
    double currentProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        //进行UI操作  设置进度条
        self.HUD.progress = currentProgress;
    });
}

#pragma mark - 下载成功 获取下载内容
-(void)URLSession:(NSURLSession *)session   downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSFileManager *manager = [NSFileManager defaultManager];
    //1.获取Documents文件夹路径 （不要将视频、音频等较大资源存储在Caches路径下）
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    //2.创建资源存储路径
    NSString *appendPath = [NSString stringWithFormat:@"%@%@",@"/",currentFilename];
    NSString *file = [documentsPath stringByAppendingString:appendPath];
    //删除之前相同路径的文件
    [manager removeItemAtPath:file error:nil];
    //将视频资源从原有路径移动到自己指定的路径
    BOOL success = [manager copyItemAtPath:location.path toPath:file error:nil];
    if (success) {
        //回到主线程进行本地视频播放
        dispatch_async(dispatch_get_main_queue(), ^{
            //成功
            [MBProgressHUD showError:@"成功"];
            //刷新表格
            NSArray *arr = [[NSArray alloc] initWithObjects:currentIndexpath, nil];
            [self.DataTable reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationMiddle];
        });
    }
    [self endProgress];
}


-(void)createProgress{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.dimBackground = YES;
    [self.view bringSubviewToFront:self.HUD];
    self.HUD.mode = MBProgressHUDModeAnnularDeterminate;
    [self.HUD show:YES];
}
-(void)endProgress{
    [self.HUD removeFromSuperview];
    self.HUD = nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

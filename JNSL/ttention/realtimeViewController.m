//
//  realtimeViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "realtimeViewController.h"

@interface realtimeViewController ()
{
    NSMutableArray *dataArr;
    NSString *realtype;
}
@end

@implementation realtimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实时报警";
    realtype = @"-1";
    dataArr = [[NSMutableArray alloc] init];
    [self createtable];
    [self createSearch];
    if ([self.datatable respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.datatable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.datatable respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.datatable setLayoutMargins:UIEdgeInsetsZero];
        
    }
    // Do any additional setup after loading the view.
}

-(void)createSearch{
    //  返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 20, 20)];
    [backBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchDown];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightbtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = rightbtn;
}


-(void)searchClick{
    realTimeSearchViewController *ecc = [[realTimeSearchViewController alloc] init];
    ecc.serachprotocal = self;
    [self.navigationController pushViewController:ecc animated:true];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)createtable{
    self.datatable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65) style:UITableViewStylePlain];
    self.datatable.dataSource = self;
    self.datatable.delegate = self;
    [self.datatable registerClass:[realTimeTableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.datatable.tableFooterView = [[UIView alloc] init];
    self.datatable.tableHeaderView = [[UIView alloc] init];
    [self.view addSubview:self.datatable];
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    __weak __typeof(self) weakSelf = self;
    self.datatable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    self.datatable.footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    // 马上进入刷新状态
    [self.datatable.header beginRefreshing];
}

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
        dataArr = [[NSMutableArray alloc] init];
    }else{
        //加载数据
    }
    dict[@"start"]= [NSString stringWithFormat:@"%ld",(long)dataArr.count];
    if([realtype  isEqual: @"-1"]){
     dict[@"larmTypeCode"] = @"";
    }else{
     dict[@"larmTypeCode"] = realtype;
    }
    dict[@"startTime"] = @"";
    dict[@"endTime"] = @"";
    [AFNetworkTool postJSONWithUrl:shishiURL parameters:dict success:^(id responseObject) {
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableArray *resultEntityArray = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"resultEntity"]];
            if (resultEntityArray.count>0) {
                NSMutableDictionary *resultEntityDict = resultEntityArray[0];
                NSArray *resultArray = resultEntityDict[@"data"];
                if (type) {
                    dataArr = [[NSMutableArray alloc] initWithArray:resultArray];
                    [self.datatable.header endRefreshing];
                }else{
                    [dataArr addObjectsFromArray:resultArray];
                    [self.datatable.footer endRefreshing];
                }
                
                [self.datatable reloadData];
            }
        }
        
    } fail:^{
        [MBProgressHUD showError:@"获取数据失败"];
        [self.datatable.header endRefreshing];
        [self.datatable.footer endRefreshing];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    realTimeTableViewCell *cell = (realTimeTableViewCell *)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[realTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSDictionary *data = dataArr[indexPath.row];
    [cell setData:data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)searchClick:(NSString *)typeid{
    realtype = typeid;
    // 马上进入刷新状态
    [self.datatable.header beginRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

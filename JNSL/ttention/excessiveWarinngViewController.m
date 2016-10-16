//
//  excessiveWarinngViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "excessiveWarinngViewController.h"

@interface excessiveWarinngViewController ()
{
    NSMutableArray *dataArr;
    NSString *starDate;
    NSString *endDate;
    NSString *wuranType;
    
    NSString *pollSourceId;
    NSString *userid;
}
@end

@implementation excessiveWarinngViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"超标预警";
    pollSourceId = userInfoJNSL.pollSourceId;
    userid = userInfoJNSL.userId;
    [self setDate];
    wuranType = @"so2";
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

-(void)setDate{
    NSDate *begindate = [NSDate date];
    NSTimeInterval  interval =24*60*60*-30; //1:天数
    NSDate *enddate = [begindate initWithTimeIntervalSinceNow:+interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    endDate = [dateFormatter stringFromDate:begindate];
    starDate = [dateFormatter stringFromDate:enddate];
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

-(void)createSearch{
    //  返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 20, 20)];
    [backBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchDown];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightbtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = rightbtn;
}


-(void)searchClick{
    excessiveSearchViewController *ecc = [[excessiveSearchViewController alloc] init];
    ecc.serachprotocal = self;
    ecc.arr1 = [[NSArray alloc] initWithObjects:@"so2",@"nox",@"smoke", nil];
    [self.navigationController pushViewController:ecc animated:true];
}

-(void)createtable{
    self.datatable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65) style:UITableViewStylePlain];
    self.datatable.dataSource = self;
    self.datatable.delegate = self;
    [self.datatable registerClass:[excessiveEariningCellTableViewCell class] forCellReuseIdentifier:@"Cell"];
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
        dict[@"start"]= [NSString stringWithFormat:@"%ld",0];
    }else{
        //加载数据
        dict[@"start"]= [NSString stringWithFormat:@"%ld",(long)dataArr.count];
    }
    
    dict[@"userId"] = userid;
    dict[@"pollSourceId"] = pollSourceId;
    dict[@"startTime"] = starDate;
    dict[@"endTime"] = endDate;
    dict[@"type"] = wuranType;
    
    [AFNetworkTool postJSONWithUrl:yujingURL parameters:dict success:^(id responseObject) {
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
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
       excessiveEariningCellTableViewCell *cell = [[excessiveEariningCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    NSDictionary *data = dataArr[indexPath.row];
    [cell setData:data];
    return cell;
}


- ( UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
    //设置表头 企业名称,发生时间,污染物名称,排放值
    CGFloat lbwid = screenWidth/4;
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, lbwid, 40)];
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(lbwid, 0, lbwid, 40)];
    UILabel *lb3 = [[UILabel alloc] initWithFrame:CGRectMake(lbwid*2, 0, lbwid, 40)];
    UILabel *lb4 = [[UILabel alloc] initWithFrame:CGRectMake(lbwid*3, 0, lbwid, 40)];
    lb1.textAlignment = NSTextAlignmentCenter;
    lb2.textAlignment = NSTextAlignmentCenter;
    lb3.textAlignment = NSTextAlignmentCenter;
    lb4.textAlignment = NSTextAlignmentCenter;
    lb1.font = [UIFont systemFontOfSize:16];
    lb2.font = [UIFont systemFontOfSize:16];
    lb3.font = [UIFont systemFontOfSize:16];
    lb4.font = [UIFont systemFontOfSize:16];
    lb1.text = @"企业名称";
    lb2.text = @"发生时间";
    lb3.text = @"污染物名称";
    lb4.text = @"排放值";
    [view addSubview:lb1];[view addSubview:lb2];
    [view addSubview:lb3];[view addSubview:lb4];
    //添加边框
    UIView *borde1 = [[UIView alloc] initWithFrame:CGRectMake(lbwid, 0, 1, 40)];
    UIView *borde2 = [[UIView alloc] initWithFrame:CGRectMake(lbwid*2, 0, 1, 40)];
    UIView *borde3 = [[UIView alloc] initWithFrame:CGRectMake(lbwid*3, 0, 1, 40)];
    borde1.backgroundColor = [UIColor whiteColor];
    borde2.backgroundColor = [UIColor whiteColor];
    borde3.backgroundColor = [UIColor whiteColor];
    [view addSubview:borde1];[view addSubview:borde2];[view addSubview:borde3];
    view.backgroundColor = ColorWithRGB(0x20647a);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

//搜索条件
-(void)searchClick:(NSString *)wuranwu withbegintime:(NSString *)begintime withendtime:(NSString *)endtime{
    starDate = begintime;
    endDate = endtime;
    wuranType = wuranwu;
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

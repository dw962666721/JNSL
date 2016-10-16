//
//  overproofReportViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "overproofReportViewController.h"

@interface overproofReportViewController ()
{
    NSMutableArray *dataArr;
    NSString *beginDate;
}
@end

@implementation overproofReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"超标报告";
    [self setDate];
    dataArr= [[NSMutableArray alloc] init];
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    beginDate = [dateFormatter stringFromDate:begindate];
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
    overproofSeachViewController *ecc = [[overproofSeachViewController alloc] init];
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
    dict[@"checkDate"]= beginDate;
    [AFNetworkTool postJSONWithUrl:chaobiaoURL parameters:dict success:^(id responseObject) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    overproofReportDetailsViewController * opd = [[overproofReportDetailsViewController alloc] init];
    NSDictionary *dic = dataArr[indexPath.row];
    opd.pollutantName = [dic objectForKey:@"pollutant_name"];
    opd.checkDate = [dic objectForKey:@"begin_time"];
    opd.crewId = [dic objectForKey:@"facility_bas_id"];
    
    [self.navigationController pushViewController:opd animated:true];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    NSDictionary *data = dataArr[indexPath.row];
    cell.textLabel.text = [data objectForKey:@"poll_source_name"];
    cell.detailTextLabel.text = [data objectForKey:@"pollutant_name"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}


- ( UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
    //设置表头 企业名称,发生时间,污染物名称,排放值
    CGFloat lbwid = screenWidth/3;
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, lbwid*2, 40)];
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(lbwid*2, 0, lbwid, 40)];
    lb1.textAlignment = NSTextAlignmentCenter;
    lb2.textAlignment = NSTextAlignmentCenter;
    lb1.font = [UIFont systemFontOfSize:16];
    lb2.font = [UIFont systemFontOfSize:16];
    lb1.text = @"设施名称";
    lb2.text = @"超标污染物";
    [view addSubview:lb1];[view addSubview:lb2];
    //添加边框
    UIView *borde1 = [[UIView alloc] initWithFrame:CGRectMake(lbwid*2, 0, 1, 40)];
    borde1.backgroundColor = [UIColor whiteColor];
    [view addSubview:borde1];
    view.backgroundColor = ColorWithRGB(0x20647a);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(void)searchClick:(NSString *)begintime{
    beginDate = begintime;
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

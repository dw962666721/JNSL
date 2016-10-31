//
//  realTechnologoViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "realTechnologoViewController.h"

@interface realTechnologoViewController ()
{
    NSMutableArray *dataArr;
     NSString *pollSourceId;
}
@end

@implementation realTechnologoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实时工艺图";
    pollSourceId = userInfoJNSL.pollSourceId;
    [self createtable];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.datatable respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.datatable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.datatable respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.datatable setLayoutMargins:UIEdgeInsetsZero];
        
    }
    // Do any additional setup after loading the view.
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
    [self.datatable registerClass:[realTechTableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.datatable.tableFooterView = [[UIView alloc] init];
    self.datatable.tableHeaderView = [[UIView alloc] init];
    [self.view addSubview:self.datatable];
    self.datatable.backgroundColor = RGBA(229, 230, 232, 1);
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    realTechTDetailsViewController * etd = [[realTechTDetailsViewController alloc] init];
    NSDictionary *dic = dataArr[indexPath.row];
    NSString *serName = [dic objectForKey:@"serName"];
    NSString *urlstr = [[NSString alloc] initWithFormat:@"%@%@",@"http://112.65.187.118:8074/rsa/diagram/openplant/gview/diagram.html?fileName=",serName];
    if (indexPath.row == 0) {
        etd.url = @"http://60.31.21.53:8082/rsa/diagram/openplant/gview/diagram.html?fileName=HS_SLRD_01.zxml";
    }
    if (indexPath.row == 1) {
        etd.url = @"http://60.31.21.53:8082/rsa/diagram/openplant/gview/diagram.html?fileName=HS_SLRD_02.zxml";
    }
    //[self.navigationController pushViewController:etd animated:true];
    [self presentViewController:etd animated:YES completion:Nil];
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
    
    dict[@"pollSourceId"] = pollSourceId;
    [AFNetworkTool postJSONWithUrl:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,jizuURL] parameters:dict success:^(id responseObject) {
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableArray *resultEntityArray = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"resultEntity"]];
            if (resultEntityArray.count>0) {
                NSArray *resultArray = resultEntityArray;
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
       realTechTableViewCell * cell = [[realTechTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.backgroundColor = RGBA(229, 230, 232, 1);
    NSDictionary *data = dataArr[indexPath.row];
    NSString *text = [data objectForKey:@"facilityname"];
    [cell setText:text];
    return cell;
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;//返回标题数组中元素的个数来确定分区的个数
    
}

- ( UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 60)];
    self.titlelb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth-10, 60)];
    self.titlelb.text = @"京能盛乐热电有限公司";
    [view addSubview:self.titlelb];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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

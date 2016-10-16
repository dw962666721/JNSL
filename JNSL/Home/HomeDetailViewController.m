//
//  HomeDetailViewController.m
//  JNSL
//
//  Created by zw on 16/10/9.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()
@property NSInteger type; // 0:#1锅炉  1:公用  2:＃2锅炉
@property UIBarButtonItem *rightBtn;
@property UITableView *tableView;
@property NSMutableArray *dataArray;
@end

@implementation HomeDetailViewController
-(void)loadData
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (self.type==0) {
         dict[@"typeId"]=@"1";
    }
    else if (self.type==1)
    {
        dict[@"typeId"]=@"7";
    }
    else
    {
        dict[@"typeId"]=@"4";
    }
   
    [AFNetworkTool postJSONWithUrl:FacilityDetialInfoURL parameters:dict success:^(id responseObject) {
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableArray *resultArray = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"resultEntity"]];
            self.dataArray = resultArray;
            [self.tableView reloadData];
        }
        else
        {
            NSString *resultDict = [json objectForKey:@"message"];
            NSLog(@"%@",resultDict);
        }
        [self.tableView.header endRefreshing];
    } fail:^{
        [self.tableView.header endRefreshing];
        // 移除HUD
        [MBProgressHUD hideHUD];
        
        // 提醒有没有新数据
        [MBProgressHUD showError:@"请求失败"];
    }];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    //  添加右侧切换按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backBtn addTarget:self action:@selector(changeView) forControlEvents:UIControlEventTouchDown];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"trans"] forState:UIControlStateNormal];
    self.rightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = self.rightBtn;
    
    if (self.type==1) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    switch (self.type) {
        case 0:
            self.title = @"#1锅炉";
            break;
        case 1:
            self.title = @"公用";
            break;
        case 2:
            self.title = @"#2锅炉";
            break;
        default:
            break;
    }
    
    [self addViews];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [ self.tableView registerClass:[HomeDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableHeaderView = [[UIView alloc] init];
    self.tableView.tableFooterView = [[UIView alloc] init];
    __weak __typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self.view addSubview:self.tableView];
    [self.tableView.header beginRefreshing];
    
}
-(void)setVCType:(NSInteger)type
{
    self.type = type;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell setCellData:self.dataArray[indexPath.row] row:indexPath.row];
    [cell setCellData:self.dataArray[indexPath.row] row:indexPath.row];
    return cell;
}
- ( UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSInteger viewH=30;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, viewH)];
    //设置表头 企业名称,发生时间,污染物名称,排放值
    CGFloat lbwid1 = 50;
    CGFloat lbwid2 = (screenWidth-50*2)*2/3;
    CGFloat lbwid3 = (screenWidth-50*2)*1/3;
    CGFloat lbwid4 = 50;
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, lbwid1, viewH)];
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb1.frame), 0, lbwid2, viewH)];
    UILabel *lb3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb2.frame), 0, lbwid3, viewH)];
    UILabel *lb4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb3.frame), 0, lbwid4, viewH)];
    lb1.textAlignment = NSTextAlignmentCenter;
    lb2.textAlignment = NSTextAlignmentCenter;
    lb3.textAlignment = NSTextAlignmentCenter;
    lb4.textAlignment = NSTextAlignmentCenter;
    lb1.font = [UIFont systemFontOfSize:16];
    lb2.font = [UIFont systemFontOfSize:16];
    lb3.font = [UIFont systemFontOfSize:16];
    lb4.font = [UIFont systemFontOfSize:16];
    lb1.text = @"序号";
    lb2.text = @"点名";
    lb3.text = @"值";
    lb4.text = @"单位";
    [view addSubview:lb1];[view addSubview:lb2];
    [view addSubview:lb3];[view addSubview:lb4];
    //添加边框
    UIView *borde1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb1.frame), 0, 1, viewH)];
    UIView *borde2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb2.frame), 0, 1, viewH)];
    UIView *borde3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb3.frame), 0, 1, viewH)];
    borde1.backgroundColor = [UIColor whiteColor];
    borde2.backgroundColor = [UIColor whiteColor];
    borde3.backgroundColor = [UIColor whiteColor];
    [view addSubview:borde1];[view addSubview:borde2];[view addSubview:borde3];
    view.backgroundColor = ColorWithRGB(0x20647a);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)changeView
{
    if (self.type==0) {
        self.title = @"#2锅炉";
        self.type=2;
    }
    else
    {
        self.title = @"#1锅炉";
        self.type=0;
    }
    [self loadData];
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

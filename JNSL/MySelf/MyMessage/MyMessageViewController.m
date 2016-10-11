//
//  MyMessageViewController.m
//  JNSL
//
//  Created by zw on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "MyMessageViewController.h"

@interface MyMessageViewController ()
@property UITableView *tableView;
@property NSMutableArray *dataArray;
@property NSInteger pageIndex;
@end

@implementation MyMessageViewController
-(void)reloadData:(NSInteger)type
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (type==0) {
        self.pageIndex = 0;
    }
    else
    {
        self.pageIndex = self.dataArray.count;
    }
    dict[@"start"]=[NSString stringWithFormat:@"%ld",(long)self.pageIndex];
    dict[@"startTime"]=nil;
    dict[@"endTime"]=nil;
    [AFNetworkTool postJSONWithUrl:MyMessageURL parameters:dict success:^(id responseObject) {
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableArray *resultEntityArray = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"resultEntity"]];
            if (resultEntityArray.count>0) {
                NSMutableDictionary *resultEntityDict = resultEntityArray[0];
                NSArray *resultArray = resultEntityDict[@"data"];
                if (type==0) {
                    self.dataArray = [[NSMutableArray alloc] initWithArray:resultArray];
                }
                else
                {
                    [self.dataArray addObjectsFromArray:resultArray];
                }
                [self.tableView reloadData];
            }
        }
        else
        {
            NSString *resultDict = [json objectForKey:@"message"];
            NSLog(@"%@",resultDict);
        }
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    } fail:^{
        // 移除HUD
        [MBProgressHUD hideHUD];
        
        // 提醒有没有新数据
        [MBProgressHUD showError:@"请求失败"];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    self.title = @"我的消息";
    [self addViews];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBA(240, 240, 240, 1);
    self.tableView.tableHeaderView = [[UIView alloc] init];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MyMessageTableViewCell class] forCellReuseIdentifier:@"cell"];
    __weak __typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadData:0];
    }];
    self.tableView.footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [weakSelf reloadData:1];
    }];
    [self.view addSubview:self.tableView];
    [self.tableView.header beginRefreshing];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath] ;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    [cell loadDate:self.dataArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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

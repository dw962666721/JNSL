//
//  CommonQuestionViewController.m
//  JNSL
//
//  Created by zw on 16/10/7.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "CommonQuestionViewController.h"

@interface CommonQuestionViewController ()
@property UITableView *tableView;
@property NSMutableArray *dateList;
@property NSInteger PageIndex;
@end

@implementation CommonQuestionViewController
-(void)viewWillLayoutSubviews
{
        self.tableView.separatorInset = UIEdgeInsetsZero;
//        self.tableView.
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        }
}
-(void)loadData:(NSInteger)type
{
    if (type==0) {
        self.PageIndex=0;
    }
    else
    {
        self.PageIndex = self.dateList.count;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"start"]= [NSString stringWithFormat:@"%ld",(long)self.PageIndex];
    [AFNetworkTool postJSONWithUrl:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,CommonQuestionListURL] parameters:dict success:^(id responseObject) {
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableArray *resultEntity = [json objectForKey:@"resultEntity"];
            if (resultEntity.count>0) {
                NSDictionary *dataDict = resultEntity[0];
                NSArray *dataArray = [dataDict objectForKey:@"data"];
                if (type==0) {
                    self.dateList = [[NSMutableArray alloc] initWithArray:dataArray];
                }
                else
                {
                    [self.dateList addObjectsFromArray:dataArray];
                    if (dataArray.count==0) {
                        [MBProgressHUD showError:@"已到最后一页"];
//                        [self.tableView.footer s]
                    }
                }
                [self.tableView reloadData];
            }
            
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        }

    } fail:^{
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        // 移除HUD
        [MBProgressHUD hideHUD];
        
        // 提醒有没有新数据
        [MBProgressHUD showError:@"请求失败"];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateList = [[NSMutableArray alloc] init];
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    self.title=@"常见问题解决";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] init];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"cell"];
    __weak __typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData:0];
    }];
    self.tableView.footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
         [weakSelf loadData:1];
    }];
    [self.view addSubview:self.tableView];
    [self.tableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateList.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell setData:self.dateList[indexPath.row]];
    return  cell;
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IPHONE6||IPHONE6PLUS) {
        return 65;
    }
    return 45;
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

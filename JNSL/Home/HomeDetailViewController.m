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
@property UIScrollView *mainScrollView;
@property UITableView *tableView1;// 锅炉
@property UITableView *tableViewAll; // 汽机
@property UITableView *tableView2; // 环保
@property UITableView *currentTableView; // 当前tableView
@property NSMutableArray *dataArray1;
@property NSMutableArray *dataArrayAll;
@property NSMutableArray *dataArray2;
@property BOOL firstLoad;
@end

@implementation HomeDetailViewController
-(void)loadData
{
    if (self.firstLoad) {
        self.firstLoad=NO;
        if([userInfoJNSL getUserDict]!=nil)
        {
            return;
        }
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    switch (self.currentTableView.tag) {
        case 990:
            if (self.type==0) {
                dict[@"typeId"]=@"1";
//                self.title = @"#1锅炉";
            }
            else
            {
                dict[@"typeId"]=@"4";
//                self.title = @"#2锅炉";
            }
            break;
        case 991:
            if (self.type==0) {
                dict[@"typeId"]=@"2";
//                self.title = @"#1汽机";
            }
            else
            {
                dict[@"typeId"]=@"5";
//                self.title = @"#2汽机";
            }
            break;
        case 992:
            if (self.type==0) {
                dict[@"typeId"]=@"3";
//                self.title = @"#1环保";
            }
            else
            {
                dict[@"typeId"]=@"6";
//                self.title = @"#2环保";
            }
            break;
        default:
            break;
    }
     if (self.type==1) {
          dict[@"typeId"]=@"7";
     }
    [AFNetworkTool postJSONWithUrl:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,FacilityDetialInfoURL] parameters:dict success:^(id responseObject) {
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableArray *resultArray = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"resultEntity"]];
            
            switch (self.currentTableView.tag) {
                case 990:
                   self.dataArray1 = resultArray;
                    break;
                case 991:
                   self.dataArrayAll = resultArray;
                    break;
                case 992:
                    self.dataArray2 = resultArray;
                    break;
                default:
                    break;
            }
            
            [self.currentTableView reloadData];
        }
        else
        {
            NSString *resultDict = [json objectForKey:@"message"];
            NSLog(@"%@",resultDict);
        }
        [self.currentTableView.header endRefreshing];
    } fail:^{
        [self.currentTableView.header endRefreshing];
    }];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstLoad=YES;
    self.dataArray1 = [[NSMutableArray alloc] init];
    self.dataArrayAll = [[NSMutableArray alloc] init];
    self.dataArray2 = [[NSMutableArray alloc] init];
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
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadData) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
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
    [self.view addSubview:view];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, viewH, screenWidth, screenHeight-65-viewH)];
    self.mainScrollView.delegate = self;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    if (self.type!=1) {
        self.mainScrollView.contentSize = CGSizeMake(screenWidth*3, self.mainScrollView.frame.size.height);
    }
    [self.view addSubview:self.mainScrollView];
    
    // 添加锅炉
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65-viewH)];
    self.tableView1.delegate=self;
    self.tableView1.dataSource=self;
    self.tableView1.tag = 990;
    [ self.tableView1 registerClass:[HomeDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView1.tableHeaderView = [[UIView alloc] init];
    self.tableView1.tableFooterView = [[UIView alloc] init];
    __weak __typeof(self) weakSelf = self;
    self.tableView1.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    if ([self.tableView1 respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView1 setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView1 respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView1 setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self.mainScrollView addSubview:self.tableView1];
    
    // 添加汽机
    self.tableViewAll = [[UITableView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, screenHeight-65-viewH)];
    self.tableViewAll.delegate=self;
    self.tableViewAll.dataSource=self;
    self.tableViewAll.tag = 991;
    [ self.tableViewAll registerClass:[HomeDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableViewAll.tableHeaderView = [[UIView alloc] init];
    self.tableViewAll.tableFooterView = [[UIView alloc] init];
    self.tableViewAll.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    if ([self.tableViewAll respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableViewAll setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableViewAll respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableViewAll setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self.mainScrollView addSubview:self.tableViewAll];
    
    // 添加环保
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(screenWidth*2, 0, screenWidth, screenHeight-65-viewH)];
    self.tableView2.delegate=self;
    self.tableView2.dataSource=self;
    self.tableView2.tag = 992;
    [ self.tableView2 registerClass:[HomeDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView2.tableHeaderView = [[UIView alloc] init];
    self.tableView2.tableFooterView = [[UIView alloc] init];
    self.tableView2.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    if ([self.tableView2 respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView2 setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView2 respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView2 setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.mainScrollView addSubview:self.tableView2];
    
    self.currentTableView = self.tableView1;
   
    [self.currentTableView.header beginRefreshing];
    
}
-(void)setVCType:(NSInteger)type
{
    self.type = type;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.currentTableView.tag) {
        case 990:
            return self.dataArray1.count;
            break;
        case 991:
            return self.dataArrayAll.count;
            break;
        case 992:
            return self.dataArray2.count;
            break;
        default:
            break;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    switch (self.currentTableView.tag) {
        case 990:
             [cell setCellData:self.dataArray1[indexPath.row] row:indexPath.row];
            break;
        case 991:
             [cell setCellData:self.dataArrayAll[indexPath.row] row:indexPath.row];
            break;
        case 992:
             [cell setCellData:self.dataArray2[indexPath.row] row:indexPath.row];
            break;
        default:
            break;
    }
    return cell;
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

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView.superview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    NSInteger i=scrollView.contentOffset.x/screenWidth;
    if (i==0)
    {
        if (self.currentTableView != self.tableView1) {
            self.currentTableView = self.tableView1;
        }
    }
    else if (i==1)
    {
        if (self.currentTableView != self.tableViewAll) {
            self.currentTableView = self.tableViewAll;
            if (self.dataArrayAll.count==0) {
                [self loadData];
            }
        }
    }
    else
    {
        
        if (self.currentTableView != self.tableView2) {
            self.currentTableView = self.tableView2;
            if (self.dataArray2.count==0) {
                [self loadData];
            }
        }
    }
    [self updateTitle];
   
}

-(void)updateTitle
{
    if (self.type == 1) {
         self.title = @"公用";
        return;
    }
    switch (self.currentTableView.tag) {
        case 990:
            if (self.type==0) {
                self.title = @"#1锅炉";
            }
            else
            {
                self.title = @"#2锅炉";
            }
            break;
        case 991:
            if (self.type==0) {
                self.title = @"#1汽机";
            }
            else
            {
                self.title = @"#2汽机";
            }
            break;
        case 992:
            if (self.type==0) {
                self.title = @"#1环保";
            }
            else
            {
                self.title = @"#2环保";
            }
            break;
        default:
            break;
    }

}
-(void)changeView
{
    if (self.type==0) {
//        self.title = @"#2锅炉";
        self.type=2;
    }
    else
    {
//        self.title = @"#1锅炉";
        self.type=0;
    }
    [self updateTitle];
    [self.currentTableView.header beginRefreshing];
//    [self loadData];
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

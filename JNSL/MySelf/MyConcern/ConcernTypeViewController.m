//
//  ConcernTypeViewController.m
//  JNSL
//
//  Created by zw on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ConcernTypeViewController.h"

@interface ConcernTypeViewController ()
@property UIView *headView;
@property UITableView *tableView;
@property NSMutableArray *dataArray;
@end

@implementation ConcernTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict0 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"数据中断",@"name",@"0",@"isCheck", nil];
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"数据3倍以上",@"name",@"1",@"isCheck", nil];
    [self.dataArray addObject:dict0];
    [self.dataArray addObject:dict1];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    self.title=@"异常类型";
    [self addViews];
}
-(void)addViews
{
    NSInteger y = 10;
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(10, y, screenWidth-20, 40)];
    self.headView.backgroundColor = [UIColor whiteColor];
    self.headView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.headView.layer.borderWidth = 0.5;
//    self.headView.layer.cornerRadius=5;
    [self.view addSubview:self.headView];
    
    UILabel *headLb = [[UILabel alloc]initWithFrame:self.headView.bounds];
    headLb.textColor = RGBA(118, 118, 118, 1);
    headLb.text = @" 请选择问题类型";
    headLb.font = [UIFont systemFontOfSize:12];
    [self.headView addSubview:headLb];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.headView.frame)-2, self.headView.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.headView.frame)-80)];
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableView.layer.borderWidth = 0.5;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerClass:[ConcernTypeTableViewCell class] forCellReuseIdentifier:@"cell"];
    CGRect rect =  self.tableView.frame;
    rect.size.height = 40*self.dataArray.count-2;
    self.tableView.frame = rect;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.tableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConcernTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setData:self.dataArray[indexPath.row] last:(indexPath.row==self.dataArray.count-1)?YES:NO];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConcernTypeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setState];
}
//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ConcernTypeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
//}
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

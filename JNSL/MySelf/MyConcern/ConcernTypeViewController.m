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
-(void)loadData
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"userId"]=userInfoJNSL.userId;
    [MBProgressHUD showMessage:@"正在加载数据中....."];
    [AFNetworkTool postJSONWithUrl:FunctionRollMsgURL parameters:dict success:^(id responseObject) {
        // 移除HUD
        [MBProgressHUD hideHUD];
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableDictionary *resultDict = [json objectForKey:@"resultEntity"];
            NSMutableArray *selectArray = [[NSMutableArray alloc] initWithArray:[resultDict objectForKey:@"select"]];
            if (selectArray.count>0) {
                self.dataArray = selectArray;
                [self.tableView reloadData];
                CGRect rect =  self.tableView.frame;
                if (40*self.dataArray.count-2<rect.size.height) {
                    rect.size.height = 40*self.dataArray.count-2;
                    self.tableView.frame = rect;
                }
            }
        }
        
    } fail:^{
        // 移除HUD
        [MBProgressHUD hideHUD];
        
        // 提醒有没有新数据
        [MBProgressHUD showError:@"请求失败"];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.dataArray = [[NSMutableArray alloc] init];
//    NSMutableDictionary *dict0 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"数据中断",@"name",@"0",@"isCheck", nil];
//    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"数据3倍以上",@"name",@"1",@"isCheck", nil];
//    [self.dataArray addObject:dict0];
//    [self.dataArray addObject:dict1];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    self.title=@"异常类型";
    [self addViews];
    [self loadData];
}
-(void)addViews
{
    NSInteger y = 10;
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(10, y, screenWidth-20, 40)];
    self.headView.backgroundColor = [UIColor whiteColor];
    self.headView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.headView.layer.borderWidth = 0.5;
//    self.headView.backgroundColor = [UIColor yellowColor];
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
    if (cell.rightImageView.tag==991) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:self.dataArray[indexPath.row]];
        [dict setObject: @"1" forKey:@"checked"];
        [self.dataArray setObject:dict atIndexedSubscript:indexPath.row];
    }
    else
    {
         NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:self.dataArray[indexPath.row]];
        [dict setObject: @"0" forKey:@"checked"];
        [self.dataArray setObject:dict atIndexedSubscript:indexPath.row];
    }
    [self upData];
    
}
-(void)upData
{
    NSString *idStr = @"";
    for (NSInteger i=0; i<self.dataArray.count; i++) {
        if ( [self.dataArray[i][@"checked"]  isEqual: @"1"] || [self.dataArray[i][@"checked"] integerValue]  == 1) {
            if ([idStr isEqual:@""]) {
                idStr = [NSString stringWithFormat:@"%@%@",idStr,self.dataArray[i][@"asr_id"]];
            }
            else
            {
                idStr = [NSString stringWithFormat:@"%@%@%@",idStr,@",",self.dataArray[i][@"asr_id"]];
            }
        }
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"userId"]=userInfoJNSL.userId;
    dict[@"checkedIds"]=idStr;
       [MBProgressHUD showMessage:@"正在修改配置....."];
    [AFNetworkTool postJSONWithUrl:UpdateCheckedRollURL parameters:dict success:^(id responseObject) {
        // 移除HUD
        [MBProgressHUD hideHUD];
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
//            NSString *resultDict = [json objectForKey:@"message"];
//            NSLog(@"%@%@",dict[@"checkedIds"],resultDict);
        }
        else
        {
            NSString *resultDict = [json objectForKey:@"message"];
            NSLog(@"%@",resultDict);
            [MBProgressHUD showError:@"修改失败"];
        }
    } fail:^{
        // 移除HUD
        [MBProgressHUD hideHUD];
        
        // 提醒有没有新数据
        [MBProgressHUD showError:@"请求失败"];
    }];
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

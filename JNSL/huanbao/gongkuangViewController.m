//
//  gongkuangViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/1.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "gongkuangViewController.h"

@interface gongkuangViewController ()
{
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;
    NSMutableArray *_flagArray;
    NSMutableArray *_dicarr;
    gongkuangDetailsViewController *gongkuangDetails;
    yuanliDetailsViewController *yuanliDetails;
    zuoyongDetalsViewController *zuoyongDetails;
}
@end

@implementation gongkuangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工矿介绍";
    arr1 = [[NSArray alloc] initWithObjects:@"远程监控",@"判断在线数据准确性",@"分析结果", nil];
    arr2 = [[NSArray alloc] initWithObjects:@"物料平衡",@"关联关系",@"逻辑关系",@"环保检查经验", nil];
    arr3 = [[NSArray alloc] initWithObjects:@"异常规则",@"环保意义", nil];
    _dicarr = [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"1", nil];
    _flagArray  = [NSMutableArray array];
    [_flagArray addObjectsFromArray:[[NSArray alloc] initWithObjects:@"0",@"0",@"0", nil]];
    self.DataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65)];
    self.DataTable.dataSource = self;
    self.DataTable.delegate = self;
    self.DataTable.tableHeaderView = [[UIView alloc] init];
    self.DataTable.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.DataTable];
    self.DataTable.separatorColor =  ColorWithRGB(0xe0e0e0);
    if ([self.DataTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.DataTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.DataTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.DataTable setLayoutMargins:UIEdgeInsetsZero];
    }
    gongkuangDetails = [[gongkuangDetailsViewController alloc] init];
    yuanliDetails = [[yuanliDetailsViewController alloc] init];
    zuoyongDetails = [[zuoyongDetalsViewController alloc] init];
    
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

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;//返回标题数组中元素的个数来确定分区的个数
    
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_flagArray[section]  isEqual: @"0"]) {
        return 0;
    }else{
    switch (section) {
        case 0:
            return arr1.count;
            break;
        case 1:
            return arr2.count;
            break;
        case 2:
            return arr3.count;
            break;
        default:
            break;
    }
    return 0;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    zuoyongDetails.title = @"远程监控";
                    zuoyongDetails.img.image = [UIImage imageNamed:@"work_control"];
                    break;
                case 1:
                    zuoyongDetails.title = @"异常判断";
                    zuoyongDetails.img.image = [UIImage imageNamed:@"work_judge"];
                    break;
                case 2:
                    zuoyongDetails.title = @"分析结果";
                    zuoyongDetails.img.image = [UIImage imageNamed:@"work_analyse"];
                    break;
                default:
                    break;
            }
            [self.navigationController pushViewController:zuoyongDetails animated:true];
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    yuanliDetails.title = @"物料平衡";
                    break;
                case 1:
                    yuanliDetails.title = @"关联关系";
                    break;
                case 2:
                    yuanliDetails.title = @"逻辑关系";
                    break;
                case 3:
                    yuanliDetails.title = @"环保检查经验";
                    break;
                default:
                    break;
            }
            [self.navigationController pushViewController:yuanliDetails animated:true];
            break;

        case 2:
            switch (indexPath.row) {
                case 0:
                    gongkuangDetails.title = @"异常规则";
                    break;
                case 1:
                    gongkuangDetails.title = @"环保意义";
                    break;
                default:
                    break;
            }
            [self.navigationController pushViewController:gongkuangDetails animated:true];
            break;

        default:
            break;
    }
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = arr1[indexPath.row];
            break;
        case 1:
            cell.textLabel.text = arr2[indexPath.row];
            break;
        case 2:
            cell.textLabel.text = arr3[indexPath.row];
            break;
        default:
            break;
    }
    
    cell.textAlignment = UITextAlignmentCenter;
    cell.textLabel.textColor = ColorWithRGB(0x757373);
    cell.backgroundColor = ColorWithRGB(0xfffafa);
    return cell;
}




- ( UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
    view.backgroundColor = [UIColor clearColor];
    //上边框
//    CALayer *topLayer = [CALayer layer];
//    topLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
//    topLayer.frame = CGRectMake(0, 0, self.screenWid, 0.5);
//    [view.layer addSublayer:topLayer];
    //下边框
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.backgroundColor = ColorWithRGB(0xe0e0e0).CGColor;
    bottomLayer.frame = CGRectMake(0, view.frame.size.height-0.3, screenWidth, 0.5);
    [view.layer addSublayer:bottomLayer];
    
    view.layer.masksToBounds = true;
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 39)];
    lb.textColor = ColorWithRGB(0x757575);
    switch (section) {
        case 0:
            lb.text = @"作用";
            break;
        case 1:
            lb.text = @"原理";
            break;
        case 2:
            lb.text = @"工程异况";
            break;
        default:
            break;
    }
    //设置图片
    UIImageView *imgGroup = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-40, 10, 28, 18)];
    if ([_dicarr[section]  isEqual: @"0"]) {
        imgGroup.image = [UIImage imageNamed:@"group_up"];
    }else{
        imgGroup.image = [UIImage imageNamed:@"group_down"];
    }
    
    [view addSubview:imgGroup];
    [view addSubview:lb];
    view.tag = 100 + section;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
    [view addGestureRecognizer:tap];
    //view.backgroundColor = [UIColor redColor];
    return view;
}

- (void)sectionClick:(UITapGestureRecognizer *)tap{
    NSInteger index = tap.view.tag % 100;
    switch (index) {
        case 0:
            if ([_flagArray[index]  isEqual: @"0"]) {
                //展开
                _flagArray[index] = @"1";
                _dicarr[index] = @"0";
            }else{
                //收起
                _flagArray[index] = @"0";
                _dicarr[index] = @"1";
            }
            [self.DataTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
            [self.DataTable reloadSections:[NSIndexSet indexSetWithIndex:index+1] withRowAnimation:UITableViewRowAnimationFade];
            [self.DataTable reloadSections:[NSIndexSet indexSetWithIndex:index+2] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case 1:
            if ([_flagArray[index]  isEqual: @"0"]) {
                //展开
                _flagArray[index] = @"1";
                _dicarr[index] = @"0";
            }else{
                //收起
                _flagArray[index] = @"0";
                _dicarr[index] = @"1";
            }
            
            [self.DataTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
            [self.DataTable reloadSections:[NSIndexSet indexSetWithIndex:index-1] withRowAnimation:UITableViewRowAnimationFade];
            [self.DataTable reloadSections:[NSIndexSet indexSetWithIndex:index+1] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case 2:
            if ([_flagArray[index]  isEqual: @"0"]) {
                //展开
                _flagArray[index] = @"1";
                _dicarr[index] = @"0";
            }else{
                //收起
                _flagArray[index] = @"0";
                _dicarr[index] = @"1";
            }
            
            
            [self.DataTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
            //[self.DataTable reloadSections:[NSIndexSet indexSetWithIndex:index-1] withRowAnimation:UITableViewRowAnimationFade];
            //[self.DataTable reloadSections:[NSIndexSet indexSetWithIndex:index-2] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
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

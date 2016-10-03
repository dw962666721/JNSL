//
//  unusualReportViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "unusualReportViewController.h"

@interface unusualReportViewController ()

@end

@implementation unusualReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"异常报告";
    [self createtable];
    // Do any additional setup after loading the view.
}

-(void)createtable{
    self.datatable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65) style:UITableViewStylePlain];
    self.datatable.dataSource = self;
    self.datatable.delegate = self;
    [self.datatable registerClass:[excessiveEariningCellTableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.datatable.tableFooterView = [[UIView alloc] init];
    self.datatable.tableHeaderView = [[UIView alloc] init];
    [self.view addSubview:self.datatable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    excessiveEariningCellTableViewCell *cell = (excessiveEariningCellTableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[excessiveEariningCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
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

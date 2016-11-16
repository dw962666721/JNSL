//
//  ProductionReportViewController.m
//  JNSL
//
//  Created by zw on 2016/11/12.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ProductionReportViewController.h"

@interface ProductionReportViewController ()

@end

@implementation ProductionReportViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生产报表";
    [self addViews];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    //添加顶部年份月份控件
    //=================================================================================================
    self.yearMonthView = [[YearMonthView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 70)];
    self.yearMonthView.delegate = self;
    [self.view addSubview:self.yearMonthView];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|
    NSDayCalendarUnit;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    NSDateComponents *d = [cal components:unitFlags fromDate:[NSDate date]];//把要从date中获取的
    NSInteger year = [d year];
    NSInteger month = [d month];
    NSString *dateStr = [NSString stringWithFormat:@"%ld%@%ld",(long)year,@"-",(long)month];
    [self.yearMonthView setCurrentDateStr:dateStr];
    //=================================================================================================
    
    
    // 添加日历控件
    //=================================================================================================
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, screenWidth, screenHeight-65-70)];
    self.scrollView.contentSize = CGSizeMake(screenWidth*3,  screenHeight-65-70);
    [self.view addSubview:self.scrollView];
    
    
    self.leftTebleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, self.scrollView.frame.size.height) style:UITableViewStylePlain];
    self.leftTebleView.delegate = self;
    self.leftTebleView.dataSource=self;
    [self.leftTebleView registerClass:[WeekTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.scrollView addSubview:self.leftTebleView];
    
    self.centerTebleView = [[UITableView alloc] initWithFrame:CGRectMake(0, screenWidth, screenWidth, self.scrollView.frame.size.height) style:UITableViewStylePlain];
    self.centerTebleView.delegate = self;
    self.centerTebleView.dataSource=self;
    [self.centerTebleView registerClass:[WeekTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.scrollView addSubview:self.centerTebleView];
    
    self.rightTebleView = [[UITableView alloc] initWithFrame:CGRectMake(0, screenWidth*2, screenWidth, self.scrollView.frame.size.height) style:UITableViewStylePlain];
    self.rightTebleView.delegate = self;
    self.rightTebleView.dataSource=self;
    [self.rightTebleView registerClass:[WeekTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.scrollView addSubview:self.rightTebleView];
    
    //=================================================================================================
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeekTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setDayDict:indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
}
//常用方法 =================================================================================================
// 获取一个月有多少天
- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}
//第一天是周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}
//=================================================================================================
-(void)YearMonthViewLastYear:(NSString *)dateStr
{
    
}
-(void)YearMonthViewNextYear:(NSString *)dateStr
{
    
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

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
    self.currentDate = [NSDate date];
    self.selectedDate = [NSDate date];
    [self addViews];
    [self update];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self toLastMonth];
            [self toNextMonth];
        });
    });
    
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    //添加顶部年份月份控件
    //=================================================================================================
    self.yearMonthView = [[YearMonthView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 70)];
    self.yearMonthView.delegate = self;
    [self.view addSubview:self.yearMonthView];
    [self updateYearDate];
    
    //=================================================================================================
    
    
    // 添加日历控件
    //=================================================================================================
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, screenWidth, screenHeight-65-70)];
    self.scrollView.delegate=self;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.contentSize = CGSizeMake(screenWidth*3,  screenHeight-65-70);
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    
    self.leftTebleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, self.scrollView.frame.size.height)];
    self.leftTebleView.delegate = self;
    self.leftTebleView.dataSource=self;
    self.leftTebleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.leftTebleView registerClass:[WeekTableViewCell class] forCellReuseIdentifier:@"cellLeft"];
    [self.scrollView addSubview:self.leftTebleView];
    [self.leftTebleView reloadData];
    
    self.centerTebleView = [[UITableView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, self.scrollView.frame.size.height)];
    self.centerTebleView.delegate = self;
    self.centerTebleView.dataSource=self;
    self.centerTebleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.centerTebleView registerClass:[WeekTableViewCell class] forCellReuseIdentifier:@"cellCenter"];
    [self.scrollView addSubview:self.centerTebleView];
    [self.centerTebleView reloadData];
    
    self.rightTebleView = [[UITableView alloc] initWithFrame:CGRectMake(screenWidth*2,0, screenWidth, self.scrollView.frame.size.height)];
    self.rightTebleView.delegate = self;
    self.rightTebleView.dataSource=self;
    self.rightTebleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.rightTebleView registerClass:[WeekTableViewCell class] forCellReuseIdentifier:@"cellRight"];
    [self.scrollView addSubview:self.rightTebleView];
    [self.rightTebleView reloadData];
    
    //=================================================================================================
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IPHONE6||IPHONE6PLUS) {
        return 100;
    }
    return 75;
}
-(void)selectedAction
{
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeekTableViewCell *cell;
    if (tableView==self.leftTebleView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellLeft" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        NSTimeInterval  interval =24*60*60*30; //1:天数
       NSDate*date = [NSDate dateWithTimeInterval:-interval sinceDate:self.currentDate];
        [cell setDayDict:[self firstDay:indexPath.row date:date]];
    }
    else if (tableView==self.centerTebleView)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellCenter" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell setDayDict:[self firstDay:indexPath.row date:self.currentDate]];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellRight" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        NSTimeInterval  interval =24*60*60*30; //1:天数
        NSDate*date = [NSDate dateWithTimeInterval:interval sinceDate:self.currentDate];
        [cell setDayDict:[self firstDay:indexPath.row date:date]];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}


//常用方法 =================================================================================================

// 根据行数获取第一天日期
-(NSMutableDictionary*)firstDay:(NSInteger)index date:(NSDate*)date
{
    NSInteger firstWeek = [self firstWeekdayInThisMonth:date];
    NSInteger totalDays = [self totaldaysInThisMonth:date];
    NSString *currentDateStr = [self dateToString:date withDateFormat:@"yyyy-MM"];
    NSInteger firstDay;
    if (index==0) {
        NSTimeInterval  interval =24*60*60*30; //1:天数
        NSDate*lastDate = [NSDate dateWithTimeInterval:-interval sinceDate:date];
        NSInteger lastDayNum = [self totaldaysInThisMonth:lastDate];
        
        firstDay = lastDayNum-firstWeek+2;
        if (firstWeek==1) {
            firstDay=1;
            return [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"1", @"2",@"2",@"3",@"3",@"4",@"4",@"5",@"5",@"6",@"6",@"7",@"7",[NSString stringWithFormat:@"%d",totalDays],@"totalDays",[NSString stringWithFormat:@"%d",index],@"indexRow",[self dateToString:self.selectedDate withDateFormat:@"yyyy-MM-dd"],@"dateStr",currentDateStr,@"currentYYYYMM", nil];
        }
        else
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            NSString *unUseDays = @"";
            for (NSInteger i =1; i<8; i++) {
                if (firstWeek>i) {
                    [dict setObject:[NSString stringWithFormat:@"%d",lastDayNum+1-firstWeek+i] forKey:[NSString stringWithFormat:@"%d",i]];
                    unUseDays=[NSString stringWithFormat:@"%@%@%@",unUseDays,@"|",[NSString stringWithFormat:@"%d",lastDayNum+1-firstWeek+i]];
                }
                else
                {
                    [dict setObject:[NSString stringWithFormat:@"%d",i-firstWeek+1] forKey:[NSString stringWithFormat:@"%d",i]];
                }
            }
            [dict setObject:[NSString stringWithFormat:@"%d",index] forKey:@"indexRow"];
            [dict setObject:unUseDays forKey:@"unUseDays"];
            [dict setObject:[NSString stringWithFormat:@"%ld",totalDays] forKey:@"totalDays"];
            [dict setObject:[self dateToString:self.selectedDate withDateFormat:@"yyyy-MM-dd"] forKey:@"dateStr"];
            [dict setObject:currentDateStr forKey:@"currentYYYYMM"];
            return dict;
        }
    }
    else
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSString *unUseDays = @"";
        firstDay = 9-firstWeek+7*(index-1);
        for (NSInteger i =1; i<8; i++) {
            NSInteger dayNum = firstDay+i-1;
            if (dayNum>totalDays) {
                [dict setObject:[NSString stringWithFormat:@"%d",dayNum-totalDays] forKey:[NSString stringWithFormat:@"%d",i]];
                unUseDays=[NSString stringWithFormat:@"%@%@%@",unUseDays,@"|",[NSString stringWithFormat:@"%d",dayNum-totalDays]];
            }
            else
            {
                [dict setObject:[NSString stringWithFormat:@"%d",firstDay+i-1] forKey:[NSString stringWithFormat:@"%d",i]];
            }
        }
        [dict setObject:[NSString stringWithFormat:@"%d",index] forKey:@"indexRow"];
        [dict setObject:unUseDays forKey:@"unUseDays"];
        [dict setObject:[NSString stringWithFormat:@"%d",totalDays] forKey:@"totalDays"];
        [dict setObject:[self dateToString:self.selectedDate withDateFormat:@"yyyy-MM-dd"] forKey:@"dateStr"];
        [dict setObject:currentDateStr forKey:@"currentYYYYMM"];
        return dict;
    }
    
}
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
    NSInteger result = firstWeekday - 1;
    if (result==7) {
        result=1;
    }
    else
    {
        result = result+1;
    }
    return result;
}
//=================================================================================================
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView.superview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    NSInteger i=scrollView.contentOffset.x/screenWidth;
    if (i==0)
    {
        NSTimeInterval  interval =24*60*60*30; //1:天数
        self.currentDate = [self.currentDate dateByAddingTimeInterval:-interval];
    }
    else if (i==1)
    {
        
    }
    else
    {
        NSTimeInterval  interval =24*60*60*30; //1:天数
        self.currentDate = [self.currentDate dateByAddingTimeInterval:interval];
    }
    [self update];
}
-(void)update
{
    [self updateYearDate];
//    [self.leftTebleView  dealloc];
    [self.leftTebleView reloadData];
    [self.centerTebleView reloadData];
    [self.rightTebleView reloadData];
    [self.scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
}
-(void)updateYearDate
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|
    NSDayCalendarUnit;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    NSDateComponents *d = [cal components:unitFlags fromDate:self.currentDate];//把要从date中获取的
    NSInteger year = [d year];
    NSInteger month = [d month];
    NSString *dateStr = [NSString stringWithFormat:@"%d%@%d",year,@"-",month];
    [self.yearMonthView setCurrentDateStr:dateStr];
}
-(void)WeekTableViewCellClearSelected
{
//    for (NSInteger i=0; i<6; i++) {
//        WeekTableViewCell *cell = [self.centerTebleView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
//        [cell clearSelected];
//    }
//    [self.centerTebleView reloadData];
}
-(void)clearSelected
{
    for (NSInteger i=0; i<6; i++) {
        WeekTableViewCell *cell = [self.centerTebleView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        cell.selectedView.hidden = YES;
//        [cell clearSelected];
    }
}

-(void)WeekTableViewCellSelectedIndex:(NSInteger)day
{
//    [self clearSelected];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|
    NSDayCalendarUnit;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    NSDateComponents *d = [cal components:unitFlags fromDate:self.currentDate];//把要从date中获取的
    NSInteger year = [d year];
    NSInteger month = [d month];
    NSString *monthStr = [NSString stringWithFormat:@"%d",month];
    if (month<10) {
        monthStr=[NSString stringWithFormat:@"%@%d",@"0",month];
    }
    NSString *dayStr = [NSString stringWithFormat:@"%d",day];
    if (day<10) {
        dayStr=[NSString stringWithFormat:@"%@%d",@"0",day];
    }
    NSString *dateStr = [NSString stringWithFormat:@"%d%@%@%@%@%@",year,@"-",monthStr,@"-",dayStr,@" 15:13:12"];
    self.selectedDate = [self stringToDate:dateStr withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [self.centerTebleView reloadData];
    ReportViewController *reportVC = [[ReportViewController alloc] init];
    [reportVC setData:[NSString stringWithFormat:@"%d%@%@%@%@",year,@"-",monthStr,@"-",dayStr]];
    [self.navigationController pushViewController:reportVC animated:YES];
}
//日期格式转字符串
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
//字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [self worldTimeToChinaTime:date];
}
//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}
-(void)YearMonthViewLastYear:(NSString *)dateStr
{
    [self toLastMonth];
}
-(void)toLastMonth
{
    NSTimeInterval  interval =24*60*60*30; //1:天数
    self.currentDate = [self.currentDate dateByAddingTimeInterval:-interval];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //    [UIView animateWithDuration:0.25 animations:^{
    [self update];
    //    }];
}
-(void)YearMonthViewNextYear:(NSString *)dateStr
{
    [self toNextMonth];
}
-(void)toNextMonth
{
    NSTimeInterval  interval =24*60*60*30; //1:天数
    self.currentDate = [self.currentDate dateByAddingTimeInterval:interval];
    [self.scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:YES];
    //    [UIView animateWithDuration:0.25 animations:^{
    [self update];
    //    }];
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

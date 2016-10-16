//
//  overproofSeachViewController.m
//  JNSL
//
//  Created by zw on 16/10/15.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "overproofSeachViewController.h"



@interface overproofSeachViewController ()<HooDatePickerDelegate>
{
    
    NSString *selectbegintime;
}
@end

@implementation overproofSeachViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    selectbegintime = @"";
    [self creatView];
    [self createPanelView];
    [self addViewClick];
    self.title = @"筛选";
    
    // Do any additional setup after loading the view.
}

-(void)addViewClick{
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickcancel)];
    [self.view addGestureRecognizer:singleTap1];
}

-(void)pickcancel{
    [self.datePicker dismiss];
}

-(void)creatView{
    self.wura = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 100, 30)];
    self.wura.text = @"选择时间";
    self.wuratext = [[UIButton alloc] initWithFrame:CGRectMake(120, 20, screenWidth-140, 30)];
    self.wuratext.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.wuratext setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 29, screenWidth-140, 1)];
    line1.backgroundColor = [UIColor grayColor];
    
    [self.wuratext addSubview:line1];
    [self.wuratext addTarget:self action:@selector(typeClick) forControlEvents:UIControlEventTouchDown];
    
    
    [self.view addSubview:self.wura];
    [self.view addSubview:self.wuratext];
    
    self.pageConfirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, screenWidth-20, 40)];
    self.pageConfirmBtn.backgroundColor = [UIColor redColor];
    [self.pageConfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.pageConfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.pageConfirmBtn];
    [self.pageConfirmBtn addTarget:self action:@selector(pageConfirm) forControlEvents:UIControlEventTouchDown];
}

-(void)pageConfirm{
    if ([selectbegintime  isEqual: @""]) {
        [MBProgressHUD showError:@"请选择开始时间"];
        return;
    }
    if (self.serachprotocal != nil) {
        [self.serachprotocal searchClick:selectbegintime];
    }
    [self.navigationController popViewControllerAnimated:true];
    
}

-(void)typeClick{
    [self.datePicker show];
}

-(void)createPanelView{
    // Do any additional setup after loading the view, typically from a nib.
    self.datePicker = [[HooDatePicker alloc] initWithSuperView:self.view];
    self.datePicker.delegate = self;
    self.datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
    NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
    [dateFormatter setDateFormat:kDateFormatYYYYMMDD];
    NSDate *maxDate = [dateFormatter dateFromString:@"2050-01-01"];
    NSDate *minDate = [dateFormatter dateFromString:@"1975-01-01"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    self.datePicker.locale = locale;
    
    //[self.datePicker setDate:[NSDate date] animated:YES];
    self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = maxDate;
}


#pragma mark - FlatDatePicker Delegate



- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate*)date {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *value = [dateFormatter stringFromDate:date];
    selectbegintime = value;
    [self.wuratext setTitle:value forState:UIControlStateNormal];
    
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

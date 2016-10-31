//
//  excessiveSearchViewController.m
//  JNSL
//
//  Created by zw on 16/10/15.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "excessiveSearchViewController.h"

@interface excessiveSearchViewController ()
{
    NSInteger selecttype;
    NSString *selectwuranwu;
    NSString *selectbegintime;
    NSString *selectendtime;
    NSInteger selectwuranindex;
    NSString *pagetype;
}
@end

@implementation excessiveSearchViewController

- (void)viewDidLoad {
    selectwuranwu = @"";
    selectbegintime = @"";
    selectendtime = @"";
    self.title = @"筛选";
    pagetype = @"express";
    [super viewDidLoad];
    [self addData];
    [self creatView];
    
    [self addViewClick];
    
    // Do any additional setup after loading the view.
}

-(void)addData{
    
    if (self.arr1.count == 0) {
        pagetype = @"unurall";
        self.arr1 = [[NSMutableArray alloc] init];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"userId"]=userInfoJNSL.userId;
        [MBProgressHUD showMessage:@"正在加载数据中....." toView:self.view];
        [AFNetworkTool postJSONWithUrl:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,FunctionRollMsgURL] parameters:dict success:^(id responseObject) {
            // 移除HUD
            [MBProgressHUD hideHUDForView:self.view];
            NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSString *result = [json objectForKey:@"resultCode"];
            if ([result isEqual:@"true"]) {
                NSMutableDictionary *resultDict = [json objectForKey:@"resultEntity"];
                NSMutableArray *selectArray = [[NSMutableArray alloc] initWithArray:[resultDict objectForKey:@"select"]];
                if (selectArray.count>0) {
                    for (int i = 0; i < selectArray.count; i++) {
                        NSDictionary *dic = selectArray[i];
                        if ( [selectArray[i][@"checked"]  isEqual: @"1"] || [selectArray[i][@"checked"] integerValue]  == 1) {
                            [self.arr1 addObject:dic];
                        }
                    }
                }
                [self createPanelView];
            }
            
        } fail:^{
            // 移除HUD
            [MBProgressHUD hideHUDForView:self.view];
            
            // 提醒有没有新数据
            [MBProgressHUD showError:@"请求失败"];
        }];
    }else{
        [self createPanelView];
    }
}

-(void)addViewClick{
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickcancel)];
    [self.view addGestureRecognizer:singleTap1];
}

-(void)creatView{
    self.wura = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 100, 30)];
    self.wura.text = @"污染物类型";
    self.wuratext = [[UIButton alloc] initWithFrame:CGRectMake(120, 20, screenWidth-140, 30)];
    self.wuratext.titleLabel.textAlignment = NSTextAlignmentCenter;
    if (self.arr1.count > 0) {
        selectwuranindex = 0;
        [self.wuratext setTitle:self.arr1[0] forState:UIControlStateNormal];
        selectwuranwu = self.arr1[0];
    }
    
    self.begintime = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 100, 30)];
    self.begintime.text = @"开始时间";
    self.begintimetext = [[UIButton alloc] initWithFrame:CGRectMake(120, 50, screenWidth-140, 30)];
    self.begintimetext.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.endtime = [[UILabel alloc] initWithFrame:CGRectMake(10, 85, 100, 30)];
    self.endtime.text = @"结束时间";
    self.endtimetext = [[UIButton alloc] initWithFrame:CGRectMake(120, 80, screenWidth-140, 30)];
    self.endtimetext.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.wuratext setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.begintimetext setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.endtimetext setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 29, screenWidth-140, 1)];
    line1.backgroundColor = [UIColor grayColor];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 29, screenWidth-140, 1)];
    line2.backgroundColor = [UIColor grayColor];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 29, screenWidth-140, 1)];
    line3.backgroundColor = [UIColor grayColor];
    
    [self.wuratext addSubview:line1];
    [self.wuratext addTarget:self action:@selector(typeClick) forControlEvents:UIControlEventTouchDown];
    [self.begintimetext addSubview:line2];
    [self.begintimetext addTarget:self action:@selector(beginClick) forControlEvents:UIControlEventTouchDown];
    [self.endtimetext addSubview:line3];
    [self.endtimetext addTarget:self action:@selector(endClick) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:self.wura];
    [self.view addSubview:self.wuratext];
    [self.view addSubview:self.begintime];
    [self.view addSubview:self.begintimetext];
    [self.view addSubview:self.endtime];
    [self.view addSubview:self.endtimetext];
    
    self.pageConfirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, screenWidth-20, 40)];
    self.pageConfirmBtn.backgroundColor = [UIColor redColor];
    [self.pageConfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.pageConfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.pageConfirmBtn];
    self.pageConfirmBtn.layer.masksToBounds = true;
    self.pageConfirmBtn.layer.cornerRadius = 8;
    [self.pageConfirmBtn addTarget:self action:@selector(pageConfirm) forControlEvents:UIControlEventTouchDown];
}

-(void)pageConfirm{
    if ([selectwuranwu  isEqual: @""]) {
        [MBProgressHUD showError:@"请选择污染物"];
        return;
    }
    if ([selectbegintime  isEqual: @""]) {
        [MBProgressHUD showError:@"请选择开始时间"];
        return;
    }
    if ([selectendtime  isEqual: @""]) {
        [MBProgressHUD showError:@"请选择结束时间"];
        return;
    }
    if (self.serachprotocal != nil) {
        if ([pagetype  isEqual: @"unurall"]) {
            if (selectwuranindex == 0) {
                [self.serachprotocal searchClick:@"-1" withbegintime:selectbegintime withendtime:selectendtime];
            }else{
                NSDictionary *dic = self.arr1[selectwuranindex-1];
                NSString *wuranID = [dic objectForKey:@"asr_id"];
                 [self.serachprotocal searchClick:wuranID withbegintime:selectbegintime withendtime:selectendtime];
            }
        }else{
            [self.serachprotocal searchClick:selectwuranwu withbegintime:selectbegintime withendtime:selectendtime];
        }
        
        
    }
    [self.navigationController popViewControllerAnimated:true];
    
}

-(void)typeClick{
    selecttype = 1;
    self.datePicker.hidden = true;
    self.typepick.hidden = false;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.panelView.frame = CGRectMake(0, screenHeight-314, screenWidth, 200);
    }];
}
-(void)beginClick{
    selecttype = 2;
    self.datePicker.hidden = false;
    self.typepick.hidden = true;
    [self.datePicker setDate:[NSDate date] animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.panelView.frame = CGRectMake(0, screenHeight-314, screenWidth, 200);
    }];
}
-(void)endClick{
    selecttype = 3;
    self.datePicker.hidden = false;
    self.typepick.hidden = true;
    [self.datePicker setDate:[NSDate date] animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.panelView.frame = CGRectMake(0, screenHeight-314, screenWidth, 200);
    }];
}

-(void)createPanelView{
    self.panelView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, 250)];
    self.panelView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.panelView];
    self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    self.confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth-100, 0, 80, 50)];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:ColorWithRGB(0x999999) forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(pickcancel) forControlEvents:UIControlEventTouchDown];
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:ColorWithRGB(0x999999) forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(pickconfirm) forControlEvents:UIControlEventTouchDown];
    self.cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.panelView addSubview:self.cancelBtn];
    [self.panelView addSubview:self.confirmBtn];
    
    self.typepick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 200)];
    self.typepick.backgroundColor = [UIColor whiteColor];
    self.typepick.delegate = self;
    self.typepick.dataSource = self;
    [self.panelView addSubview:self.typepick];
    //添加日期控件
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 200)];
    [self.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [self.datePicker setTimeZone:[NSTimeZone localTimeZone]];
    // 设置当前显示时间
    [self.datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [self.datePicker setMaximumDate:[NSDate date]];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    // 设置UIDatePicker的显示模式
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    // 当值发生改变的时候调用的方法
    self.datePicker.hidden = YES;
    [self.panelView addSubview:self.datePicker];
    self.panelView.backgroundColor = ColorWithRGB(0xf4f2f8);
    
}

-(void)pickcancel{
    [UIView animateWithDuration:0.5 animations:^{
        self.panelView.frame = CGRectMake(0, screenHeight, screenWidth, 200);
    }];
}


-(void)pickconfirm{
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    switch (selecttype) {
        case 1:
            if ([pagetype  isEqual: @"unurall"]) {
                if (selectwuranindex == 0) {
                    selectwuranwu = @"全部";
                }else{
                    NSDictionary *dic = self.arr1[selectwuranindex-1];
                    NSString *wuranname = [dic objectForKey:@"asr_name"];
                    selectwuranwu = wuranname;
                }
            }else{
                selectwuranwu = self.arr1[selectwuranindex];
            }
            
            [self.wuratext setTitle:selectwuranwu forState:UIControlStateNormal];
            break;
        case 2:
            selectbegintime = destDateString;
            [self.begintimetext setTitle:destDateString forState:UIControlStateNormal];
            break;
        case 3:
            selectendtime = destDateString;
            [self.endtimetext setTitle:destDateString forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.panelView.frame = CGRectMake(0, screenHeight, screenWidth, 200);
    }];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pagetype  isEqual: @"express"]) {
    return self.arr1.count;
    }else{
        return self.arr1.count+1;
    }
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    selectwuranindex = row;
    if ([pagetype  isEqual: @"express"]) {
        return  self.arr1[row];
    }else{
        if (row == 0) {
            return @"全部";
        }else{
            NSDictionary *dic = self.arr1[row-1];
            NSString *afname =   [dic objectForKey:@"asr_name"];
            return  afname;
        }
        
    }
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //self.nameLabel.text =self.foodNameArray[component][row];
    
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

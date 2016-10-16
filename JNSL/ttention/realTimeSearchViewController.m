//
//  realTimeSearchViewController.m
//  JNSL
//
//  Created by zw on 16/10/16.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "realTimeSearchViewController.h"

@interface realTimeSearchViewController ()
{
    
    NSString *selectwuranwu;
    int selectwuranindex;
}
@end

@implementation realTimeSearchViewController

- (void)viewDidLoad {
    selectwuranwu = @"";
    self.title = @"筛选";;
    [super viewDidLoad];
    [self addData];
    [self creatView];
    [self addViewClick];
    
    // Do any additional setup after loading the view.
}

-(void)addData{
    self.arr1 = [[NSMutableArray alloc] init];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"userId"]=userInfoJNSL.userId;
        [MBProgressHUD showMessage:@"正在加载数据中....." toView:self.view];
        [AFNetworkTool postJSONWithUrl:FunctionRollMsgURL parameters:dict success:^(id responseObject) {
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
    self.pageConfirmBtn.layer.masksToBounds = true;
    self.pageConfirmBtn.layer.cornerRadius = 8;
    [self.pageConfirmBtn addTarget:self action:@selector(pageConfirm) forControlEvents:UIControlEventTouchDown];
}

-(void)pageConfirm{
    if ([selectwuranwu  isEqual: @""]) {
        [MBProgressHUD showError:@"请选择污染物"];
        return;
    }
    if (self.serachprotocal != nil) {
        if (selectwuranindex == 0) {
            [self.serachprotocal searchClick:@"-1"];
        }else{
            NSDictionary *dic = self.arr1[selectwuranindex-1];
            NSString *wuranID = [dic objectForKey:@"asr_id"];
            [self.serachprotocal searchClick:wuranID];
        }
    }
    [self.navigationController popViewControllerAnimated:true];
    
}

-(void)typeClick{
    self.typepick.hidden = false;
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
    self.panelView.backgroundColor = ColorWithRGB(0xf4f2f8);
    
}

-(void)pickcancel{
    [UIView animateWithDuration:0.5 animations:^{
        self.panelView.frame = CGRectMake(0, screenHeight, screenWidth, 200);
    }];
}


-(void)pickconfirm{
    if (selectwuranindex == 0) {
        selectwuranwu = @"全部";
    }else{
        NSDictionary *dic = self.arr1[selectwuranindex-1];
        NSString *wuranname = [dic objectForKey:@"asr_name"];
        selectwuranwu = wuranname;
    }
    
    [self.wuratext setTitle:selectwuranwu forState:UIControlStateNormal];
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
    return self.arr1.count+1;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    selectwuranindex = row;
    if (row == 0) {
        return @"全部";
    }else{
        NSDictionary *dic = self.arr1[row-1];
        NSString *afname =   [dic objectForKey:@"asr_name"];
        return  afname;
    }
    
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

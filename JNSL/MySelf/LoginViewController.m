//
//  LoginViewController.m
//  TYLM
//
//  Created by zw on 16/9/28.
//  Copyright © 2016年 dw962666721. All rights reserved.
//

#import "LoginViewController.h"
@interface LoginViewController ()
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_login"]];
    // 创建控件
    [self addView];
}

-(void)addView
{
    NSInteger y=70;
    NSInteger logoW=70;
    NSInteger icoW=20;
    NSInteger leftSplit = 40;
    NSInteger viewH=35;
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth-logoW)/2, y, logoW, logoW)];
    self.logoImageView.image = [UIImage imageNamed:@"sis_logo2"];
    [self.view addSubview:self.logoImageView];
    
    // 用户名框
    y+=20+logoW;
    self.userView = [[UIView alloc] initWithFrame:CGRectMake(leftSplit, y, screenWidth-leftSplit*2, viewH)];
    self.userView.backgroundColor = ColorWithRGB(0xbab5b1);
    self.userView.layer.cornerRadius=5;
    [self.view addSubview:self.userView];
    
    self.userIcoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (viewH-icoW)/2, icoW, icoW)];
    self.userIcoImageView.image = [UIImage imageNamed:@"username_icon"];
    [self.userView addSubview:self.userIcoImageView];
    
    self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(52, 0, self.userView.frame.size.width-44, self.userView.frame.size.height)];
    [self.userView addSubview:self.userTextField];
    
    // 密码框
    y+=20+40;
    self.passWordtView = [[UIView alloc] initWithFrame:CGRectMake(leftSplit, y, screenWidth-leftSplit*2, viewH)];
    self.passWordtView.backgroundColor = ColorWithRGB(0xbab5b1);
    self.passWordtView.layer.cornerRadius=5;
    [self.view addSubview:self.passWordtView];
    
    self.passWordIcoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (viewH-icoW)/2, icoW, icoW)];
    self.passWordIcoImageView.image = [UIImage imageNamed:@"pwd_icon"];
    [self.passWordtView addSubview:self.passWordIcoImageView];
    
    self.passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(52, 0, self.passWordtView.frame.size.width-44, self.passWordtView.frame.size.height)];
    [self.passWordtView addSubview:self.passWordTextField];
    
    // 登录按钮
    y+=20+40;
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftSplit, y, (screenWidth-leftSplit*2-20)/2, 30)];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = ColorWithRGB(0x0057f7);
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    
    //配置
    self.setBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.loginBtn.frame)+20, y, (screenWidth-leftSplit*2-20)/2, 30)];
    [self.setBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.setBtn.backgroundColor = ColorWithRGB(0x0057f7);
    [self.setBtn addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    self.setBtn.layer.cornerRadius = 5;
    [self.setBtn setTitle:@"配置" forState:UIControlStateNormal];
    [self.view addSubview:self.setBtn];
    
     y=20+CGRectGetMaxY(self.loginBtn.frame);
    // 配置框
    self.serviewView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, 130)];
//    self.serviewView .backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.serviewView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSplit, 20, screenWidth, 15)];
    tipLabel.text = @"请输入服务器地址:";
    [tipLabel setTextColor:[UIColor whiteColor]];
    [self.serviewView addSubview:tipLabel];
    
    UITextField *serverTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(leftSplit, 45, screenWidth-leftSplit*2, viewH)];
    serverTextFiled.placeholder = @"如:192.168.11.102:8080";
    serverTextFiled.backgroundColor = [UIColor whiteColor];
    serverTextFiled.layer.cornerRadius = 5;
    [self.serviewView addSubview:serverTextFiled];
    
    UIButton *setSureBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftSplit, 100, screenWidth-leftSplit*2, 30)];
    setSureBtn.backgroundColor = ColorWithRGB(0xe87d37);
    [setSureBtn addTarget:self action:@selector(setSureAction) forControlEvents:UIControlEventTouchDragInside];
    [setSureBtn setTitle:@"确定" forState:UIControlStateNormal];
    setSureBtn.layer.cornerRadius = 5;
    [self.serviewView addSubview:setSureBtn];
}
-(void)setSureAction
{
}
-(void)loginAction
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"userName"]=@"mg";
    dict[@"passWord"]=@"123";
    [AFNetworkTool postJSONWithUrl:LoginURL parameters:dict success:^(id responseObject) {
       NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            [self.navigationController popViewControllerAnimated:true];
        }
        
    } fail:^{
        
    }];
}
-(void)setAction
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

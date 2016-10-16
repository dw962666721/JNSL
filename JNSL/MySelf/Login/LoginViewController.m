//
//  LoginViewController.m
//  TYLM
//
//  Created by zw on 16/9/28.
//  Copyright © 2016年 dw962666721. All rights reserved.
//

#import "LoginViewController.h"
@interface LoginViewController ()
@property UITextField *serverTextFiled;
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
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 20, 20)];
    self.backImageView.image = [UIImage imageNamed:@"back"];
    self.backImageView.contentMode = UIViewContentModeTopLeft;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    backView.userInteractionEnabled = YES;
    [self.view addSubview:backView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [backView addGestureRecognizer:tap];
    
    [self.view addSubview:self.backImageView];
    [self.view addSubview:backView];
    // 创建控件
    [self addView];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addView
{
    NSInteger y=50;
    NSInteger logoW=70;
    NSInteger icoW=20;
    NSInteger leftSplit = 50;
    NSInteger viewH=30;
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
    
    self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, self.userView.frame.size.width-45, self.userView.frame.size.height)];
    [self.userView addSubview:self.userTextField];
    
    // 密码框
    y+=20+30;
    self.passWordtView = [[UIView alloc] initWithFrame:CGRectMake(leftSplit, y, screenWidth-leftSplit*2, viewH)];
    self.passWordtView.backgroundColor = ColorWithRGB(0xbab5b1);
    self.passWordtView.layer.cornerRadius=5;
    [self.view addSubview:self.passWordtView];
    
    self.passWordIcoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (viewH-icoW)/2, icoW, icoW)];
    self.passWordIcoImageView.image = [UIImage imageNamed:@"pwd_icon"];
    [self.passWordtView addSubview:self.passWordIcoImageView];
    
    self.passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, self.passWordtView.frame.size.width-45, self.passWordtView.frame.size.height)];
    [self.passWordtView addSubview:self.passWordTextField];
    
    // 登录按钮
    y+=20+30;
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftSplit, y, (screenWidth-leftSplit*2-20)/2, 25)];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = ColorWithRGB(0x0057f7);
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:self.loginBtn];
    
    //配置
    self.setBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.loginBtn.frame)+20, y, (screenWidth-leftSplit*2-20)/2, 25)];
    [self.setBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.setBtn.backgroundColor = ColorWithRGB(0x0057f7);
    [self.setBtn addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    self.setBtn.layer.cornerRadius = 5;
    [self.setBtn setTitle:@"配置" forState:UIControlStateNormal];
    [self.setBtn setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:self.setBtn];
    
     y=15+CGRectGetMaxY(self.loginBtn.frame);
    // 配置框
    self.serviewView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, 130)];
//    self.serviewView .backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.serviewView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSplit, 20, screenWidth, 15)];
    tipLabel.text = @"请输入服务器地址:";
    tipLabel.font = [UIFont systemFontOfSize:12];
    [tipLabel setTextColor:[UIColor whiteColor]];
    [self.serviewView addSubview:tipLabel];
    
    self.serverTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(leftSplit, 45, screenWidth-leftSplit*2, viewH)];
    self.serverTextFiled.placeholder = @" 如:192.168.11.102:8080";
    self.serverTextFiled.backgroundColor = [UIColor whiteColor];
    self.serverTextFiled.layer.cornerRadius = 5;
    [self.serviewView addSubview:self.serverTextFiled];
    
    UIButton *setSureBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftSplit, 85, screenWidth-leftSplit*2, 25)];
    setSureBtn.backgroundColor = ColorWithRGB(0xe87d37);
    [setSureBtn addTarget:self action:@selector(setSureAction) forControlEvents:UIControlEventTouchDragInside];
    [setSureBtn setTitle:@"确定" forState:UIControlStateNormal];
    setSureBtn.layer.cornerRadius = 5;
     [setSureBtn setFont:[UIFont systemFontOfSize:12]];
    [self.serviewView addSubview:setSureBtn];
}
-(void)setSureAction
{
//    userInfoJNSL.ip = self.serverTextFiled.text;
}
-(void)loginAction
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"userName"]=self.userTextField.text;
    dict[@"passWord"]=self.passWordTextField.text;
    [MBProgressHUD showMessage:@"正在加载数据中....."];
    [AFNetworkTool postJSONWithUrl:LoginURL parameters:dict success:^(id responseObject) {
        // 移除HUD
        [MBProgressHUD hideHUD];
       NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSArray *userArray = [json objectForKey:@"resultEntity"];
            if (userArray.count==0) {
                return ;
            }
            NSDictionary *userInfo = userArray[0];

            userInfoJNSL.userName = self.userTextField.text;
            userInfoJNSL.userId = ([userInfo objectForKey:@"userId"]==nil ? @"" : [userInfo objectForKey:@"userId"]);
            userInfoJNSL.userIcon = [userInfo objectForKey:@"userIcon"]==nil?@"":[userInfo objectForKey:@"userIcon"];
            userInfoJNSL.rollName = [userInfo objectForKey:@"rollName"]==nil?@"":[userInfo objectForKey:@"rollName"];
            userInfoJNSL.email = [userInfo objectForKey:@"email"]==nil?@"":[userInfo objectForKey:@"email"];
            userInfoJNSL.phoneNum = [userInfo objectForKey:@"phoneNum"]==nil?@"":[json objectForKey:@"phoneNum"];
            userInfoJNSL.pollSourceId = [userInfo objectForKey:@"pollSourceId"]==nil?@"":[userInfo objectForKey:@"pollSourceId"];
            
            [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"JNSL"];
            [self.navigationController popViewControllerAnimated:YES];
            [self.navigationController popViewControllerAnimated:true];
        }
        
    } fail:^{
        // 移除HUD
        [MBProgressHUD hideHUD];
        
        // 提醒有没有新数据
        [MBProgressHUD showError:@"请求失败"];
    }];
}
-(void)setAction
{
    self.serviewView.hidden = !self.serviewView.hidden;
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
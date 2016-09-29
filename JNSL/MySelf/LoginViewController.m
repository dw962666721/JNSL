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
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth-logoW)/2, y, logoW, logoW)];
    self.logoImageView.image = [UIImage imageNamed:@"sis_logo2"];
    [self.view addSubview:self.logoImageView];
    
    y+=20;
    self.userView = [[UIView alloc] initWithFrame:CGRectMake(20, y, screenWidth-40, 45)];
    self.userView.backgroundColor = ColorWithRGB(0xbab5b1);
    self.userView.layer.cornerRadius=5;
    [self.view addSubview:self.userView];
    
    self.userIcoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, (45-40)/2, 40, 40)];
    self.userIcoImageView.image = [UIImage imageNamed:@"username_icon"];
    [self.userView addSubview:self.userIcoImageView];
    
    self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(44, 0, self.userView.frame.size.width-44, self.userView.frame.size.height)];
    self.userTextField.delegate = self;
    [self.userView addSubview:self.userTextField];
    
    y+=20;
    self.passWordtView = [[UIView alloc] initWithFrame:CGRectMake(20, y, screenWidth-40, 45)];
    self.passWordtView.backgroundColor = ColorWithRGB(0xbab5b1);
    self.passWordtView.layer.cornerRadius=5;
    [self.view addSubview:self.passWordtView];
    
    self.passWordIcoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, (45-40)/2, 40, 40)];
    self.passWordIcoImageView.image = [UIImage imageNamed:@"username_icon"];
    [self.passWordtView addSubview:self.passWordIcoImageView];
    
    self.passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(44, 0, self.passWordtView.frame.size.width-44, self.passWordtView.frame.size.height)];
    self.passWordTextField.delegate = self;
    [self.passWordtView addSubview:self.passWordTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
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

//
//  UserInformationViewController.m
//  JNSL
//
//  Created by zw on 16/9/30.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "UserInformationViewController.h"

@interface UserInformationViewController ()

@end

@implementation UserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    self.title=@"用户信息";
    [self addViews];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    NSInteger y=20;
    NSInteger leftSplit = 10;
    NSInteger viewH = 45;
    // 用户名
    self.userNameView = [[CustemButton alloc] initWithFrame:CGRectMake(leftSplit, y, screenWidth-leftSplit*2, viewH)];
    self.userNameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.userNameView];
    UILabel *userNameLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, viewH)];
    userNameLb.text=@"用户名";
    userNameLb.textColor=RGBA(118, 118, 118, 1);
    userNameLb.font = [UIFont boldSystemFontOfSize:13];
    [self.userNameView addSubview:userNameLb];
    
    UILabel *userNameLb0 = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, self.userNameView.frame.size.width - 100, viewH)];
    userNameLb0.text=userInfoJNSL.userName;
    userNameLb0.textColor=RGBA(118, 118, 118, 1);
    userNameLb0.textAlignment = NSTextAlignmentRight;
    userNameLb0.font = [UIFont boldSystemFontOfSize:12];
    [self.userNameView addSubview:userNameLb0];
    
    y=CGRectGetMaxY(self.userNameView.frame)+1;
    // 电话
    self.phoneView = [[CustemButton alloc] initWithFrame:CGRectMake(leftSplit, y, screenWidth-leftSplit*2, viewH)];
    self.phoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.phoneView];
    UILabel *phoneLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, viewH)];
    phoneLb.text=@"电话";
    phoneLb.textColor=RGBA(118, 118, 118, 1);
    phoneLb.font = [UIFont boldSystemFontOfSize:13];
    [self.phoneView addSubview:phoneLb];
    
    UILabel *phoneLb0 = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, self.phoneView.frame.size.width - 100, viewH)];
    phoneLb0.text=userInfoJNSL.phoneNum;
    phoneLb0.textColor=RGBA(118, 118, 118, 1);
    phoneLb0.textAlignment = NSTextAlignmentRight;
    phoneLb0.font = [UIFont boldSystemFontOfSize:12];
    [self.phoneView addSubview:phoneLb0];
    
    
     y=CGRectGetMaxY(self.phoneView.frame)+1;
    // Email
    self.emailView = [[CustemButton alloc] initWithFrame:CGRectMake(leftSplit, y, screenWidth-leftSplit*2, viewH)];
    self.emailView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.emailView];
    UILabel *emailLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, viewH)];
    emailLb.text=@"用户名";
    emailLb.textColor=RGBA(118, 118, 118, 1);
    emailLb.font = [UIFont boldSystemFontOfSize:13];
    [self.emailView addSubview:emailLb];
    
    UILabel *emailLb0 = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, self.userNameView.frame.size.width - 100, viewH)];
    emailLb0.text=userInfoJNSL.email;
    emailLb0.textColor=RGBA(118, 118, 118, 1);
    emailLb0.textAlignment = NSTextAlignmentRight;
    emailLb0.font = [UIFont boldSystemFontOfSize:12];
    [self.emailView addSubview:emailLb0];
    
     y=CGRectGetMaxY(self.emailView.frame)+10;
    // 退出
    self.exitButton = [[CustemButton alloc] initWithFrame:CGRectMake(leftSplit, y, screenWidth-leftSplit*2, viewH-10)];
    self.exitButton.backgroundColor = [UIColor whiteColor];
//    [self.exitButton addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.exitButton];
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.exitButton.frame), viewH-10)];
    titleLb.text=@"退出账号";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor=[UIColor blackColor];
    titleLb.font = [UIFont boldSystemFontOfSize:12];
    [self.exitButton addSubview:titleLb];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitAction)];
    [self.exitButton addGestureRecognizer:tap];
    
}
-(void)exitAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确认退出？", nil];
    [actionSheet showInView:self.view];
//    UIAlertController *alertControoler = [[UIAlertController alloc] ini];
//    alertControoler.alert
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [userInfoJNSL clearUserDict];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
          self.exitButton.backgroundColor = [UIColor whiteColor];
            break;
        default:
             self.exitButton.backgroundColor = [UIColor whiteColor];
            break;
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

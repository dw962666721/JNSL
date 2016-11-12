//
//  SystemSetViewController.m
//  JNSL
//
//  Created by zw on 16/10/7.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "SystemSetViewController.h"

@interface SystemSetViewController ()
@property CustemButton *systemVersionBtn;
@property UILabel *systemVersionLb;
@property UILabel *versionLb;
@property UIImageView *systemVersionImageView;
@property CustemButton *aboutUsBtn;
@property UILabel *aboutUsLb;
@property UIImageView *aboutUsImageView;
@end

@implementation SystemSetViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.systemVersionBtn.backgroundColor = [UIColor whiteColor];
    self.aboutUsBtn.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    self.title=@"系统设置";
    [self addViews];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    self.systemVersionBtn = [[CustemButton alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 60)];
    self.systemVersionBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.systemVersionBtn];
    
    self.systemVersionLb=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth-10, self.systemVersionBtn.frame.size.height)];
    self.systemVersionLb.text=@"检查版本更新";
    self.systemVersionLb.textColor= RGBA(118, 118, 118, 1);
    [self.systemVersionBtn addSubview:self.systemVersionLb];
    
    self.versionLb=[[UILabel alloc] initWithFrame:CGRectMake(screenWidth-80, 0, 50, self.systemVersionBtn.frame.size.height)];
    self.versionLb.text=@"V1.0";
    NSString *currentVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    if (currentVersion==nil||[currentVersion isEqual:@""]) {
        currentVersion = @"V1.0";
    }
    self.versionLb.text=currentVersion;
    self.versionLb.textColor= RGBA(118, 118, 118, 1);
    [self.systemVersionBtn addSubview:self.versionLb];

    
    self.systemVersionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-40, (self.systemVersionBtn.frame.size.height-30)/2, 30, 30)];
    self.systemVersionImageView.image = [UIImage imageNamed:@"arrow_right"];
    [self.systemVersionBtn addSubview:self.systemVersionImageView];
    
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getVersion)];
    [self.systemVersionBtn addGestureRecognizer:tap0];

    //
    self.aboutUsBtn = [[CustemButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.systemVersionBtn.frame)+1, screenWidth, self.systemVersionBtn.frame.size.height)];
    self.aboutUsBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.aboutUsBtn];
    
    self.aboutUsLb=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth-10, self.aboutUsBtn.frame.size.height)];
    self.aboutUsLb.text=@"关于我们";
    self.aboutUsLb.textColor= RGBA(118, 118, 118, 1);
    [self.aboutUsBtn addSubview:self.aboutUsLb];
    
    self.aboutUsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-40, (self.systemVersionBtn.frame.size.height-30)/2, 30, 30)];
    self.aboutUsImageView.image = [UIImage imageNamed:@"arrow_right"];
    [self.aboutUsBtn addSubview:self.aboutUsImageView];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(push)];
    [self.aboutUsBtn addGestureRecognizer:tap1];
}
-(void)getVersion
{
    NSString *currentVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    [MBProgressHUD showMessage:@"正在获取版本。。。" toView:self.view];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,GetVersionURL]);
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    dict[@"version"]=@"4.3";
    [AFNetworkTool postJSONWithUrl:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,GetVersionURL] parameters:nil success:^(id responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"success"];
        if ([result isEqual:@"true"]) {
            NSString *newVersion = [json objectForKey:@"version"];
            if (currentVersion==newVersion) {
                [MBProgressHUD showSuccess:@"你的版本已经是最新了"];
            }
            else
            {
//                [[NSUserDefaults standardUserDefaults] setObject:newVersion forKey:@"version"];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发现最新版本" message:@"是否更新新版本？" delegate:self cancelButtonTitle:@"不更新" otherButtonTitles:@"更新", nil];
                [alertView show];
            }
        }
        [MBProgressHUD hideHUDForView:self.view];
    } fail:^{
        // 移除HUD
        [MBProgressHUD hideHUDForView:self.view];
        // 提醒有没有新数据
        [MBProgressHUD showError:@"请求失败"];
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,NewAppURL]]];
    }
}
-(void)push
{
    AboutUsViewController *VC = [[AboutUsViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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

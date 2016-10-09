//
//  AboutUsViewController.m
//  JNSL
//
//  Created by zw on 16/10/7.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property UIImageView *logoImageView;
@property UIView *currentVersionView;
@property UIView *linkUsView;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    self.title=@"关于我们";
    [self addViews];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    // logo
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth-80)/2, 50, 80, 80)];
    self.logoImageView.image = [UIImage imageNamed:@"logo1"];
    [self.view addSubview:self.logoImageView];
    
    // 版本框
    self.currentVersionView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.logoImageView.frame)+50, screenWidth, 35)];
    self.currentVersionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.currentVersionView];
    
    UILabel *currentVersionLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, self.currentVersionView.frame.size.height)];
    currentVersionLb.text=@"  当前版本:";
    currentVersionLb.font = [UIFont systemFontOfSize:14];
    [self.currentVersionView addSubview:currentVersionLb];
    
    UILabel *versionLb = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-40, 0, 40, self.currentVersionView.frame.size.height)];
    versionLb.text=@"1.0.1";
    versionLb.font = [UIFont systemFontOfSize:13];
    [self.currentVersionView addSubview:versionLb];
    
    // 客服框
    self.linkUsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.currentVersionView.frame)+1, screenWidth, 50)];
    self.linkUsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.linkUsView];
    UILabel *kfPhone = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    kfPhone.text=@"  客服电话:";
    kfPhone.font = [UIFont systemFontOfSize:14];
    [self.linkUsView addSubview:kfPhone];
    
    UILabel *timeLb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(kfPhone.frame), 150, 20)];
    timeLb.text=@"  工作时间:9:00-17:00";
    timeLb.textColor = RGBA(115, 115, 115, 1);
    timeLb.font = [UIFont systemFontOfSize:13];
    [self.linkUsView addSubview:timeLb];
    
    UILabel *phoneLb = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-100, 0, 100, self.linkUsView.frame.size.height)];
    phoneLb.text=@"15034771131";
    phoneLb.font = [UIFont systemFontOfSize:14];
    phoneLb.textColor = [UIColor redColor];
    [self.linkUsView addSubview:phoneLb];
    
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

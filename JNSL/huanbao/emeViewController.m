//
//  emeViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/1.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "emeViewController.h"

@interface emeViewController ()

@end

@implementation emeViewController

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
    //设置背景图片
    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self.view setBackgroundColor:bgColor];
    CGFloat screenWid = ([UIScreen mainScreen].bounds.size.width-50)/4;
    UIImageView *gongkuang = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, screenWid, screenWid)];
    gongkuang.image = [UIImage imageNamed:@"gongkuangjieshao"];
    gongkuang.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick1)];
    [gongkuang addGestureRecognizer:singleTap1];
    
    UIImageView *huanbao = [[UIImageView alloc] initWithFrame:CGRectMake(screenWid+20, 50, screenWid, screenWid)];
    huanbao.image = [UIImage imageNamed:@"huanbaozhishi"];
    huanbao.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick2)];
    [huanbao addGestureRecognizer:singleTap2];
    
    UIImageView *zhifa = [[UIImageView alloc] initWithFrame:CGRectMake(screenWid*2+30, 50, screenWid, screenWid)];
    zhifa.image = [UIImage imageNamed:@"zhifaanli"];
    zhifa.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick3)];
    [zhifa addGestureRecognizer:singleTap3];
    
    UIImageView *zhengce = [[UIImageView alloc] initWithFrame:CGRectMake(screenWid*3+40, 50, screenWid, screenWid)];
    zhengce.image = [UIImage imageNamed:@"zhengcewenjian"];
    zhengce.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick4)];
    [zhengce addGestureRecognizer:singleTap4];
    [self.view addSubview:gongkuang];
    [self.view addSubview:huanbao];
    [self.view addSubview:zhifa];
    [self.view addSubview:zhengce];
    
    // Do any additional setup after loading the view.
}

- (void)imgClick1 {
    gongkuangViewController *gongkuangView = [[gongkuangViewController alloc] init];
    [self.navigationController pushViewController:gongkuangView animated:true];
}
- (void)imgClick2 {
    huanbaoViewController *gongkuangView = [[huanbaoViewController alloc] init];
    [self.navigationController pushViewController:gongkuangView animated:true];
}
- (void)imgClick3 {
    zhifaViewController *gongkuangView = [[zhifaViewController alloc] init];
    gongkuangView.title = @"执法案例";
    gongkuangView.viewtype = @"zhifa";
    [self.navigationController pushViewController:gongkuangView animated:true];
    
}
- (void)imgClick4 {
    zhifaViewController *gongkuangView = [[zhifaViewController alloc] init];
    gongkuangView.title = @"政策文件";
    gongkuangView.viewtype = @"gongkuang";
    [self.navigationController pushViewController:gongkuangView animated:true];
    
    
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

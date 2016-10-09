//
//  SystemSetViewController.m
//  JNSL
//
//  Created by zw on 16/10/7.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "SystemSetViewController.h"

@interface SystemSetViewController ()
@property CustemButton *aboutUsBtn;
@property UILabel *aboutUsLb;
@property UIImageView *aboutUsImageView;
@end

@implementation SystemSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    self.title=@"系统设置";
    [self addViews];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    self.aboutUsBtn = [[CustemButton alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 45)];
    self.aboutUsBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.aboutUsBtn];
    
    self.aboutUsLb=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth-10, self.aboutUsBtn.frame.size.height)];
    self.aboutUsLb.text=@"关于我们";
    self.aboutUsLb.textColor= RGBA(118, 118, 118, 1);
    [self.aboutUsBtn addSubview:self.aboutUsLb];
    
    self.aboutUsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-40, (45-30)/2, 30, 30)];
    self.aboutUsImageView.image = [UIImage imageNamed:@"arrow_right"];
    [self.aboutUsBtn addSubview:self.aboutUsImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(push)];
    [self.aboutUsBtn addGestureRecognizer:tap];
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

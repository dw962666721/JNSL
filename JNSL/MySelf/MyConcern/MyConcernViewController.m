//
//  MyConcernViewController.m
//  JNSL
//
//  Created by zw on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "MyConcernViewController.h"

@interface MyConcernViewController ()
@property CustemButton *excentBtn;
@property UILabel *excentLb;
@property UIImageView *nextImageView;
@end

@implementation MyConcernViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.excentBtn.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    self.title=@"我的关注";
    [self addViews];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    self.excentBtn = [[CustemButton alloc] initWithFrame:CGRectMake(0, 10, screenWidth, 45)];
    self.excentBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.excentBtn];
    
    self.excentLb=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth-10, self.excentBtn.frame.size.height)];
    self.excentLb.text=@"异常类型";
    self.excentLb.textColor= RGBA(118, 118, 118, 1);
    [self.excentBtn addSubview:self.excentLb];
    
    self.nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-40, (45-30)/2, 30, 30)];
    self.nextImageView.image = [UIImage imageNamed:@"arrow_right"];
    [self.excentBtn addSubview:self.nextImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(push)];
    [self.excentBtn addGestureRecognizer:tap];
}
-(void)push
{
    ConcernTypeViewController *VC = [[ConcernTypeViewController alloc] init];
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

//
//  ServiceCenterViewController.m
//  JNSL
//
//  Created by zw on 16/10/5.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ServiceCenterViewController.h"

@interface ServiceCenterViewController ()
@property CustemButton *sendQuestionBtn;
@property UILabel *sendQuestionLb;
@property UIImageView *sendQuestionImageView;

@property CustemButton *CommonQuestionBtn;
@property UILabel *CommonQuestionLb;
@property UIImageView *CommonQuestionImageView;
@end

@implementation ServiceCenterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.sendQuestionBtn.backgroundColor = [UIColor whiteColor];
    self.CommonQuestionBtn.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    self.title=@"服务中心";
    [self addViews];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    self.sendQuestionBtn = [[CustemButton alloc] initWithFrame:CGRectMake(0, 10, screenWidth, 45)];
    self.sendQuestionBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sendQuestionBtn];
    
    self.sendQuestionLb=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth-10, self.sendQuestionBtn.frame.size.height)];
    self.sendQuestionLb.text=@"问题留言";
    self.sendQuestionLb.textColor= RGBA(118, 118, 118, 1);
    [self.sendQuestionBtn addSubview:self.sendQuestionLb];
    
    self.sendQuestionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-40, (45-30)/2, 30, 30)];
    self.sendQuestionImageView.image = [UIImage imageNamed:@"arrow_right"];
    [self.sendQuestionBtn addSubview:self.sendQuestionImageView];
    
    self.CommonQuestionBtn = [[CustemButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sendQuestionBtn.frame)+10, screenWidth, 45)];
    self.CommonQuestionBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.CommonQuestionBtn];
    
    self.CommonQuestionLb=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth-10, self.CommonQuestionBtn.frame.size.height)];
    self.CommonQuestionLb.text=@"常见问题";
    self.CommonQuestionLb.textColor= RGBA(118, 118, 118, 1);
    [self.CommonQuestionBtn addSubview:self.CommonQuestionLb];
    
    self.CommonQuestionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-40, (45-30)/2, 30, 30)];
    self.CommonQuestionImageView.image = [UIImage imageNamed:@"arrow_right"];
    [self.CommonQuestionBtn addSubview:self.CommonQuestionImageView];
    
    UITapGestureRecognizer *sendQuestionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendQuestionPush)];
    [self.CommonQuestionBtn addGestureRecognizer:sendQuestionTap];
    
    UITapGestureRecognizer *CommonQuestionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CommonQuestionPush)];
    [self.sendQuestionBtn addGestureRecognizer:CommonQuestionTap];
}
-(void)sendQuestionPush
{
    CommonQuestionViewController *view = [[CommonQuestionViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}
-(void)CommonQuestionPush
{
    SendQuestionViewController *view = [[SendQuestionViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
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

//
//  MySelfViewController.m
//  TYLM
//
//  Created by zw on 16/9/28.
//  Copyright © 2016年 dw962666721. All rights reserved.
//

#import "MySelfViewController.h"

@interface MySelfViewController ()

@end

@implementation MySelfViewController
//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if(self)
//    {
//        self.view.backgroundColor = [UIColor lightGrayColor];
//        [self addTopView];
//
//    }
//    return self;
//}
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
    self.view.backgroundColor = RGBA(229, 230, 232, 1);
    // 创建控件
    [self addTopView];
    
    
}
-(void)addTopView
{
    NSInteger y=0;
    NSInteger userWidth = 80;
    NSInteger topViewHeigth = 200;
    if (IPHONE4) {
        userWidth=60;
        topViewHeigth=150;
    }
    self.topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, topViewHeigth)];
    self.topBackView.backgroundColor = ColorWithRGB(0x45a1d4);
    [self.view addSubview:self.topBackView];
    
    self.userLogoView = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth-userWidth)/2, (topViewHeigth-userWidth)/2, userWidth, userWidth)];
    self.userLogoView.image = [UIImage imageNamed:@"me_unlogin"];
    [self.topBackView addSubview:self.userLogoView];
    
    self.userNameLb = [[UILabel alloc] initWithFrame:CGRectMake(0, (topViewHeigth-userWidth)/2+userWidth+10, screenWidth, 10)];
    self.userNameLb.text = @"未登录";
    self.userNameLb.textColor = ColorWithRGB(0x1b6690);
    self.userNameLb.font = [UIFont systemFontOfSize:12];
    self.userNameLb.textAlignment = NSTextAlignmentCenter;
    [self.topBackView addSubview:self.userNameLb];
    
    NSInteger splitH = 15;
    NSInteger viewH =50;
    if (IPHONE4) {
        viewH=45;
    }
//    NSInteger viewH = (self.view.frame.size.height-46 - CGRectGetMaxY(self.topBackView.frame) - splitH*2-3)/5;
    
    y= CGRectGetMaxY(self.topBackView.frame)+splitH;
    self.myMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, viewH)];
    self.myMessageView.tag = 991;
    self.myMessageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myMessageView];
    
    y+=1+viewH;
    self.myGzView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, viewH)];
    self.myGzView.tag = 992;
    self.myGzView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myGzView];
    
    y+=1+viewH;
    self.tSSetView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, viewH)];
    self.tSSetView.tag = 993;
    self.tSSetView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tSSetView];
    
    y+=1+viewH+splitH;
    self.serverCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, viewH)];
    self.serverCenterView.tag = 994;
    self.serverCenterView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.serverCenterView];
    
    y+=1+viewH;
    self.systemSetView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, viewH)];
    self.systemSetView.tag = 995;
    self.systemSetView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.systemSetView];
    
    // 填充View内容
    [self viewAddSubView:self.myMessageView];
     [self viewAddSubView:self.myGzView];
     [self viewAddSubView:self.tSSetView];
     [self viewAddSubView:self.serverCenterView];
     [self viewAddSubView:self.systemSetView];
    
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchLogin)];
    [self.userLogoView addGestureRecognizer:Tap];
    self.userLogoView.userInteractionEnabled = YES;
}
-(void)viewAddSubView:(UIView*)view
{
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (view.frame.size.height-30)/2+2, 30, 30)];
    UILabel *textLb = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, screenWidth-70, view.frame.size.height)];
    textLb.textAlignment = NSTextAlignmentLeft;
    textLb.textColor = RGBA(118, 118, 118, 1);
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-40, (view.frame.size.height-30)/2, 30, 30)];
    rightImageView.image = [UIImage imageNamed:@"arrow_right"];
    switch (view.tag-990) {
        case 1:
            logoImageView.image = [UIImage imageNamed:@"me_my_message"];
            textLb.text=@"我的消息";
            break;
        case 2:
            logoImageView.image = [UIImage imageNamed:@"me_my_attention"];
             textLb.text=@"我的关注";
            break;
        case 3:
            logoImageView.image = [UIImage imageNamed:@"me_push_settings"];
             textLb.text=@"推送设置";
            break;
        case 4:
            logoImageView.image = [UIImage imageNamed:@"me_service_center"];
             textLb.text=@"服务中心";
            break;
        case 5:
            logoImageView.image = [UIImage imageNamed:@"me_system_settings"];
             textLb.text=@"系统设置";
            break;
        default:
            break;
    }
    [view addSubview:logoImageView];
    [view addSubview:textLb];
    [view addSubview:rightImageView];
}
-(void)touchLogin
{
    if (userInfoJNSL.userDict==nil) {
        
        LoginViewController *loginView=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginView animated:YES];

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

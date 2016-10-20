//
//  realTechTDetailsViewController.m
//  JNSL
//
//  Created by zw on 16/10/15.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "realTechTDetailsViewController.h"

@interface realTechTDetailsViewController ()

@end

@implementation realTechTDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"机组详情";
    
    
    //强制横屏
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationLandscapeRight animated:YES];
//    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;//（获取当前电池条动画改变的时间）
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:duration];
//    //在这里设置view.transform需要匹配的旋转角度的大小就可以了。
//    self.view.layer.transform = [self getrect];
//    [UIView commitAnimations];
    
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenHeight, screenWidth)];
    [self.view addSubview:self.webview];
    self.webview.delegate = self;
    if (self.url != nil) {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.url ]];
        [self.webview loadRequest:request];
        [MBProgressHUD showError:@"正在加载..."];
    }
    
    
    //添加返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 30, 30)];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow_left3"] forState:UIControlStateNormal];
    //backBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:backBtn];
    
    // Do any additional setup after loading the view.
}

-(CATransform3D)getrect{
    CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
    return transform;
}

-(void)backClick{
    [self dismissViewControllerAnimated:true completion:nil];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 //支持旋转
 -(BOOL)shouldAutorotate{
         return YES;
     }
 //
 //支持的方向
 - (UIInterfaceOrientationMask)supportedInterfaceOrientations {
         return UIInterfaceOrientationMaskLandscapeRight;
     }

 //一开始的方向  很重要
 -(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
         return UIInterfaceOrientationLandscapeRight;
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

//
//  WelComeViewController.m
//  JNSL
//
//  Created by zw on 16/10/16.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "WelComeViewController.h"

@interface WelComeViewController ()
@property UIImageView *backImageView;
@property UIButton *enterBtn;
@end

@implementation WelComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self addBackView];
    // Do any additional setup after loading the view.
}
-(void)addBackView
{
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.backImageView.image = [UIImage imageNamed:@"bac10"];
    self.backImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.backImageView];
    
    self.enterBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.backImageView.frame.size.width-100)/2, self.backImageView.frame.size.height-110, 100, 50)];
    self.enterBtn.backgroundColor = RGBA(0, 131, 206, 0.7);
    self.enterBtn.layer.cornerRadius = 20;
    [self.enterBtn setTitle:@"进入首页" forState:UIControlStateNormal];
    [self.enterBtn addTarget:self action:@selector(enterActoin) forControlEvents:UIControlEventTouchUpInside];
    [self.backImageView addSubview:self.enterBtn];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterActoin)];
//    [self.enterBtn addGestureRecognizer:tap];
}
-(void)enterActoin
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

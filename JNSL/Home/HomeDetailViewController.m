//
//  HomeDetailViewController.m
//  JNSL
//
//  Created by zw on 16/10/9.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()
@property NSInteger type;
@property UIBarButtonItem *rightBtn;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //  返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backBtn addTarget:self action:@selector(changeView) forControlEvents:UIControlEventTouchDown];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"trans"] forState:UIControlStateNormal];
    self.rightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = self.rightBtn;
    
    if (self.type==1) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    // Do any additional setup after loading the view.
}
-(void)setVCType:(NSInteger)type
{
    self.type = type;
}
-(void)changeView
{
    
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

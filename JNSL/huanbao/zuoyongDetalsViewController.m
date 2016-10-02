//
//  zuoyongDetalsViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "zuoyongDetalsViewController.h"

@interface zuoyongDetalsViewController ()

@end

@implementation zuoyongDetalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, screenWidth, 300)];
    self.img.image = [UIImage imageNamed:@"work_control"];
    self.img.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.img];
    // Do any additional setup after loading the view.
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

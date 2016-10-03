//
//  wulaio4ViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "wulaio4ViewController.h"

@interface wulaio4ViewController ()

@end

@implementation wulaio4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"在大量的污染源企业检查中，环保部门积累了很多监管经验，已经发现的企业对在线监控数据的作假手段，都可以成为工况监控系统自动化判断的规则。";
    UIFont *font = [UIFont systemFontOfSize:28];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGFloat hei = [str boundingRectWithSize:CGSizeMake(screenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    
    self.textlable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, hei+50)];
    self.textlable.textColor = ColorWithRGB(0x737373);
    self.textlable.font = font;
    self.textlable.numberOfLines = 0;
    self.textlable.text = str;
    [self.view addSubview:self.textlable];
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

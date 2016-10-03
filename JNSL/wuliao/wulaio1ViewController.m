//
//  wulaio1ViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "wulaio1ViewController.h"

@interface wulaio1ViewController ()

@end

@implementation wulaio1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *str = @"以脱硫系统为例：根据物质守恒的原理，我们从脱硫系统中提取了烟气平衡模型、浆液平衡模型，运用到工况监控系统。";
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

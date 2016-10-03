//
//  wulaio3ViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "wulaio3ViewController.h"

@interface wulaio3ViewController ()

@end

@implementation wulaio3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"以脱硫系统为例：在脱硫系统中，多个过程参数之间有着复杂的逻辑关系，工况系统实时对这些参数进行比对，发现治污设施的运行异常。";
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

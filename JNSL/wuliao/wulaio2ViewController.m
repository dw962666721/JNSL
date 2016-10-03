//
//  wulaio2ViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "wulaio2ViewController.h"

@interface wulaio2ViewController ()

@end

@implementation wulaio2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"以燃煤电厂为例：在燃煤燃烧理论中，有一些参数是有关联关系的，比如燃煤量、烟气量等，将这些关联关系融入到工况监控系统中，可以发现一些异常情况。";
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

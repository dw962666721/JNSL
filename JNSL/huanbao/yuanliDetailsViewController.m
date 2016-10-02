//
//  yuanliDetailsViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "yuanliDetailsViewController.h"

@interface yuanliDetailsViewController ()

@end

@implementation yuanliDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.str = @"以脱硫系统为例:根据物质守恒的定律,根据物质守恒的定律";
    UIFont *font = [UIFont systemFontOfSize:28];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGFloat hei = [self.str boundingRectWithSize:CGSizeMake(screenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
                                                            
    self.textlable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, hei)];
    self.textlable.textColor = ColorWithRGB(0x737373);
    self.textlable.font = font;
    self.textlable.numberOfLines = 0;
    self.textlable.text = self.str;
    [self.view addSubview:self.textlable];
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

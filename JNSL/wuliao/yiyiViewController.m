//
//  yiyiViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "yiyiViewController.h"

@interface yiyiViewController ()

@end

@implementation yiyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65)];
    [self.view addSubview:self.webview];
    self.webview.backgroundColor = [UIColor whiteColor];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"yiyi" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webview loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
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

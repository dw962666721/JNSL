//
//  fileReaderViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "fileReaderViewController.h"

@interface fileReaderViewController ()

@end

@implementation fileReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view addSubview:self.webview];
    self.webview.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void) loadDocument:(NSString *)docName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:docName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
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

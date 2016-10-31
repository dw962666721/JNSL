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
    self.title = @"详情";
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65)];
    [self.view addSubview:self.webview];
    self.webview.backgroundColor = [UIColor whiteColor];
    self.webview.delegate = self;
    if (self.filename != nil) {
        [self loadDocument:self.filename];
        //[self loadTxt:self.filename];
    }
    // Do any additional setup after loading the view.
}

- (void) loadDocument:(NSString *)docName
{
    //1.获取Documents文件夹路径 （不要将视频、音频等较大资源存储在Caches路径下）
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    //2.创建资源存储路径
    NSString *appendPath = [NSString stringWithFormat:@"%@%@",@"/",docName];
    NSString *file = [documentsPath stringByAppendingString:appendPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    bool isexsit = [manager fileExistsAtPath:file];
    if (isexsit) {
        [self loadTxt:file];
        //NSURL *url = [NSURL fileURLWithPath:file];
        //NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //[self.webview loadRequest:request];
        [MBProgressHUD showMessage:@"" toView:self.view];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view];
}


-(void)loadTxt:(NSString *)fileName{
    ///编码可以解决 .txt 中文显示乱码问题
    NSStringEncoding *useEncodeing = nil;
    //带编码头的如utf-8等，这里会识别出来
    NSString *body = [NSString stringWithContentsOfFile:fileName usedEncoding:useEncodeing error:nil];
    //识别不到，按GBK编码再解码一次.这里不能先按GB18030解码，否则会出现整个文档无换行bug。
    if (!body) {
        body = [NSString stringWithContentsOfFile:fileName encoding:0x80000632 error:nil];
    }
    //还是识别不到，按GB18030编码再解码一次.
    if (!body) {
        body = [NSString stringWithContentsOfFile:fileName encoding:0x80000631 error:nil];
    }
    
    //展现
    if (body) {
        [self.webview loadHTMLString:body baseURL: nil];
    }else {
        NSString *urlString = [[NSBundle mainBundle] pathForAuxiliaryExecutable:fileName];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *requestUrl = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
        [self.webview loadRequest:request];
        
    }
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

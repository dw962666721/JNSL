//
//  ReportViewController.m
//  JNSL
//
//  Created by wangjiang on 16/11/20.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报表详情";
    // Do any additional setup after loading the view.
}
-(void)setData:(NSString*)dateStr
{
    self.dayStr = dateStr;
}
-(NSMutableDictionary*)getDict:(BOOL)type
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:self.dayStr forKey:@"reportDate "];
    return dict;
}
-(NSString*)getUrl:(BOOL)type
{
    NSString *url = [NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,GetReportURL];
    return url;
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

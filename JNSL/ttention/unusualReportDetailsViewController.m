//
//  unusualReportDetailsViewController.m
//  JNSL
//
//  Created by zw on 16/10/15.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "unusualReportDetailsViewController.h"

@interface unusualReportDetailsViewController ()

@end

@implementation unusualReportDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工况异常报告";
    [self createView];
    [self loadData];
    
    // Do any additional setup after loading the view.
}
//加载数据
-(void)loadData{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"alarmLogId"]= self.alarmLogId;
    [AFNetworkTool postJSONWithUrl:yichangDetailsURL parameters:dict success:^(id responseObject) {
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableArray *resultEntityArray = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"resultEntity"]];
            if (resultEntityArray.count>0) {
                NSDictionary *dic = resultEntityArray[0];
                NSString *cc = [dic objectForKey:@"pollSourceName"];
                self.titlelb.text = [dic objectForKey:@"pollSourceName"];
                self.nametext.text = [dic objectForKey:@"pollSourceName"];
                self.jizunametext.text = [dic objectForKey:@"facilityName"];
                self.yichangnametext.text = [dic objectForKey:@"alarmTypeName"];
                NSString *basestr = [dic objectForKey:@"facilityBasId"];
                self.bianhaonametext.text = [[NSString alloc] initWithFormat:@"%@",basestr];
                
                NSString *bdate = [dic objectForKey:@"beginDate"];
                NSString *edate = [dic objectForKey:@"endDate"];
                NSString *timestr = [[NSString alloc] initWithFormat:@"%@%@%@",bdate,@"到",edate];
                self.timenametext.text = timestr;
                NSString *casusr = [dic objectForKey:@"alarmCauses"];
                CGFloat hei = [casusr boundingRectWithSize:CGSizeMake(screenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
                self.yuanyinnametext.text = [dic objectForKey:@"alarmCauses"];
                self.yuanyinnametext.frame = CGRectMake(10, 170, screenWidth-20, hei);
            }
        }
        
    } fail:^{
        [MBProgressHUD showError:@"获取数据失败"];
    }];
    
}

-(void)createView{
    self.titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    self.titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.namelb = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 50, 30)];
    self.namelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    self.namelb.text = @"企业名称";
    self.nametext = [[UILabel alloc] initWithFrame:CGRectMake(60, 50, 160, 30)];
    self.nametext.font = [UIFont systemFontOfSize:11];
    self.jizunamelb = [[UILabel alloc] initWithFrame:CGRectMake(220, 50, 50, 30)];
    self.jizunamelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    self.jizunamelb.text = @"机组名称";
    self.jizunametext = [[UILabel alloc] initWithFrame:CGRectMake(270, 50, 80, 30)];
    self.jizunametext.font = [UIFont systemFontOfSize:11];
    
    self.yichangnamelb = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 80, 30)];
    self.yichangnamelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    self.yichangnamelb.text = @"异常名称";
    self.yichangnametext = [[UILabel alloc] initWithFrame:CGRectMake(60, 80, 160, 30)];
    self.yichangnametext.font = [UIFont systemFontOfSize:11];
    self.bianhaonamelb = [[UILabel alloc] initWithFrame:CGRectMake(220, 80, 80, 30)];
    self.bianhaonamelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    self.bianhaonamelb.text = @"编      号";
    self.bianhaonametext = [[UILabel alloc] initWithFrame:CGRectMake(270, 80, 80, 30)];
    self.bianhaonametext.font = [UIFont systemFontOfSize:11];
    
    self.timenamelb = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 80, 30)];
    self.timenamelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    self.timenamelb.text = @"发生时间";
    self.timenametext = [[UILabel alloc] initWithFrame:CGRectMake(60, 114, screenWidth-110, 28)];
    self.timenametext.font = [UIFont systemFontOfSize:11];
    
    self.yuanyinnamelb = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 80, 30)];
    self.yuanyinnamelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    self.yuanyinnamelb.text = @"产生原因";
    self.yuanyinnametext = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, screenWidth-20, 100)];
    self.yuanyinnametext.font = [UIFont systemFontOfSize:11];
    
    self.timenametext.numberOfLines = 0;
    self.yuanyinnametext.numberOfLines = 0;
    self.titlelb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titlelb];
    [self.view addSubview:self.namelb];
    [self.view addSubview:self.nametext];
    [self.view addSubview:self.jizunamelb];
    [self.view addSubview:self.jizunametext];
    [self.view addSubview:self.yichangnamelb];
    [self.view addSubview:self.yichangnametext];
    [self.view addSubview:self.bianhaonamelb];
    [self.view addSubview:self.bianhaonametext];
    [self.view addSubview:self.timenamelb];
    [self.view addSubview:self.timenametext];
    [self.view addSubview:self.yuanyinnamelb];
    [self.view addSubview:self.yuanyinnametext];
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

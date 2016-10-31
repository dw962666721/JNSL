//
//  totalAmountViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "totalAmountViewController.h"

@interface totalAmountViewController ()
{
    NSDictionary *dataArr;
    NSString *thetype;
    NSMutableArray *shuarr;
    NSMutableArray *hengarr;
    NSString *pollSourceId;
}
@end

@implementation totalAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    thetype = @"so2";
    self.title = @"总量监控";
    pollSourceId = userInfoJNSL.pollSourceId;
    shuarr = [[NSMutableArray alloc] init];
    hengarr = [[NSMutableArray alloc] init];
    [self addScrool];
    [self setBack];
    [self addorvlView];
    [self addLineView];
    [self addorvlViewData];
    
    // Do any additional setup after loading the view.
}

-(void)addScrool{
    
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.scroll.backgroundColor = [UIColor whiteColor];
    // 设置内容大小
    self.scroll.contentSize = CGSizeMake(screenWidth, 680);
    [self.view addSubview:self.scroll];
}

-(void)setBack{
    UIImageView *imgview = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, screenWidth, 680)];
    imgview.image = [UIImage imageNamed:@"home_bg"];
    [self.scroll addSubview:imgview];
}

-(void)addorvlViewData{
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"pollSourceId"] = pollSourceId;
    dict[@"type"] = thetype;
    [AFNetworkTool postJSONWithUrl:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,nianduzongliangURL] parameters:dict success:^(id responseObject) {
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableArray *resultEntityArray = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"resultEntity"]];
            if (resultEntityArray.count>0) {
                dataArr = resultEntityArray[0];
                [self.orvl setText:dataArr];
            }
        }
        [self addLineData];
        
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"获取数据失败"];
    }];
}

-(void)addorvlView{
    self.orvl = [[rounfView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 250)];
    self.orvl.backgroundColor = [UIColor clearColor];
    
    [self.scroll addSubview:self.orvl];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 260, 10, 10)];
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, 40, 10)];
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 260, 10, 10)];
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 260, 40, 10)];
    UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(130, 260, 10, 10)];
    UILabel *lb3 = [[UILabel alloc] initWithFrame:CGRectMake(140, 260, 40, 10)];
    img1.image = [UIImage imageNamed:@"purse1"];
    img2.image = [UIImage imageNamed:@"purse2"];
    img3.image = [UIImage imageNamed:@"purse3"];
    lb1.font = [UIFont systemFontOfSize:11];
    lb2.font = [UIFont systemFontOfSize:11];
    lb3.font = [UIFont systemFontOfSize:11];
    lb1.text = @"总量";
    lb2.text = @"预警值";
    lb3.text = @"排放值";
    [self.scroll addSubview:img1];
    [self.scroll addSubview:img2];
    [self.scroll addSubview:img3];
    [self.scroll addSubview:lb1];
    [self.scroll addSubview:lb2];
    [self.scroll addSubview:lb3];
}

-(void)addLineData{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"pollSourceId"] = pollSourceId;
    dict[@"pollutantType"] = thetype;
    [AFNetworkTool postJSONWithUrl:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,zhexianURL] parameters:dict success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableArray *resultEntityArray = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"resultEntity"]];
            if (resultEntityArray.count>0) {
                self.zhexianArr = resultEntityArray;
                NSDictionary *dic = self.zhexianArr[0];
                NSString *date = [dic objectForKey:@"countTime"];
                [self addHozuobiao:[date intValue]];
                [self addshuzuobiao];
            }
        }
        
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"获取数据失败"];
    }];
}


-(void)addLineView{
    self.lineTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, screenWidth, 30)];
    self.lineTitle.textAlignment = NSTextAlignmentCenter;
    [self.scroll addSubview:self.lineTitle];
    self.lineTitle.text = @"SO2排放量(/t)";
    self.lineBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 530, (screenWidth-60)/3, 30)];
    self.lineBtn2 = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth-60)/3+30, 530, (screenWidth-60)/3, 30)];
    self.lineBtn3 = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth-60)/3*2+30, 530, (screenWidth-60)/3, 30)];
    [self.lineBtn1 setTitle:@"SO2" forState:UIControlStateNormal];
    [self.lineBtn2 setTitle:@"NOX" forState:UIControlStateNormal];
    [self.lineBtn3 setTitle:@"烟尘" forState:UIControlStateNormal];
    self.lineBtn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.lineBtn2.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.lineBtn3.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.lineBtn1.backgroundColor = ColorWithRGB(0x4a4646);
    self.lineBtn2.backgroundColor = [UIColor grayColor];
    self.lineBtn3.backgroundColor = [UIColor grayColor];
    [self.lineBtn1 addTarget:self action:@selector(line1btnclick) forControlEvents:UIControlEventTouchDown];
    [self.lineBtn2 addTarget:self action:@selector(line2btnclick) forControlEvents:UIControlEventTouchDown];
    [self.lineBtn3 addTarget:self action:@selector(line3btnclick) forControlEvents:UIControlEventTouchDown];
    
    [self.scroll addSubview:self.lineBtn1];
    [self.scroll addSubview:self.lineBtn2];
    [self.scroll addSubview:self.lineBtn3];
    
    self.zhexianview = [[lineChartView alloc] initWithFrame:CGRectMake(30, 340, screenWidth-40, 150)];
    self.zhexianview.backgroundColor = [UIColor clearColor];

    [self.scroll addSubview:self.zhexianview];
    
}

-(void)line1btnclick{
    if (![thetype  isEqual: @"so2"]) {
        thetype = @"so2";
        [self clear];
        self.lineTitle.text = @"SO2排放量(/t)";
        self.lineBtn1.backgroundColor = ColorWithRGB(0x4a4646);
        self.lineBtn2.backgroundColor = [UIColor grayColor];
        self.lineBtn3.backgroundColor = [UIColor grayColor];
        [self addorvlViewData];
        
        
    }
    
}
-(void)line2btnclick{
    if (![thetype  isEqual: @"nox"]) {
        thetype = @"nox";
        [self clear];
        self.lineTitle.text = @"NOX排放量(/t)";
        self.lineBtn1.backgroundColor = [UIColor grayColor];
        self.lineBtn2.backgroundColor = ColorWithRGB(0x4a4646);
        self.lineBtn3.backgroundColor = [UIColor grayColor];
        [self addorvlViewData];
        
    }
    
}
-(void)line3btnclick{
    if (![thetype  isEqual: @"smoke"]) {
        thetype = @"smoke";
        [self clear];
        self.lineTitle.text = @"烟尘排放量(/t)";
        self.lineBtn1.backgroundColor = [UIColor grayColor];
        self.lineBtn2.backgroundColor = [UIColor grayColor];
        self.lineBtn3.backgroundColor = ColorWithRGB(0x4a4646);
        [self addorvlViewData];
        
    }
    
}

-(void)clear{
    for (int i = 0; i < shuarr.count; i++) {
        UILabel *lb = (UILabel *)shuarr[i];
        [lb removeFromSuperview];
    }
    for (int j = 0; j < hengarr.count; j++) {
        UILabel *lb = (UILabel *)hengarr[j];
        [lb removeFromSuperview];
    }
    [shuarr removeAllObjects];
    [hengarr removeAllObjects];
}

-(void)addHozuobiao:(int )initdate{
    //添加横坐标的标注
    CGFloat hengunit = (screenWidth-40)/6-1;
    CGFloat shuunit = 150/8;
    for (int i=0; i<7; i++) {
        CGFloat w = hengunit * i;
        int thedate = initdate + i;
        NSString *datestr = [NSString stringWithFormat:@"%d%@",thedate,@"日"];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(30-hengunit/2+w, 490, hengunit, 20)];
        lb.font = [UIFont systemFontOfSize:12];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = datestr;
        [self.scroll addSubview:lb];
        [hengarr addObject:lb];
    }
}

-(void)addshuzuobiao{
    CGFloat unit = 0;
    CGFloat maxdata = 0;
    
    //计算unit值 elf.zhexianArr
    for (int j=0; j<self.zhexianArr.count; j++) {
        NSDictionary *dic = self.zhexianArr[j];
        NSString *datastr = [dic objectForKey:@"rtTotalDayValue"];
        CGFloat dataa = [datastr floatValue];
        if(dataa > maxdata){
            maxdata = dataa;
        }
    }
    if (maxdata != 0) {
        unit = maxdata/9;
        CGFloat hengunit = (screenWidth-40)/6-1;
        CGFloat shuunit = 150/8;
        CGFloat initdata = 0;
        //添加竖的标注
        CGFloat initshu = 490-shuunit/2;//默认为490
        for (int i=0; i<9; i++) {
            initdata = unit * i;
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, initshu-shuunit*i, 30, 15)];
            //lb.backgroundColor = [UIColor redColor];
            lb.font = [UIFont systemFontOfSize:8];
            [self.scroll addSubview:lb];
            lb.text = [NSString stringWithFormat:@"%.2f",initdata];
            [shuarr addObject:lb];
        }
        //绘制折线
        NSMutableArray *pointArr = [[NSMutableArray alloc] init];
        for (int h=0; h<self.zhexianArr.count; h++) {
            CGFloat xx = h;
            NSDictionary *dic = self.zhexianArr[h];
            NSString *datastr = [dic objectForKey:@"rtTotalDayValue"];
            CGFloat dataa = [datastr floatValue];
            CGFloat yy = dataa/unit;
            NSValue *va = [NSValue valueWithCGPoint:CGPointMake(xx, yy)];
            [pointArr addObject:va];
        }
        self.zhexianview.arr = pointArr;
        [self.zhexianview setNeedsDisplay];
    }else{
        self.zhexianview.arr = [[NSArray alloc] init];
        [self.zhexianview setNeedsDisplay];
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

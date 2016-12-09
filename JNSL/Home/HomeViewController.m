//
//  HomeViewController.m
//  JNSL
//
//  Created by zw on 16/9/30.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property UIScrollView *MainScrollView;
@property UIView *MainView;
@property UIView *allView;
@property UILabel *allValueLb;
@property UIView *_1View;
@property UILabel *_1ValueLb;
@property UIView *_2View;
@property UILabel *_2ValueLb;
@property UIButton *allBtn;
@property UIButton *_1Btn;
@property UIButton *_2Btn;
@property NSMutableDictionary *viewDict;
@property NSMutableArray *dataArray; // 请求到的数据
@property NSInteger rowH; // 图形行高
@property BOOL bo; // 是否正在请求数据
@property HomeDetailViewController *detailVC1; // ＃1
@property HomeDetailViewController *detailVCAll; // 全厂
@property HomeDetailViewController *detailVC2; // #2
@property UILabel *timeLb; // 时间
@property BOOL firstLoad;
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)loadData
{
    if (self.bo) {
        return;
    }
    if (self.firstLoad) {
        self.firstLoad=NO;
        if([userInfoJNSL getUserDict]!=nil)
        {
            return;
        }
    }
   
    self.bo = YES;
    self.dataArray =[[NSMutableArray alloc] init];
    [AFNetworkTool postJSONWithUrl:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,HomeURL] parameters:nil success:^(id responseObject) {
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSMutableArray *resultEntity = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"resultEntity"]];
            self.dataArray = resultEntity;
            // 填写数据
            [self writeData];
        }
        self.bo = NO;
        [self.MainScrollView.header endRefreshing];
    } fail:^{
        [self.MainScrollView.header endRefreshing];
        // 移除HUD
//        [MBProgressHUD hideHUD];
        
        // 提醒有没有新数据
//        [MBProgressHUD showError:@"请求失败"];
        self.bo = NO;
    }];

}
// 检测版本
-(void)checkVersion
{
    NSDate* today = [NSDate date];
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    
    [df setDateFormat:@"yyyyMMdd"];
    
    NSString* s1 = [df stringFromDate:today];
    NSInteger dateNum = s1.integerValue;
    
    if (dateNum>20161221) {
        [AFNetworkTool postJSONWithUrl:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,GetVersionURL] parameters:nil success:^(id responseObject) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSString *result = [json objectForKey:@"success"];
            if ([result isEqual:@"true"]) {
                NSString *newVersion = [json objectForKey:@"version"];
                
                if (![newVersion containsString:@"V"]) {
                    
                }
                else
                {
                    userInfoJNSL.ip=@"";
                    [userInfoJNSL clearUserDict];
                    [MBProgressHUD showError:@"版本错误"];
                }
            }
        } fail:^{
            userInfoJNSL.ip=@"";
            [userInfoJNSL clearUserDict];
            [MBProgressHUD showError:@"版本错误"];
        }];
    }
}

- (void)viewDidLoad {
    self.firstLoad=YES;
    WelComeViewController *VC = [[WelComeViewController alloc] init];
    VC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController: VC animated:NO completion:nil];
    
    [super viewDidLoad];
    
    self.viewDict = [[NSMutableDictionary alloc] init];
    self.title=@"京能盛乐热电有限公司";

    [self loadUserInfo];
    [self addViews];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadData) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [self loadData];
//    [self checkVersion];
}

// 给用户数据赋值
-(void)loadUserInfo
{
    if ([userInfoJNSL getUserDict]) {
        NSDictionary *userDict = [userInfoJNSL getUserDict];
        userInfoJNSL.userName =[userDict objectForKey:@"userName"];
        userInfoJNSL.userId =[userDict objectForKey:@"userId"];
        userInfoJNSL.userIcon =[userDict objectForKey:@"userIcon"];
        userInfoJNSL.phoneNum =[userDict objectForKey:@"phoneNum"];
        userInfoJNSL.email =[userDict objectForKey:@"email"];
        userInfoJNSL.pollSourceId =[userDict objectForKey:@"pollSourceId"];
        userInfoJNSL.rollName =[userDict objectForKey:@"rollName"];
        userInfoJNSL.ip = [userDict objectForKey:@"ip"];
    }
    else
    {
        userInfoJNSL.ip = @"http://60.31.21.53:8080/ep4.1_nm_app/";
    }
}
-(void)addViews
{
    // // 添加主框架
    [self addMainView];
 
    // 添加标题、时间
    [self addTitle];
    
    // 添加表格
    [self addTable];
    
    
    if (IPHONE6PLUS||IPHONE6) {
        // 添加机组信息
        [self addJZ:330 name:@"jz"];
        // 添加锅炉信息
        [self addJZ:410 name:@"gl"];
        // 添加汽机信息
        [self addJZ:520 name:@"qj"];
    }
   else
   {
       // 添加机组信息
       [self addJZ:240 name:@"jz"];
       // 添加锅炉信息
       [self addJZ:330 name:@"gl"];
       // 添加汽机信息
       [self addJZ:440 name:@"qj"];
   }
    
   
    
    // 添加最下方按钮
    [self addDetails];
    
}

-(void)addTitle
{
    NSInteger y=25;
    NSInteger titleSize = 13;
    if (IPHONE6||IPHONE6PLUS) {
        titleSize = 17;
    }
    // 添加标题
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, y, screenWidth, 25)];
    titleLb.text = @"京能盛乐热电有限公司";
    titleLb.font = [UIFont boldSystemFontOfSize:titleSize];
    titleLb.textColor = [UIColor whiteColor];
    titleLb.textAlignment=NSTextAlignmentCenter;
    [self.MainView addSubview:titleLb];
    
    y+=25;
    // 添加时间
    self.timeLb = [[UILabel alloc] initWithFrame:CGRectMake(0, y, screenWidth, 15)];
    NSDate* today = [NSDate date];
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* s1 = [df stringFromDate:today];
    self.timeLb.text = s1;
    self.timeLb.font = [UIFont systemFontOfSize:titleSize-4];
    self.timeLb.textColor = [UIColor whiteColor];
    self.timeLb.textAlignment=NSTextAlignmentCenter;
    [self.MainView addSubview:self.timeLb];

}
// 添加主框架
-(void)addMainView
{
    // 添加最大的ScrollView
    self.MainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.MainScrollView.showsVerticalScrollIndicator = NO;
    self.MainScrollView.backgroundColor = RGBA(4, 41, 144, 1);
    [self.view addSubview:self.MainScrollView];
    
//    __weak __typeof(self) weakSelf = self;
//    self.MainScrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf loadData];
//    }];
    
    // ScrollView填充UIView
    NSInteger MainH = 680;
    if (IPHONE6||IPHONE6PLUS) {
        MainH=730;
    }
    self.MainView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, screenWidth, MainH)];
//        self.MainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_work"]];
    [self.MainScrollView addSubview:self.MainView];
    self.MainScrollView.contentSize = CGSizeMake(self.MainView.frame.size.width, self.MainView.frame.size.height+29);
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.MainView.bounds];
    backImageView.image = [UIImage imageNamed:@"background_work"];
    [self.MainView addSubview:backImageView];

}
-(void) addTable
{
    NSInteger x=25;
    NSInteger y=75;
    if (IPHONE6||IPHONE6PLUS) {
        y=85;
    }
    self.rowH = 15;
    NSInteger splitW=(screenWidth-x-10)/3;
    NSInteger width0=screenWidth-x-10;
    if (IPHONE6||IPHONE6PLUS) {
        self.rowH=25;
    }
     NSInteger height0=self.rowH*7;
    // 创建横线
    for (NSInteger i=0; i<8; i++) {
        //画线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(x, y+self.rowH*i,width0 , 0.7)];
        lineView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        lineView.layer.borderWidth=0.7;
        [self.MainView addSubview:lineView];
        
        // 标刻度
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, y+self.rowH*i-4, 25, 10)];
        titleLb.text=[NSString stringWithFormat:@"%d",700-i*100];
        titleLb.textColor = [UIColor whiteColor];
        titleLb.font = [UIFont systemFontOfSize:8];
        titleLb.textAlignment = NSTextAlignmentRight;
        [self.MainView addSubview:titleLb];
    }
    // 创建横线
    for (NSInteger j=0; j<3; j++) {
         //画线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(x+splitW*j, y,0.7 , height0)];
        lineView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        lineView.layer.borderWidth=0.7;
        [self.MainView addSubview:lineView];
        
         //画背景
        UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(x+splitW*j+(width0/3-width0/3*5/12)/2, y, width0/3*5/12, height0)];
        viewBack.backgroundColor = RGBA(215, 215, 215, 1);
        [self.MainView addSubview:viewBack];
        
        // 写字
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(x+splitW*j, y+height0+10, width0/3, 15)];
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.textColor = [UIColor whiteColor];
        titleLb.font = [UIFont systemFontOfSize:16];
        [self.MainView addSubview:titleLb];
        
        switch (j) {
            case 0:
                titleLb.text=@"全厂";
                // 添加柱形条
                self.allView = [[UIView alloc] initWithFrame:CGRectMake(0, viewBack.frame.size.height, viewBack.frame.size.width, 0)];
                self.allView.backgroundColor = RGBA(65, 0, 255, 1);
                [viewBack addSubview:self.allView];
                // 添加数值
                self.allValueLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewBack.frame.size.width, 15)];
                self.allValueLb.textColor = [UIColor blackColor];
                self.allValueLb.textAlignment = NSTextAlignmentCenter;
                self.allValueLb.font = [UIFont systemFontOfSize:15];
                [viewBack addSubview:self.allValueLb];
                break;
            case 1:
                titleLb.text=@"#1机组";
                // 添加柱形条
                self._1View = [[UIView alloc] initWithFrame:CGRectMake(0, viewBack.frame.size.height, viewBack.frame.size.width, 0)];
                self._1View.backgroundColor = RGBA(65, 0, 255, 1);
                [viewBack addSubview:self._1View];
                // 添加数值
                self._1ValueLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewBack.frame.size.width, 15)];
                self._1ValueLb.textColor = [UIColor blackColor];
                self._1ValueLb.textAlignment = NSTextAlignmentCenter;
                self._1ValueLb.font = [UIFont systemFontOfSize:15];
                [viewBack addSubview:self._1ValueLb];
                break;
            case 2:
                titleLb.text=@"#2机组";
                // 添加柱形条
                self._2View = [[UIView alloc] initWithFrame:CGRectMake(0, viewBack.frame.size.height, viewBack.frame.size.width, 0)];
                self._2View.backgroundColor = RGBA(65, 0, 255, 1);
                [viewBack addSubview:self._2View];
                // 添加数值
                self._2ValueLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewBack.frame.size.width, 15)];
                self._2ValueLb.textColor = [UIColor blackColor];
                self._2ValueLb.textAlignment = NSTextAlignmentCenter;
                self._2ValueLb.font = [UIFont systemFontOfSize:15];
                [viewBack addSubview:self._2ValueLb];
                break;
            default:
                break;
        }
        // 添加标志说明
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(x+5, y+height0+30, 20, 20)];
        colorView.backgroundColor = RGBA(65, 0, 255, 1);
        [self.MainView addSubview:colorView];
        
        UILabel *tipLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorView.frame)+2, colorView.frame.origin.y, 125, colorView.frame.size.height)];
        tipLb.text=@"机组负荷(MW)";
        tipLb.font = [UIFont systemFontOfSize:15];
        tipLb.textColor = [UIColor blackColor];
        [self.MainView addSubview:tipLb];
        
    }
    
    
}
-(void)addJZ:(NSInteger)y name:(NSString*)name
{
    // 添加标题栏
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, 20)];
    titleView.backgroundColor = RGBA(10, 10, 10, 0.3);
    if (![name isEqual:@"jz"]) {
        titleView.frame = CGRectMake(0, y, screenWidth, 40);
    }
    [self.MainView addSubview:titleView];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), screenWidth, 0.7)];
    line1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    line1.layer.borderWidth = 0.7;
    [self.MainView addSubview:line1];
    
    // 添加＃1机组栏
    UIView *_1JZView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame), screenWidth, 20)];
    _1JZView.backgroundColor = RGBA(10, 10, 10, 0.3);
    [self.MainView addSubview:_1JZView];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_1JZView.frame), screenWidth, 0.7)];
    line2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    line2.layer.borderWidth = 0.7;
    [self.MainView addSubview:line2];
    
    // 添加＃2机组栏
    UIView *_2JZView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line2.frame), screenWidth, 20)];
    _2JZView.backgroundColor = RGBA(10, 10, 10, 0.3);
    [self.MainView addSubview:_2JZView];

    NSInteger oneWidth = screenWidth/5;
    NSInteger fontSize = 11;
    NSInteger titleH = titleView.frame.size.height;
    NSInteger contentH = 20;
    if (![name isEqual:@"jz"]) {
        oneWidth = screenWidth/6;
    }
    for (NSInteger i=0; i<6; i++)
    {
        switch (i)
        {
            case 0:
            {
                UILabel *titleLb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, titleH)];
                titleLb.text=@"参数描述";
                titleLb.textColor=[UIColor whiteColor];
                titleLb.textAlignment = NSTextAlignmentCenter;
                titleLb.font = [UIFont systemFontOfSize:fontSize];
                [titleView addSubview:titleLb];
                
                UILabel *_1TitleLb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _1TitleLb.text=@"#1机组";
                _1TitleLb.textColor=[UIColor whiteColor];
                _1TitleLb.textAlignment = NSTextAlignmentCenter;
                _1TitleLb.font = [UIFont systemFontOfSize:fontSize];
                [_1JZView addSubview:_1TitleLb];
                
                UILabel *_2TitleLb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _2TitleLb.text=@"#2机组";
                _2TitleLb.textColor=[UIColor whiteColor];
                _2TitleLb.textAlignment = NSTextAlignmentCenter;
                _2TitleLb.font = [UIFont systemFontOfSize:fontSize];
                [_2JZView addSubview:_2TitleLb];
                
                if ([name isEqual:@"gl"]) {
                    _1TitleLb.text=@"#1锅炉";
                    _2TitleLb.text=@"#2锅炉";
                }
                if ([name isEqual:@"qj"])
                {
                    _1TitleLb.text=@"#1汽机";
                    _2TitleLb.text=@"#2汽机";
                }
                
            }
                break;
                case 1:
            {
                UILabel *titleLb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, titleH)];
                titleLb.text=@"SO2";
                titleLb.textColor=[UIColor whiteColor];
                titleLb.numberOfLines=0;
                titleLb.textAlignment = NSTextAlignmentCenter;
                titleLb.font = [UIFont systemFontOfSize:fontSize];
                [titleView addSubview:titleLb];
                
                UILabel *_1Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _1Lb.text=[NSString stringWithFormat:@"%@%@",@"_11",name];
                _1Lb.textColor=[UIColor whiteColor];
                _1Lb.textAlignment = NSTextAlignmentCenter;
                _1Lb.font = [UIFont systemFontOfSize:fontSize];
                [_1JZView addSubview:_1Lb];
                self.viewDict[[NSString stringWithFormat:@"%@%@",@"_11",name] ]=_1Lb;
                
                UILabel *_2Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_12",name];
                _2Lb.textColor=[UIColor whiteColor];
                _2Lb.textAlignment = NSTextAlignmentCenter;
                _2Lb.font = [UIFont systemFontOfSize:fontSize];
                [_2JZView addSubview:_2Lb];
                self.viewDict[[NSString stringWithFormat:@"%@%@",@"_12",name] ]=_2Lb;
                
                if ([name isEqual:@"gl"]) {
                    titleLb.text=@"主蒸汽压力(Mpa)";
                }
                if ([name isEqual:@"qj"])
                {
                    titleLb.text=@"汽机转速(rpm)";
                }
            }
                break;
            case 2:
            {
                UILabel *titleLb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, titleH)];
                titleLb.text=@"NOx";
                titleLb.textColor=[UIColor whiteColor];
                titleLb.numberOfLines=0;
                titleLb.textAlignment = NSTextAlignmentCenter;
                titleLb.font = [UIFont systemFontOfSize:fontSize];
                [titleView addSubview:titleLb];
                
                UILabel *_1Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _1Lb.text=[NSString stringWithFormat:@"%@%@",@"_21",name] ;
                _1Lb.textColor=[UIColor whiteColor];
                _1Lb.textAlignment = NSTextAlignmentCenter;
                _1Lb.font = [UIFont systemFontOfSize:fontSize];
                [_1JZView addSubview:_1Lb];
                self.viewDict[[NSString stringWithFormat:@"%@%@",@"_21",name] ]=_1Lb;
                
                UILabel *_2Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_22",name] ;
                _2Lb.textColor=[UIColor whiteColor];
                _2Lb.textAlignment = NSTextAlignmentCenter;
                _2Lb.font = [UIFont systemFontOfSize:fontSize];
                [_2JZView addSubview:_2Lb];
                self.viewDict[[NSString stringWithFormat:@"%@%@",@"_22",name] ]=_2Lb;
                
                if ([name isEqual:@"gl"]) {
                    titleLb.text=@"主蒸汽温度(℃)";
                }
                if ([name isEqual:@"qj"])
                {
                    titleLb.text=@"凝结水压力(Mpa)";
                }

            }
                break;
            case 3:
            {
                UILabel *titleLb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, titleH)];
                titleLb.text=@"烟尘";
                titleLb.textColor=[UIColor whiteColor];
                titleLb.numberOfLines=0;
                titleLb.textAlignment = NSTextAlignmentCenter;
                titleLb.font = [UIFont systemFontOfSize:fontSize];
                [titleView addSubview:titleLb];
                
                UILabel *_1Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _1Lb.text=[NSString stringWithFormat:@"%@%@",@"_31",name];
                _1Lb.textColor=[UIColor whiteColor];
                _1Lb.textAlignment = NSTextAlignmentCenter;
                _1Lb.font = [UIFont systemFontOfSize:fontSize];
                [_1JZView addSubview:_1Lb];
                self.viewDict[[NSString stringWithFormat:@"%@%@",@"_31",name] ]=_1Lb;
                
                UILabel *_2Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_32",name];
                _2Lb.textColor=[UIColor whiteColor];
                _2Lb.textAlignment = NSTextAlignmentCenter;
                _2Lb.font = [UIFont systemFontOfSize:fontSize];
                [_2JZView addSubview:_2Lb];self.viewDict[[NSString stringWithFormat:@"%@%@",@"_32",name] ]=_2Lb;
                self.viewDict[[NSString stringWithFormat:@"%@%@",@"_32",name] ]=_2Lb;
                
                
                if ([name isEqual:@"gl"]) {
                    titleLb.text=@"主蒸汽流量(t/h)";
                }
                if ([name isEqual:@"qj"])
                {
                    titleLb.text=@"给压力(Mpa)";
                }
            }
                break;
            case 4:
            {
                UILabel *titleLb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0,oneWidth, titleH)];
                titleLb.text=@"单位";
                titleLb.textColor=[UIColor whiteColor];
                titleLb.numberOfLines=0;
                titleLb.textAlignment = NSTextAlignmentCenter;
                titleLb.font = [UIFont systemFontOfSize:fontSize];
                [titleView addSubview:titleLb];
                
                UILabel *_1Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _1Lb.text=@"mg/m3";
                _1Lb.textColor=[UIColor whiteColor];
                _1Lb.textAlignment = NSTextAlignmentCenter;
                _1Lb.font = [UIFont systemFontOfSize:fontSize];
                [_1JZView addSubview:_1Lb];
                
                UILabel *_2Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _2Lb.text=@"mg/m3";
                _2Lb.textColor=[UIColor whiteColor];
                _2Lb.textAlignment = NSTextAlignmentCenter;
                _2Lb.font = [UIFont systemFontOfSize:fontSize];
                [_2JZView addSubview:_2Lb];
                
                if ([name isEqual:@"gl"]) {
                    titleLb.text=@"再热气压力(Mpa)";
                    _1Lb.text=[NSString stringWithFormat:@"%@%@",@"_41",name] ;
                    _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_42",name] ;
                    self.viewDict[[NSString stringWithFormat:@"%@%@",@"_41",name] ]=_1Lb;
                    self.viewDict[[NSString stringWithFormat:@"%@%@",@"_42",name] ]=_2Lb;
                }
                if ([name isEqual:@"qj"])
                {
                    titleLb.text=@"给水量(t/h)";
                    _1Lb.text=[NSString stringWithFormat:@"%@%@",@"_41",name] ;
                    _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_42",name] ;
                    self.viewDict[[NSString stringWithFormat:@"%@%@",@"_41",name] ]=_1Lb;
                    self.viewDict[[NSString stringWithFormat:@"%@%@",@"_42",name] ]=_2Lb;
                }
            }
                break;
            case 5:
            {
                if ([name isEqual:@"jz"]) {
                    break;
                }
                UILabel *titleLb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, titleH)];
                titleLb.text=@"单位";
                titleLb.textColor=[UIColor whiteColor];
                titleLb.numberOfLines=0;
                titleLb.textAlignment = NSTextAlignmentCenter;
                titleLb.font = [UIFont systemFontOfSize:fontSize];
                [titleView addSubview:titleLb];
                
                UILabel *_1Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _1Lb.text=@"mg/m3";
                _1Lb.textColor=[UIColor whiteColor];
                _1Lb.textAlignment = NSTextAlignmentCenter;
                _1Lb.font = [UIFont systemFontOfSize:fontSize];
                [_1JZView addSubview:_1Lb];
                
                UILabel *_2Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _2Lb.text=@"mg/m3";
                _2Lb.textColor=[UIColor whiteColor];
                _2Lb.textAlignment = NSTextAlignmentCenter;
                _2Lb.font = [UIFont systemFontOfSize:fontSize];
                [_2JZView addSubview:_2Lb];
                
                if ([name isEqual:@"gl"]) {
                    titleLb.text=@"再热气温度(℃)";
                    _1Lb.text=[NSString stringWithFormat:@"%@%@",@"_51",name] ;
                    _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_52",name] ;
                    self.viewDict[[NSString stringWithFormat:@"%@%@",@"_51",name] ]=_1Lb;
                    self.viewDict[[NSString stringWithFormat:@"%@%@",@"_52",name] ]=_2Lb;
                }
                if ([name isEqual:@"qj"])
                {
                    titleLb.text=@"背压(Mpa)";
                    _1Lb.text=[NSString stringWithFormat:@"%@%@",@"_51",name] ;
                    _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_52",name] ;
                    self.viewDict[[NSString stringWithFormat:@"%@%@",@"_51",name] ]=_1Lb;
                    self.viewDict[[NSString stringWithFormat:@"%@%@",@"_52",name] ]=_2Lb;
                }
            }
                break;
            default:
                break;
        }
    }
}
// 添加最下方按钮
-(void)addDetails
{
    NSInteger y=560;
    NSInteger width = 65;
    NSInteger height = 40;
    if (IPHONE6PLUS||IPHONE6) {
        y=620;
        width = 95;
        height = 50;
    }
     NSInteger splitW = (screenWidth-20*2-width*3)/2;
    self._1Btn = [[UIButton alloc] initWithFrame:CGRectMake(20, y, width, height)];
    [self._1Btn setTitle:@"#1" forState:UIControlStateNormal];
    self._1Btn.layer.cornerRadius = 5;
    self._1Btn.backgroundColor = RGBA(0, 171, 97, 1);
    [self._1Btn addTarget:self action:@selector(look1) forControlEvents:UIControlEventTouchDown];
    [self.MainView addSubview:self._1Btn];
    
    self.allBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self._1Btn.frame)+splitW, y, width, height)];
    [self.allBtn setTitle:@"公用" forState:UIControlStateNormal];
    self.allBtn.layer.cornerRadius = 5;
    self.allBtn.backgroundColor = RGBA(255, 208, 43, 1);
    [self.allBtn addTarget:self action:@selector(lookAll) forControlEvents:UIControlEventTouchDown];
    [self.MainView addSubview:self.allBtn];
    
    self._2Btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.allBtn.frame)+splitW, y, width, height)];
    [self._2Btn setTitle:@"#2" forState:UIControlStateNormal];
    self._2Btn.layer.cornerRadius = 5;
    self._2Btn.backgroundColor = RGBA(75, 129, 249, 1);
    [self._2Btn addTarget:self action:@selector(look2) forControlEvents:UIControlEventTouchDown];
    [self.MainView addSubview:self._2Btn];
    
//    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(look1)];
//    [self._1Btn addGestureRecognizer:tap0];
//    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookAll)];
//    [self.allBtn addGestureRecognizer:tap1];
//    
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(look2)];
//    [self._2Btn addGestureRecognizer:tap2];
}

-(void)look1
{
//    if (self.detailVC1==nil) {
        self.detailVC1 = [[HomeDetailViewController alloc] init];
        [self.detailVC1 setVCType:0];
//    }
    [self.navigationController pushViewController:self.detailVC1 animated:YES];
}
-(void)lookAll
{
    if (self.detailVCAll==nil) {
        self.detailVCAll = [[HomeDetailViewController alloc] init];
        [self.detailVCAll setVCType:1];
    }
    [self.navigationController pushViewController:self.detailVCAll animated:YES];
}
-(void)look2
{
//    if (self.detailVC2==nil) {
        self.detailVC2 = [[HomeDetailViewController alloc] init];
        [self.detailVC2 setVCType:2];
//    }
    [self.navigationController pushViewController:self.detailVC2 animated:YES];
}
-(void)writeData
{
    // 修改时间
    NSDate* today = [NSDate date];
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* s1 = [df stringFromDate:today];
    self.timeLb.text = s1;
    
    if (self.dataArray.count==0) {
        return;
    }
    // 解析数据结构
    NSMutableDictionary *dict = self.dataArray[0];
//    if (Array.count==0) {
//        return;
//    }
//    NSMutableDictionary *dict  = Array[0];
    
    // 填写机组负荷数据
    NSMutableArray *loadArray = [[NSMutableArray alloc] initWithArray:[dict objectForKey:@"load"]];
    if (loadArray.count>0) {
        for (NSInteger i=0; i<loadArray.count; i++) {
            NSMutableDictionary *jzDict = [[NSMutableDictionary alloc] initWithDictionary:loadArray[i]];
            CGFloat value = (CGFloat)([jzDict[@"loadValue"] floatValue]);
            CGFloat viewH = self.rowH*7*value/700;
            if ([jzDict[@"loadName"] isEqual:@"全厂负荷"]) {
                CGRect rect = self.allView.frame;
                rect.size.height = viewH;
                rect.origin.y=self.rowH*7-viewH;
                [UIView animateWithDuration:0.25 animations:^{
                    self.allView.frame = rect;
                }];
                CGRect lbRect = self.allValueLb.frame;
                lbRect.origin.y = self.rowH*7-viewH-15;
                self.allValueLb.frame = lbRect;
                self.allValueLb.text = [NSString stringWithFormat:@"%ld",(long)value];
            }else if ([jzDict[@"loadName"] isEqual:@"#1机组"])
            {
                CGRect rect = self._1View.frame;
                rect.size.height = viewH;
                rect.origin.y=self.rowH*7-viewH;
                [UIView animateWithDuration:0.25 animations:^{
                    self._1View.frame = rect;
                }];
                CGRect lbRect = self._1ValueLb.frame;
                lbRect.origin.y = self.rowH*7-viewH-15;
                self._1ValueLb.frame = lbRect;
                 self._1ValueLb.text = [NSString stringWithFormat:@"%ld",(long)value];
            }
            else
            {
                CGRect rect = self._2View.frame;
                rect.size.height = viewH;
                rect.origin.y=self.rowH*7-viewH;
                [UIView animateWithDuration:0.25 animations:^{
                    self._2View.frame = rect;
                }];
                CGRect lbRect = self._2ValueLb.frame;
                lbRect.origin.y = self.rowH*7-viewH-15;
                self._2ValueLb.frame = lbRect;
                 self._2ValueLb.text = [NSString stringWithFormat:@"%ld",(long)value];
            }
        }
    }
    // 填写机组参数数据
    NSMutableArray *environmentalArray = [[NSMutableArray alloc] initWithArray:[dict objectForKey:@"environmental"]];
    if (environmentalArray.count>0) {
        for (NSInteger i=0; i<environmentalArray.count; i++) {
            NSMutableDictionary *jzDict = [[NSMutableDictionary alloc] initWithDictionary:environmentalArray[i]];
            if ([jzDict[@"parameterName"] isEqual:@"#1机组"]) {
                UILabel *lb1 = self.viewDict[@"_11jz"];
                lb1.text=jzDict[@"so2Nd"];
                UILabel *lb2 = self.viewDict[@"_21jz"];
                lb2.text=jzDict[@"noxNd"];
                UILabel *lb3 = self.viewDict[@"_31jz"];
                lb3.text=jzDict[@"dustNd"];
            }
            else
            {
                UILabel *lb1 = self.viewDict[@"_12jz"];
                lb1.text=jzDict[@"so2Nd"];
                UILabel *lb2 = self.viewDict[@"_22jz"];
                lb2.text=jzDict[@"noxNd"];
                UILabel *lb3 = self.viewDict[@"_32jz"];
                lb3.text=jzDict[@"dustNd"];
            }
        }
    }
    // 填写锅炉参数数据
    NSMutableArray *boilerArray = [[NSMutableArray alloc] initWithArray:[dict objectForKey:@"boiler"]];
    if (boilerArray.count>0) {
        for (NSInteger i=0; i<boilerArray.count; i++) {
            NSMutableDictionary *jzDict = [[NSMutableDictionary alloc] initWithDictionary:boilerArray[i]];
            if ([jzDict[@"parameterName"] isEqual:@"#1锅炉"]) {
                UILabel *lb1 = self.viewDict[@"_11gl"];
                lb1.text=jzDict[@"ZZY"];
                UILabel *lb2 = self.viewDict[@"_21gl"];
                lb2.text=jzDict[@"ZZW"];
                UILabel *lb3 = self.viewDict[@"_31gl"];
                lb3.text=jzDict[@"ZZL"];
                UILabel *lb4 = self.viewDict[@"_41gl"];
                lb4.text=jzDict[@"ZRY"];
                UILabel *lb5 = self.viewDict[@"_51gl"];
                lb5.text=jzDict[@"ZRW"];
            }
            else
            {
                UILabel *lb1 = self.viewDict[@"_12gl"];
                lb1.text=jzDict[@"ZZY"];
                UILabel *lb2 = self.viewDict[@"_22gl"];
                lb2.text=jzDict[@"ZZW"];
                UILabel *lb3 = self.viewDict[@"_32gl"];
                lb3.text=jzDict[@"ZZL"];
                UILabel *lb4 = self.viewDict[@"_42gl"];
                lb4.text=jzDict[@"ZRY"];
                UILabel *lb5 = self.viewDict[@"_52gl"];
                lb5.text=jzDict[@"ZRW"];
            }
        }
    }
    
    // 填写汽机参数数据
    NSMutableArray *turbineArray = [[NSMutableArray alloc] initWithArray:[dict objectForKey:@"turbine"]];
    if (turbineArray.count>0) {
        for (NSInteger i=0; i<turbineArray.count; i++) {
            NSMutableDictionary *jzDict = [[NSMutableDictionary alloc] initWithDictionary:turbineArray[i]];
            if ([jzDict[@"parameterName"] isEqual:@"#1汽机"]) {
                UILabel *lb1 = self.viewDict[@"_11qj"];
                lb1.text=jzDict[@"turbineSpeed"];
                UILabel *lb2 = self.viewDict[@"_21qj"];
                lb2.text=jzDict[@"condensatePressure"];
                UILabel *lb3 = self.viewDict[@"_31qj"];
                lb3.text=jzDict[@"feedPressure"];
                UILabel *lb4 = self.viewDict[@"_41qj"];
                lb4.text=jzDict[@"feedFlow"];
                UILabel *lb5 = self.viewDict[@"_51qj"];
                lb5.text=jzDict[@"backPressure"];
            }
            else
            {
                UILabel *lb1 = self.viewDict[@"_12qj"];
                lb1.text=jzDict[@"turbineSpeed"];
                UILabel *lb2 = self.viewDict[@"_22qj"];
                lb2.text=jzDict[@"condensatePressure"];
                UILabel *lb3 = self.viewDict[@"_32qj"];
                lb3.text=jzDict[@"feedPressure"];
                UILabel *lb4 = self.viewDict[@"_42qj"];
                lb4.text=jzDict[@"feedFlow"];
                UILabel *lb5 = self.viewDict[@"_52qj"];
                lb5.text=jzDict[@"backPressure"];
            }
        }
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

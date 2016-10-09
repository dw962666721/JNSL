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
@property UIView *_1View;
@property UIView *_2View;
@property UIButton *allBtn;
@property UIButton *_1Btn;
@property UIButton *_2Btn;
@property NSMutableDictionary *viewDict;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"京能盛乐热电有限公司";
    [self loadUserInfo];
    [self addViews];
    // Do any additional setup after loading the view.
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
    
    // 添加机组信息
    [self addJZ:230 name:@"jz"];
    
    // 添加锅炉信息
    [self addJZ:320 name:@"gl"];
    
    // 添加汽机信息
    [self addJZ:430 name:@"qj"];
    
    // 添加最下方按钮
    [self addDetails];
    
}

-(void)addTitle
{
    NSInteger y=25;
    // 添加标题
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, y, screenWidth, 25)];
    titleLb.text = @"京能盛乐热电有限公司";
    titleLb.font = [UIFont boldSystemFontOfSize:13];
    titleLb.textColor = [UIColor whiteColor];
    titleLb.textAlignment=NSTextAlignmentCenter;
    [self.MainView addSubview:titleLb];
    
    y+=25;
    // 添加时间
    UILabel *timeLb = [[UILabel alloc] initWithFrame:CGRectMake(0, y, screenWidth, 15)];
    NSDate* today = [NSDate date];
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* s1 = [df stringFromDate:today];
    timeLb.text = s1;
    timeLb.font = [UIFont systemFontOfSize:9];
    timeLb.textColor = [UIColor whiteColor];
    timeLb.textAlignment=NSTextAlignmentCenter;
    [self.MainView addSubview:timeLb];

}
// 添加主框架
-(void)addMainView
{
    // 添加最大的ScrollView
    self.MainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.MainScrollView.showsVerticalScrollIndicator = NO;
    self.MainScrollView.backgroundColor = RGBA(4, 41, 144, 1);
    [self.view addSubview:self.MainScrollView];
    
    // ScrollView填充UIView
    self.MainView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, screenWidth, 630)];
    //    self.MainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_work"]];
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
    NSInteger splitH = 15;
    NSInteger splitW=(screenWidth-x-10)/3;
    NSInteger width0=screenWidth-x-10;
    NSInteger height0=splitH*7;
    // 创建横线
    for (NSInteger i=0; i<8; i++) {
        //画线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(x, y+splitH*i,width0 , 0.7)];
        lineView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        lineView.layer.borderWidth=0.7;
        [self.MainView addSubview:lineView];
        
        // 标刻度
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, y+splitH*i-4, 25, 10)];
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
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(x+splitW*j, y+height0, width0/3, 15)];
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.textColor = [UIColor whiteColor];
        titleLb.font = [UIFont systemFontOfSize:10];
        [self.MainView addSubview:titleLb];
        
        switch (j) {
            case 0:
                titleLb.text=@"全厂";
                self.allView = [[UIView alloc] initWithFrame:CGRectMake(viewBack.frame.origin.x, viewBack.frame.size.height, viewBack.frame.size.width, 0)];
                self.allView.backgroundColor = RGBA(65, 0, 255, 1);
                [viewBack addSubview:self.allView];
                break;
            case 1:
                titleLb.text=@"#1机组";
                self._1View = [[UIView alloc] initWithFrame:CGRectMake(viewBack.frame.origin.x, viewBack.frame.size.height, viewBack.frame.size.width, 0)];
                self._1View.backgroundColor = RGBA(65, 0, 255, 1);
                [viewBack addSubview:self._1View];
                break;
            case 2:
                titleLb.text=@"#1机组";
                self._2View = [[UIView alloc] initWithFrame:CGRectMake(viewBack.frame.origin.x, viewBack.frame.size.height, viewBack.frame.size.width, 0)];
                self._2View.backgroundColor = RGBA(65, 0, 255, 1);
                [viewBack addSubview:self._2View];
                break;
            default:
                break;
        }
        // 添加标志说明
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(x+5, y+height0+20, 10, 10)];
        colorView.backgroundColor = RGBA(65, 0, 255, 1);
        [self.MainView addSubview:colorView];
        
        UILabel *tipLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorView.frame)+2, colorView.frame.origin.y, 55, colorView.frame.size.height)];
        tipLb.text=@"机组负荷(MW)";
        tipLb.font = [UIFont systemFontOfSize:8];
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
    
    self.viewDict = [[NSMutableDictionary alloc] init];
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
                    _2TitleLb.text=@"#2锅炉";
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
                [self.viewDict addObserver:_1Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_11",name] options:NSKeyValueObservingOptionNew context:nil];
                
                UILabel *_2Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_12",name];
                _2Lb.textColor=[UIColor whiteColor];
                _2Lb.textAlignment = NSTextAlignmentCenter;
                _2Lb.font = [UIFont systemFontOfSize:fontSize];
                [_2JZView addSubview:_2Lb];
                [self.viewDict addObserver:_2Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_12",name] options:NSKeyValueObservingOptionNew context:nil];
                
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
                [self.viewDict addObserver:_1Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_21",name] options:NSKeyValueObservingOptionNew context:nil];
                
                UILabel *_2Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_22",name] ;
                _2Lb.textColor=[UIColor whiteColor];
                _2Lb.textAlignment = NSTextAlignmentCenter;
                _2Lb.font = [UIFont systemFontOfSize:fontSize];
                [_2JZView addSubview:_2Lb];
                [self.viewDict addObserver:_2Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_22",name] options:NSKeyValueObservingOptionNew context:nil];
                
                if ([name isEqual:@"gl"]) {
                    titleLb.text=@"主蒸汽温度(C)";
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
                titleLb.text=@"颗粒物";
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
                [self.viewDict addObserver:_1Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_31",name]  options:NSKeyValueObservingOptionNew context:nil];
                
                UILabel *_2Lb= [[UILabel alloc] initWithFrame:CGRectMake(oneWidth*i, 0, oneWidth, contentH)];
                _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_32",name];
                _2Lb.textColor=[UIColor whiteColor];
                _2Lb.textAlignment = NSTextAlignmentCenter;
                _2Lb.font = [UIFont systemFontOfSize:fontSize];
                [_2JZView addSubview:_2Lb];
                [self.viewDict addObserver:_2Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_32",name]  options:NSKeyValueObservingOptionNew context:nil];
                
                
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
                    [self.viewDict addObserver:_1Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_41",name]  options:NSKeyValueObservingOptionNew context:nil];
                    [self.viewDict addObserver:_2Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_42",name]  options:NSKeyValueObservingOptionNew context:nil];
                }
                if ([name isEqual:@"qj"])
                {
                    titleLb.text=@"给水量(t/h)";
                    _1Lb.text=[NSString stringWithFormat:@"%@%@",@"_41",name] ;
                    _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_42",name] ;
                    [self.viewDict addObserver:_1Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_41",name]  options:NSKeyValueObservingOptionNew context:nil];
                    [self.viewDict addObserver:_2Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_42",name]  options:NSKeyValueObservingOptionNew context:nil];
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
                    titleLb.text=@"再热气温度(C)";
                    _1Lb.text=[NSString stringWithFormat:@"%@%@",@"_51",name] ;
                    _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_52",name] ;
                    [self.viewDict addObserver:_1Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_51",name]  options:NSKeyValueObservingOptionNew context:nil];
                    [self.viewDict addObserver:_2Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_52",name]  options:NSKeyValueObservingOptionNew context:nil];
                }
                if ([name isEqual:@"qj"])
                {
                    titleLb.text=@"背压(Mpa)";
                    _1Lb.text=[NSString stringWithFormat:@"%@%@",@"_51",name] ;
                    _2Lb.text=[NSString stringWithFormat:@"%@%@",@"_52",name] ;
                    [self.viewDict addObserver:_1Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_51",name]  options:NSKeyValueObservingOptionNew context:nil];
                    [self.viewDict addObserver:_2Lb forKeyPath:[NSString stringWithFormat:@"%@%@",@"_52",name]  options:NSKeyValueObservingOptionNew context:nil];
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
    NSInteger splitW = (screenWidth-20*2-width*3)/2;
    self._1Btn = [[UIButton alloc] initWithFrame:CGRectMake(20, y, width, height)];
    [self._1Btn setTitle:@"#1" forState:UIControlStateNormal];
    self._1Btn.layer.cornerRadius = 5;
    self._1Btn.backgroundColor = RGBA(0, 171, 97, 1);
    [self._1Btn addTarget:self action:@selector(look1) forControlEvents:UIControlEventTouchUpInside];
    [self.MainView addSubview:self._1Btn];
    
    self.allBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self._1Btn.frame)+splitW, y, width, height)];
    [self.allBtn setTitle:@"公用" forState:UIControlStateNormal];
    self.allBtn.layer.cornerRadius = 5;
    self.allBtn.backgroundColor = RGBA(255, 208, 43, 1);
    [self.allBtn addTarget:self action:@selector(lookAll) forControlEvents:UIControlEventTouchUpInside];
    [self.MainView addSubview:self.allBtn];
    
    self._2Btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.allBtn.frame)+splitW, y, width, height)];
    [self._2Btn setTitle:@"#2" forState:UIControlStateNormal];
    self._2Btn.layer.cornerRadius = 5;
    self._2Btn.backgroundColor = RGBA(75, 129, 249, 1);
    [self._2Btn addTarget:self action:@selector(look2) forControlEvents:UIControlEventTouchUpInside];
    [self.MainView addSubview:self._2Btn];
}
-(void)look1
{
    HomeDetailViewController *detailVC = [[HomeDetailViewController alloc] init];
    [detailVC setVCType:0];
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)lookAll
{
    
}
-(void)look2
{
    
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
//
//  TSMessageViewController.m
//  JNSL
//
//  Created by zw on 16/10/5.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "TSMessageViewController.h"

@interface TSMessageViewController ()
@property UIView *backView;
@end

@implementation TSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"推送设置";
 self.view.backgroundColor = RGBA(229, 230, 232, 1);
    [self addViews];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    NSInteger y=10;
    // 实时推送
    self.ssTimeView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, 45)];
    self.ssTimeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.ssTimeView];
    
    CGRect lbRect = self.ssTimeView.bounds;
    lbRect.size.width=70;
    lbRect.origin.x=10;
//     lbRect.origin.y=10;
    self.ssSendLb = [[UILabel alloc] initWithFrame:lbRect];
    self.ssSendLb.text = @"实时推送";
    self.ssSendLb.font = [UIFont systemFontOfSize:13];
    self.ssSendLb.textColor = TextColor;
    [self.ssTimeView addSubview:self.ssSendLb];
    
    self.ssSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(screenWidth-60, y+(45-30)/2, 50, 20)];
    [self.ssSwitch addTarget:self action:@selector(ssSwithAction) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.ssSwitch];
    
    y=CGRectGetMaxY( self.ssTimeView.frame)+10;
//    lbRect.origin.y=y;
    // 定时推送
    self.dsTimeView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, 45)];
    self.dsTimeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dsTimeView];
    
    self.dsSendLb = [[UILabel alloc] initWithFrame:lbRect];
    self.dsSendLb.text = @"定时推送";
    self.dsSendLb.font = [UIFont systemFontOfSize:13];
    self.dsSendLb.textColor = TextColor;
    [self.dsTimeView addSubview:self.dsSendLb];
    
    CGRect dsTimeFrame = CGRectMake(CGRectGetMaxX(self.dsSendLb.frame)+50, 10, 30, 25);
    self.dsChooseTimeView = [[ChooseTimeView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.dsSendLb.frame)+50, y+10, 25, 20*3)];
    self.dsChooseTimeView.delegate=self;
        self.dsChooseTimeView.backgroundColor = [UIColor whiteColor];
    self.dsChooseTimeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.dsChooseTimeView.layer.borderWidth=0.5;
    self.dsChooseTimeView.layer.cornerRadius = 5;
    self.dsChooseTimeView.layer.masksToBounds=YES;
    self.dsChooseTimeView.hidden = YES;
    [self.view addSubview:self.dsChooseTimeView];
    
    self.dsTimeLb = [[UILabel alloc] initWithFrame:dsTimeFrame];
    [self.dsTimeView addSubview:self.dsTimeLb];
    self.dsTimeLb.text =@"2";
    //self.dsTimeLb.font = [UIFont systemFontOfSize:12];
      self.dsTimeLb.textColor = TextColor;
    
    self.dsDownIco = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dsTimeFrame), (45-5)/2, 10, 5)];
    self.dsDownIco.image = [UIImage imageNamed:@"downIco"];
    [self.dsTimeView addSubview:self.dsDownIco];
    
    self.dsShowTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.dsDownIco.frame)+5, (45-20)/2, 40, 20)];
    self.dsShowTime .text = @"小时";
    self.dsShowTime.font = [UIFont systemFontOfSize:13];
    self.dsShowTime.textColor = TextColor;
    [self.dsTimeView addSubview:self.dsShowTime];
    
    self.dsTimeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(screenWidth-60, (45-30)/2, 50, 20)];
    [self.dsTimeSwitch addTarget:self action:@selector(dsSwithAction) forControlEvents:UIControlEventValueChanged];
    [self.dsTimeView addSubview:self.dsTimeSwitch];
//    [self.dsTimeView sendSubviewToBack:self.dsSendLb];
    
     y=CGRectGetMaxY( self.dsTimeView.frame)+10;
//     lbRect.origin.y=10;
    // 不推送
    self.notTsView = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, 45)];
    self.notTsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.notTsView];
    
    self.notTsSendLb = [[UILabel alloc] initWithFrame:lbRect];
    self.notTsSendLb.text = @"不推送";
    self.notTsSendLb.font = [UIFont systemFontOfSize:13];
    self.notTsSendLb.textColor = TextColor;
    [self.notTsView addSubview:self.notTsSendLb];
    
    self.notTsSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(screenWidth-60, (45-30)/2, 50, 20)];
    [self.notTsSwitch addTarget:self action:@selector(notSwithAction) forControlEvents:UIControlEventValueChanged];
    [self.notTsView addSubview:self.notTsSwitch];
    
    self.backView = [[UIView alloc] initWithFrame:self.view.frame];
    self.backView.backgroundColor = RGBA(249, 249, 249, 0.01);
    self.backView.hidden = YES;
    [self.view addSubview:self.backView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenChooseView)];
    [self.backView addGestureRecognizer:tap];
    
    // 把提示框前移
    [self.view bringSubviewToFront:self.dsChooseTimeView];
    
    UITapGestureRecognizer *timeChooseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeChooseTap)];
    [self.dsTimeLb addGestureRecognizer:timeChooseTap];
    self.dsTimeLb.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *timeChooseTap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeChooseTap)];
    [self.dsDownIco addGestureRecognizer:timeChooseTap0];
    self.dsDownIco.userInteractionEnabled = YES;
}
-(void)timeChooseTap
{
    NSInteger y= CGRectGetMaxY( self.ssTimeView.frame)+10;
    CGRect rect = CGRectMake(CGRectGetMaxX(self.dsSendLb.frame)+50, y+10, 25, 20*3);
    if ([self.dsTimeLb.text isEqual:@"2"]) {
        rect.origin.y = y+10;
    }
    else if ([self.dsTimeLb.text isEqual:@"12"])
    {
        rect.origin.y = y+10-20;
    }
    else
    {
        rect.origin.y = y+10-40;
    }
    self.dsChooseTimeView._Frame = rect;
    self.backView.hidden=NO;
    [self.dsChooseTimeView show];
}
-(void)hidenChooseView
{
      self.backView.hidden=YES;
      self.dsChooseTimeView.hidden = YES;
}
-(void)ChooseTimeViewClick:(NSInteger)time
{
    self.dsTimeLb.text = [NSString stringWithFormat:@"%d",time];
    self.backView.hidden=YES;
    self.dsChooseTimeView.hidden = YES;
}
-(void)ssSwithAction
{
    
}
-(void)dsSwithAction
{
    
}
-(void)notSwithAction
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

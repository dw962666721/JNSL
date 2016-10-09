//
//  SendQuestionViewController.m
//  JNSL
//
//  Created by zw on 16/10/5.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "SendQuestionViewController.h"

@interface SendQuestionViewController ()
@property UIView *TopView;
@property UIView *helpView;
@property UIImageView *helpImageView;
@property UIView *jyView;
@property UIImageView *jyImageView;
@property UIView *otherView;
@property UIImageView *otherImageView;

@property UITextView *contentTextView;
@property UILabel *placeholderLabel;
@property UITextView *QQTextFiled;
@property UILabel *qqPlaceholderLabel;
@property UIButton *sendBtn;
@end

@implementation SendQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    self.title=@"问题留言";
    [self addViews];
    // Do any additional setup after loading the view.
}
-(void)addViews
{
    self.TopView = [[UIView alloc] initWithFrame:CGRectMake(10, 15, screenWidth-20, 35*4)];
    self.TopView.layer.borderWidth = 0.7;
    self.TopView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.TopView.layer.cornerRadius = 5;
    self.TopView.layer.masksToBounds=YES;
    self.TopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TopView];
    
    UILabel *questionTypeLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.5, CGRectGetWidth(self.TopView.frame), 35)];
    questionTypeLb.text = @" 请选择问题类型";
    questionTypeLb.textColor = RGBA(90, 90, 90, 1);
    questionTypeLb.font = [UIFont systemFontOfSize:13];
    [self.TopView addSubview:questionTypeLb];
    
    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(questionTypeLb.frame), CGRectGetWidth(questionTypeLb.frame), 0.5)];
    line0.layer.borderColor = [UIColor lightGrayColor].CGColor;
    line0.layer.borderWidth=0.7;
    [self.TopView addSubview:line0];
    
    // 使用帮助
    NSInteger y=CGRectGetMaxY(line0.frame);
    CGRect viewRect = CGRectMake(0, y, screenWidth, 35);
    self.helpView = [[UIView alloc] initWithFrame:viewRect];
    self.helpView.backgroundColor = [UIColor whiteColor];
    [self.TopView addSubview:self.helpView];
    
    UILabel *helpLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 35)];
    helpLb.text=@"              使用帮助";
    helpLb.font = [UIFont systemFontOfSize:13];
    [self.helpView addSubview:helpLb];
    
    self.helpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(helpLb.frame)-60,(35-20)/2, 20, 20)];
    self.helpImageView.image = [UIImage imageNamed:@"ClickIco"];
    [self.helpView addSubview:self.helpImageView];
    
    UIView *helpLine = [[UIView alloc] initWithFrame:CGRectMake(30, 35-1, screenWidth-30, 0.7)];
    helpLine.layer.borderWidth = 0.7;
    helpLine.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.helpView addSubview:helpLine];
    
    // 建议反馈
    y=CGRectGetMaxY(self.helpView.frame);
    viewRect = CGRectMake(0, y, screenWidth, 35);
    self.jyView = [[UIView alloc] initWithFrame:viewRect];
    self.jyView.backgroundColor = [UIColor whiteColor];
    [self.TopView addSubview:self.jyView];
    
    UILabel *jyLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 35)];
    jyLb.text=@"              建议反馈";
    jyLb.font = [UIFont systemFontOfSize:13];
    [self.jyView addSubview:jyLb];
    
    self.jyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(jyLb.frame)-60,(35-20)/2, 20, 20)];
    self.jyImageView.image = [UIImage imageNamed:@"unClickIco"];
    [self.jyView addSubview:self.jyImageView];
    
    UIView *jyLine = [[UIView alloc] initWithFrame:CGRectMake(30, 35-1, screenWidth-30, 0.7)];
    jyLine.layer.borderWidth = 0.7;
    jyLine.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.jyView addSubview:jyLine];
    
    // 其他帮助
    y=CGRectGetMaxY(self.jyView.frame);
    viewRect = CGRectMake(0, y, screenWidth, 35);
    self.otherView = [[UIView alloc] initWithFrame:viewRect];
    self.otherView.backgroundColor = [UIColor whiteColor];
    [self.TopView addSubview:self.otherView];
    
    UILabel *otherLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 35)];
    otherLb.text=@"              其他帮助";
    otherLb.font = [UIFont systemFontOfSize:13];
    [self.otherView addSubview:otherLb];
    
    self.otherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(otherLb.frame)-60,(35-20)/2, 20, 20)];
    self.otherImageView.image = [UIImage imageNamed:@"unClickIco"];
    [self.otherView addSubview:self.otherImageView];
    
    UIView *otherLine = [[UIView alloc] initWithFrame:CGRectMake(30, 35-1, screenWidth-30, 0.7)];
    otherLine.layer.borderWidth = 0.7;
    otherLine.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.otherView addSubview:otherLine];
    
    // 反馈内容
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.TopView.frame)+15, screenWidth-20, 80)];
    self.contentTextView.layer.cornerRadius = 5;
    self.contentTextView.delegate = self;
    [self.view addSubview:self.contentTextView];
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMinY(self.contentTextView.frame)+4, screenWidth-20, 20)];
    self.placeholderLabel.text = @"反馈内容";
    self.placeholderLabel.font=[UIFont systemFontOfSize:12];
    self.placeholderLabel.textColor = RGBA(90, 90, 90, 1);
    [self.view addSubview:self.placeholderLabel];
    
    // 联系方式
    self.QQTextFiled = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.contentTextView.frame)+15, screenWidth-20, 30)];
//    self.QQTextFiled.placeholder = @"联系方式(Email、QQ号或其他)";
    self.QQTextFiled.layer.cornerRadius=5;
    self.QQTextFiled.delegate=self;
    self.QQTextFiled.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.QQTextFiled];
    
    self.qqPlaceholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMinY(self.QQTextFiled.frame)+4, screenWidth-20, 20)];
    self.qqPlaceholderLabel.text = @"联系方式(Email、QQ号或其他)";
    self.qqPlaceholderLabel.font=[UIFont systemFontOfSize:12];
    self.qqPlaceholderLabel.textColor = RGBA(90, 90, 90, 1);
    [self.view addSubview:self.qqPlaceholderLabel];

    
    
    // 提交按钮
    self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.QQTextFiled.frame)+15, screenWidth-20, 35)];
    self.sendBtn.backgroundColor = ColorWithRGB(0x999999);
    self.sendBtn.layer.cornerRadius = 5;
    [self.sendBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    [self.sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendBtn addTarget: self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendBtn];
    
    // 添加点击事件
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchHelp)];
    [self.helpView addGestureRecognizer:tap1];
    self.helpView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchJy)];
    [self.jyView addGestureRecognizer:tap2];
    self.jyView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchOther)];
    [self.otherView addGestureRecognizer:tap3];
    self.otherView.userInteractionEnabled = YES;
    
    

    
    
}
-(void)sendMessage
{
    
}
-(void)touchHelp
{
    self.helpImageView.image = [UIImage imageNamed:@"ClickIco"];
    self.jyImageView.image = [UIImage imageNamed:@"unClickIco"];
    self.otherImageView.image = [UIImage imageNamed:@"unClickIco"];
}
-(void)touchJy
{
    self.helpImageView.image = [UIImage imageNamed:@"unClickIco"];
    self.jyImageView.image = [UIImage imageNamed:@"ClickIco"];
    self.otherImageView.image = [UIImage imageNamed:@"unClickIco"];
}
-(void)touchOther
{
    self.helpImageView.image = [UIImage imageNamed:@"unClickIco"];
    self.jyImageView.image = [UIImage imageNamed:@"unClickIco"];
    self.otherImageView.image = [UIImage imageNamed:@"ClickIco"];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
        
    {
        if (textView == self.contentTextView) {
            self.placeholderLabel.hidden = YES;
        }
        else
        {
            self.qqPlaceholderLabel.hidden = YES;
        }
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        
        if (textView == self.contentTextView) {
            self.placeholderLabel.hidden = NO;
        }
        else
        {
            self.qqPlaceholderLabel.hidden = NO;
        }
    }
    
    return YES;
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

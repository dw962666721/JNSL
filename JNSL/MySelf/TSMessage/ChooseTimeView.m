//
//  ChooseTImeView.m
//  JNSL
//
//  Created by zw on 16/10/5.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "ChooseTImeView.h"
#define ViewH  20
@implementation ChooseTimeView
-(id)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [super initWithFrame:frame];
        self._Frame = frame;
//        self.hidden = YES;
    }
    return self;
}
-(UIView*)_BackView
{
    if (!__BackView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,screenWidth, screenHeight)];
        view.backgroundColor = RGBA(249, 249, 249, 0.01);
        view.backgroundColor = [UIColor lightGrayColor];
        view.backgroundColor = [UIColor yellowColor];
//        [self addSubview:view];
        self._BackView = __BackView;
    }
    return __BackView;
}
-(UIView*)_2View
{
    if (!__2View) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, ViewH)];
        CGRect rect = view.bounds;
        rect.origin.y=1;
        UILabel *lb = [[UILabel alloc] initWithFrame:rect];
        lb.text=@"2";
        [view addSubview:lb];
        [self addSubview:view];
        __2View = view;
    }
    return __2View;
}
-(UIView*)_12View
{
    if (!__12View) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, ViewH, self.frame.size.width, ViewH)];
        CGRect rect = view.bounds;
        rect.origin.y=1;
        UILabel *lb = [[UILabel alloc] initWithFrame:rect];
        lb.text=@"12";
        [view addSubview:lb];
        [self addSubview:view];
        __12View = view;
    }
    return __12View;
}
-(UIView*)_24View
{
    if (!__24View) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, ViewH*2, self.frame.size.width, ViewH)];
        CGRect rect = view.bounds;
        rect.origin.y=1;
        UILabel *lb = [[UILabel alloc] initWithFrame:rect];
        lb.text=@"24";
        [view addSubview:lb];
        [self addSubview:view];
        __24View = view;
    }
    return __24View;
}
-(void)layoutSubviews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(show)];
    [self addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBack)];
    [self._BackView addGestureRecognizer:tapBack];

    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch2)];
    [self._2View addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap12 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch12)];
    [self._12View addGestureRecognizer:tap12];
    
    UITapGestureRecognizer *tap24 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch24)];
    [self._24View addGestureRecognizer:tap24];
    
//    [self addSubview:self._2View];
//    [self addSubview:self._12View];
//    [self addSubview:self._24View];
}
-(void)show:(UIViewController*)rootVC
{
    self.rootVC=rootVC;
    UIView *parentView = rootVC.view;
    if (parentView) {
        self._BackView.frame = parentView.frame;
        [parentView addSubview:self._BackView];
        [parentView bringSubviewToFront:self];
        self.hidden = NO;
        self.frame = CGRectMake(self._Frame.origin.x, self._Frame.origin.y, self._Frame.size.width, 0);
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = self._Frame;
        }];
//        [self._BackView addSubview:self._2View];
//        [self._BackView addSubview:self._12View];
//        [self._BackView addSubview:self._24View];
    }
}
-(void)show
{
    if (!self.hidden) {
        self.hidden=YES;
    }
    UIView *parentView = self.superview;
    if (parentView) {
        self._BackView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        [parentView addSubview:self._BackView];
        [parentView bringSubviewToFront:self];
        self._BackView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        self.hidden = NO;
        self.frame = CGRectMake(self._Frame.origin.x, self._Frame.origin.y, self._Frame.size.width, 0);
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = self._Frame;
        }];
    }
}
-(void)touchBack
{
    self.hidden = YES;
}
-(void)touch2
{
    self.tag = 902;
    [self.delegate ChooseTimeViewClick:2];
    self.hidden=YES;
}
-(void)touch12
{
    self.tag = 912;
     [self.delegate ChooseTimeViewClick:12];
    self.hidden=YES;
}
-(void)touch24
{
    self.tag = 924;
     [self.delegate ChooseTimeViewClick:24];
    self.hidden=YES;
}
@end

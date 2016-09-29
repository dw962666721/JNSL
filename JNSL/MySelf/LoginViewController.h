//
//  LoginViewController.h
//  TYLM
//
//  Created by zw on 16/9/28.
//  Copyright © 2016年 dw962666721. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UIView *userView;
@property (nonatomic,strong) UIImageView *userIcoImageView;
@property (nonatomic,strong) UITextField *userTextField;

@property (nonatomic,strong) UIImageView *passWordIcoImageView;
@property (nonatomic,strong) UIView *passWordtView;
@property (nonatomic,strong) UITextField *passWordTextField;

@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *setBtn;

@property (nonatomic,strong) UIView *setView;
@property (nonatomic,strong) UITextField *serverIpTextFiled;
@property (nonatomic,strong) UIButton *sureServerBtn;
@end

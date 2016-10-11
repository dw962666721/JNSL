//
//  TSMessageViewController.h
//  JNSL
//
//  Created by zw on 16/10/5.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseTimeView.h"

@interface TSMessageViewController : baseViewController<ChooseTimeViewDelegate>
@property (nonatomic,strong) UIView *ssTimeView;
@property (nonatomic,strong) UILabel *ssSendLb;
@property (nonatomic,strong) UISwitch *ssSwitch;



@property (nonatomic,strong) UIView *dsTimeView;
@property (nonatomic,strong) UILabel *dsSendLb;
@property (nonatomic,strong) ChooseTimeView *dsChooseTimeView;
@property (nonatomic,strong) UILabel *dsTimeLb;
@property (nonatomic,strong) UIImageView *dsDownIco;
@property (nonatomic,strong) UILabel *dsShowTime;
@property (nonatomic,strong) UISwitch *dsTimeSwitch;



@property (nonatomic,strong) UIView *notTsView;
@property (nonatomic,strong) UILabel *notTsSendLb;
@property (nonatomic,strong) UISwitch *notTsSwitch;


@end

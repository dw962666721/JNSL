//
//  MainViewController.h
//  TYLM
//
//  Created by user on 16/8/4.
//  Copyright (c) 2016年 dw962666721. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSCustomTabbar.h"
#import "MySelfViewController.h"
#define kTabbarHeight 49.0f

@interface MainViewController : UIViewController<UINavigationControllerDelegate,JSCustomTabbarDataSource,JSCustomTabbarDelegate>
@property (nonatomic,strong) JSCustomTabbar *tabbar;
@property (nonatomic,strong) UINavigationController *selectedViewController;
@end


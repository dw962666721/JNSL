//
//  JSCustomTabbar.h
//  TYLM
//
//  Created by user on 16/8/4.
//  Copyright (c) 2016年 dw962666721. All rights reserved.
//
#import "JSCustomTabbarItem.h"
#import <UIKit/UIKit.h>
@class JSCustomTabbar;
@protocol JSCustomTabbarDelegate<NSObject>
-(void)tabbarDidSelected:(NSInteger)index;
@end

@protocol JSCustomTabbarDataSource<NSObject>
-(NSString*)customTabbar:(JSCustomTabbar *)customTabbar  titleForButtonAtIndex:(NSInteger) index;
-(NSString*)customTabbar:(JSCustomTabbar *)customTabbar imageNormalForButtonAtIndex:(NSInteger)index;
@end

@interface JSCustomTabbar : UIView
//private var currentSelecteItem:JSCustomTabbarItem!
@property (strong,nonatomic) JSCustomTabbarItem *currentSelecteItem;
@property (strong,nonatomic) id<JSCustomTabbarDelegate> delegate;
@property (strong,nonatomic) id<JSCustomTabbarDataSource> datasource;
@end

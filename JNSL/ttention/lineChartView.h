//
//  lineChartView.h
//  ImageCorner
//
//  Created by zw on 16/3/22.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lineChartView : UIView

@property (nonatomic,strong) NSArray *arr;

@property (nonatomic,strong) UILabel *lbx;
@property (nonatomic,strong) UILabel *lby;

@property  CGFloat vw;
@property  CGFloat vh;
@property  CGFloat widunit;
@property  CGFloat heiunit;

@end

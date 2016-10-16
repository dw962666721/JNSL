//
//  totalAmountViewController.h
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "baseViewController.h"
#import "rounfView.h"
#import "lineChartView.h"

@interface totalAmountViewController : baseViewController

@property UIScrollView *scroll;
@property rounfView *orvl;
@property UILabel *lineTitle;

@property UIButton *lineBtn1;
@property UIButton *lineBtn2;
@property UIButton *lineBtn3;

@property lineChartView *zhexianview;
@property NSArray *zhexianArr;
@end

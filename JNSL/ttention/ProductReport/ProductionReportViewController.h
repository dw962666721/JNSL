//
//  ProductionReportViewController.h
//  JNSL
//
//  Created by zw on 2016/11/12.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YearMonthView.h"
#import "WeekTableViewCell.h"
#import "ReportViewController.h"

@interface ProductionReportViewController : baseViewController<WeekTableViewCellDelegate, YearMonthViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) NSDate *currentDate;
@property (nonatomic,strong) NSDate *selectedDate;
@property (nonatomic,strong) YearMonthView *yearMonthView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UITableView *leftTebleView;
@property (nonatomic,strong) UITableView *centerTebleView;
@property (nonatomic,strong) UITableView *rightTebleView;
@end

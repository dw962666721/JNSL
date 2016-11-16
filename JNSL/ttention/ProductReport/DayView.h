//
//  DayView.h
//  JNSL
//
//  Created by zw on 2016/11/14.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DayViewDelegate<NSObject>
-(void)DayViewSelected:(NSInteger)dayNum;
@end
@interface DayView : UIView
@property (nonatomic,strong) id<DayViewDelegate> delegate;
@property (nonatomic,strong) UIView *selectedView;
@property (nonatomic,strong) UILabel *dayLb;
@property (nonatomic,strong) UILabel *dayReportLb;
@property (nonatomic,strong) UILabel *weekReportLb;
@property (nonatomic,strong) UILabel *monthReportLb;
-(void)setData:(NSMutableDictionary*)data;
@end

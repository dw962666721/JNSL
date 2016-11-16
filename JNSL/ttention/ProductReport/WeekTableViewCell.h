//
//  WeekTableViewCell.h
//  JNSL
//
//  Created by zw on 2016/11/14.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayView.h"
@protocol WeekTableViewCellDelegate
-(void)WeekTableViewCellSelectedIndex:(NSInteger)day;
@end
@interface WeekTableViewCell : UITableViewCell<DayViewDelegate>
@property (nonatomic,strong) id<WeekTableViewCellDelegate> delegate;
@property (nonatomic,strong) DayView *dayView1;
@property (nonatomic,strong) DayView *dayView2;
@property (nonatomic,strong) DayView *dayView3;
@property (nonatomic,strong) DayView *dayView4;
@property (nonatomic,strong) DayView *dayView5;
@property (nonatomic,strong) DayView *dayView6;
@property (nonatomic,strong) DayView *dayView7;
-(void)setDayDict:(NSMutableDictionary*)data;
@end

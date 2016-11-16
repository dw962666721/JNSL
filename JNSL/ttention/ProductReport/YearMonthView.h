//
//  YwaeMonthView.h
//  JNSL
//
//  Created by zw on 2016/11/12.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YearMonthViewDelegate<NSObject>
-(void)YearMonthViewLastYear:(NSString*)dateStr;
-(void)YearMonthViewNextYear:(NSString*)dateStr;
@end
@interface YearMonthView : UIView
@property (nonatomic,strong) id<YearMonthViewDelegate> delegate;
@property (nonatomic,strong) NSString *dateStr;
@property (nonatomic,strong) UILabel *yearMonthLb;
@property (nonatomic,strong) UIImageView *lastMonthImageView;
@property (nonatomic,strong) UIImageView *nextMonthImageView;
@property (nonatomic,strong) UIView *weekView;
-(void)setCurrentDateStr:(NSString*)dateStr;
-(NSString*)getDateStr;
@end

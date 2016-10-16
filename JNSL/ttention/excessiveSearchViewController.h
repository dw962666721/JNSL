//
//  excessiveSearchViewController.h
//  JNSL
//
//  Created by zw on 16/10/15.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "baseViewController.h"

@protocol excessiveSearchProtocal <NSObject>
-(void)searchClick:(NSString *)wuranwu withbegintime:(NSString *)begintime withendtime:(NSString *)endtime;
@end


@interface excessiveSearchViewController : baseViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property UIPickerView *typepick;
@property UIView *panelView;
@property UIButton *cancelBtn;
@property UIButton *confirmBtn;

@property UILabel *wura;
@property UIButton *wuratext;

@property UILabel *begintime;
@property UIButton *begintimetext;

@property UILabel *endtime;
@property UIButton *endtimetext;

@property UIDatePicker *datePicker;

@property NSArray *arr1;

@property UIButton * pageConfirmBtn;

@property id<excessiveSearchProtocal> serachprotocal;


@end




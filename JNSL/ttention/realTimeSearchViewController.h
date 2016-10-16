//
//  realTimeSearchViewController.h
//  JNSL
//
//  Created by zw on 16/10/16.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "baseViewController.h"
@protocol overproofSearchProtocal <NSObject>
-(void)searchClick:(NSString *)typeid;
@end


@interface realTimeSearchViewController : baseViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property UIPickerView *typepick;
@property UIView *panelView;
@property UIButton *cancelBtn;
@property UIButton *confirmBtn;

@property UILabel *wura;
@property UIButton *wuratext;
@property NSMutableArray *arr1;

@property UIButton * pageConfirmBtn;


@property id<overproofSearchProtocal> serachprotocal;
@end

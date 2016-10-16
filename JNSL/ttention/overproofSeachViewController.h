//
//  overproofSeachViewController.h
//  JNSL
//
//  Created by zw on 16/10/15.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "baseViewController.h"
#import "HooDatePicker.h"

@protocol overproofSearchProtocal <NSObject>
-(void)searchClick:(NSString *)begintime;
@end


@interface overproofSeachViewController : baseViewController



@property UILabel *wura;
@property UIButton *wuratext;

@property HooDatePicker *datePicker;


@property UIButton * pageConfirmBtn;

@property id<overproofSearchProtocal> serachprotocal;
@end

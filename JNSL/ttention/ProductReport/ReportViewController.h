//
//  ReportViewController.h
//  JNSL
//
//  Created by wangjiang on 16/11/20.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zhifaViewController.h"

@interface ReportViewController : zhifaViewController
@property (nonatomic,strong) NSString*dayStr;
-(void)setData:(NSString*)dateStr;
@end

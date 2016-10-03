//
//  myAttentionViewController.h
//  JNSL
//
//  Created by wangjiang on 16/10/1.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "attentionCollectionViewCell.h"
#import "totalAmountViewController.h"
#import "excessiveWarinngViewController.h"
#import "unusualReportViewController.h"
#import "overproofReportViewController.h"
#import "realtimeViewController.h"
#import "realTechnologoViewController.h"

@interface myAttentionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property totalAmountViewController *totalAmount;
@property excessiveWarinngViewController *excessiveWarinng;
@property unusualReportViewController *unusualReport;
@property overproofReportViewController *overproofReport;
@property realtimeViewController *realtime;
@property realTechnologoViewController *realTechnologo;

@end

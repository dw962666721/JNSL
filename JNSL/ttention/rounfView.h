//
//  rounfView.h
//  ImageCorner
//
//  Created by zw on 16/3/22.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rounfView : UIView

@property (nonatomic,strong) NSArray *arr;

@property UILabel *lb1;
@property UILabel *lb2;
@property UILabel *lb3;
@property UILabel *lb4;
-(void)setText:(NSDictionary *)data;
@property double zhinanzhen;
@property UIImageView *img;

@property double haifrac;
@end

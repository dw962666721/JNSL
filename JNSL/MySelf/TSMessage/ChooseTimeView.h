//
//  ChooseTImeView.h
//  JNSL
//
//  Created by zw on 16/10/5.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChooseTimeViewDelegate <NSObject>
-(void)ChooseTimeViewClick:(NSInteger)time;
@end

@interface ChooseTimeView : UIView
@property (strong,nonatomic) UIView *_2View;
@property (strong,nonatomic) UIView *_12View;
@property (strong,nonatomic) UIView *_24View;
@property (strong,nonatomic) UIView *_BackView;
@property (strong,nonatomic) id<ChooseTimeViewDelegate> delegate;
@property CGRect _Frame;
@property UIViewController *rootVC;
-(void)show;
@end

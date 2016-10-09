//
//  CustemButton.m
//  JNSL
//
//  Created by zw on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "CustemButton.h"

@implementation CustemButton

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     self.backgroundColor = [UIColor lightGrayColor];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     self.backgroundColor = [UIColor whiteColor];
}

@end

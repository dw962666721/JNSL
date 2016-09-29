//
//  UserInfo.h
//  TYLM
//
//  Created by zw on 16/9/28.
//  Copyright © 2016年 dw962666721. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
//@property (strong,nonatomic) UserInfo *info;
@property (strong,nonatomic) NSString *useName;
@property (strong,nonatomic) NSString *passWord;
@property (strong,nonatomic) NSDictionary *userDict;
-(NSDictionary*)getUserDict;
+(UserInfo*)userInfo;
@end

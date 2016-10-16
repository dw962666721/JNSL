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
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *userIcon;
@property (strong,nonatomic) NSString *userId;
@property (strong,nonatomic) NSString *rollName;
@property (strong,nonatomic) NSString *phoneNum;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *pollSourceId;
@property (strong,nonatomic) NSString *ip;
//@property (strong,nonatomic) NSString *tsChoose;
//@property (strong,nonatomic) NSDictionary *userDict;
-(NSDictionary*)getUserDict;
-(void)clearUserDict;
+(UserInfo*)userInfo;
+(NSString*)ipStr;
@end

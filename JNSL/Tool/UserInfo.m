//
//  UserInfo.m
//  TYLM
//
//  Created by zw on 16/9/28.
//  Copyright © 2016年 dw962666721. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
static UserInfo* instance = nil;
+(UserInfo*)userInfo
{
    if (instance==nil) {
        instance = [[UserInfo alloc] init];
    }
    return instance;
}
+(NSString*)ipStr
{
    if (instance==nil) {
        instance = [[UserInfo alloc] init];
    }
    return instance.ip;
}
//// 设置用户名
//-(void)setUserName:(NSString *)userName
//{
//    instance.userName = userName;
//}
//// 用户头像
//-(void)setUserIcon:(NSString *)userIcon
//{
//    instance.userIcon = userIcon;
//}
//// 用户ID
//-(void)setUserId:(NSString *)userId
//{
//    instance.userId = userId;
//}
//// 真实姓名
//-(void)setRollName:(NSString *)rollName
//{
//    instance.rollName = rollName;
//}
//// 手机号码
//-(void)setPhoneNum:(NSString *)phoneNum
//{
//    instance.phoneNum = phoneNum;
//}
//// 电子邮箱
//-(void)setEmail:(NSString *)email
//{
//    instance.email = email;
//}
//// 用户绑定的企业id
//-(void)setPollSourceId:(NSString *)pollSourceId
//{
//    instance.pollSourceId = pollSourceId;
//}
// 设置用户数据
//-(void)setUserDict:(NSDictionary *)userDict
//{
//    instance.userDict=userDict;
//    [[NSUserDefaults standardUserDefaults] addObserver:userDict forKeyPath:@"JNSL" options:NSKeyValueObservingOptionOld context:nil];
//}
// 获取用户数据
-(NSDictionary*)getUserDict
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"JNSL"];
}
-(void)clearUserDict
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"JNSL"];
    instance.userName = @"";
    instance.userId = @"";
    instance.userIcon = @"";
    instance.rollName = @"";
    instance.phoneNum = @"";
    instance.email = @"";
    instance.pollSourceId = @"";
//    instance.tsChoose=@"0";
}
@end

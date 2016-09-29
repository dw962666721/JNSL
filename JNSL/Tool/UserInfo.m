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
// 设置用户名
-(void)setUseName:(NSString *)useName
{
    self.useName = useName;
}
// 设置密码
-(void)setPassWord:(NSString *)passWord
{
    self.passWord = passWord;
}
// 设置用户数据
-(void)setUserDict:(NSDictionary *)userDict
{
    self.userDict=userDict;
    [[NSUserDefaults standardUserDefaults] addObserver:userDict forKeyPath:@"TYLM" options:NSKeyValueObservingOptionOld context:nil];
}
// 获取用户数据
-(NSDictionary*)getUserDict
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"TYLM"];
}
@end

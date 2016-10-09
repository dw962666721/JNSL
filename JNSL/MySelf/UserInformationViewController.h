//
//  UserInformationViewController.h
//  JNSL
//
//  Created by zw on 16/9/30.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInformationViewController : UIViewController<UIActionSheetDelegate>
@property (strong,nonatomic) CustemButton *userNameView;
@property (strong,nonatomic) CustemButton *phoneView;
@property (strong,nonatomic) CustemButton *emailView;

@property (strong,nonatomic) CustemButton *exitButton;
@end

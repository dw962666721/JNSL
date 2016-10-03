//
//  huanbaoWebViewController.h
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"

@interface huanbaoWebViewController : baseViewController<UINavigationControllerDelegate>
@property UIWebView *webview;
@property NSString *htmlname;
@end

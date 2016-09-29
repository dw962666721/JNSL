//
//  MainViewController.m
//  TYLM
//
//  Created by user on 16/8/4.
//  Copyright (c) 2016年 dw962666721. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加tabbar
    [self addTabbar];
    
    // 2.创建所有的子控制器
    [self createChildViewControllers];
    
    // 3.默认选中第0个控制器
    [self selecteControllerAtIndex:0];
    // 4.设置导航栏主题
    [self setNavigationTheme];
    
    //    NSNotificationCenter.defaultCenter().[addObserver(self, selector: "dealAps", name: "PushNotification", object: nil)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealAps) name:@"PushNotification" object:nil];
    // 5.处理通知
    [self dealAps];
    
}
-(void)dealAps
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"apsNotification"]==nil)
    {
        [UIApplication sharedApplication].applicationIconBadgeNumber=0;
        return;
    }
    
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"apsNotification"];
    if (userInfo) {
        if (userInfo[@"UIApplicationLaunchOptionsRemoteNotificationKey"]!=nil) {
            NSObject *userInfoNotification = userInfo[UIApplicationLaunchOptionsRemoteNotificationKey];
            NSDictionary *userInfoAPS = [(NSDictionary *)userInfoNotification objectForKey:@"aps"];
            [self dealUserInfo:userInfoAPS];
            return;
        }
    }
    NSDictionary *message = userInfo[@"aps"];
    [self dealUserInfo:message];
}
-(void)dealUserInfo:(NSDictionary*)userInfo
{
    
}
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 根控制器
    UIViewController *root = navigationController.viewControllers[0];
    if(viewController!=root)
    {
        // 更改导航控制器view的frame
        navigationController.view.frame = self.view.bounds;
        // 让tabbar从MainViewController上移除
        [self.tabbar removeFromSuperview];
        // 调整tabbar的Y值
        CGRect tabbarFrame = self.tabbar.frame;
        if ([root.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scroll = (UIScrollView*)root.view;
            tabbarFrame.origin.y = scroll.contentOffset.y + root.view.frame.size.height - kTabbarHeight;
        }
        else
        {
            tabbarFrame.origin.y = self.view.frame.size.height - kTabbarHeight - 64;
        }
        self.tabbar.frame = tabbarFrame;
        // 添加tabbar到根控制器界面
        [root.view addSubview:self.tabbar];
    }
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 根控制器
    UIViewController *root = (UIViewController*)navigationController.viewControllers[0];
    if (viewController==root) {
        // 更改导航控制器view的frame
        navigationController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kTabbarHeight);
        // 让tabbar从root上移除
        [self.tabbar removeFromSuperview];
        // 添加tabbar到MainViewController
        self.tabbar.frame = CGRectMake(0, self.view.frame.size.height-kTabbarHeight, self.view.frame.size.width, kTabbarHeight);
        [self.view addSubview:self.tabbar];
    }
}
-(void)addTabbar
{
    self.titleArray = [NSArray arrayWithObjects:@"首页",@"关注",@"环保知识",@"我的", nil];
    // 1.添加tabbar
    JSCustomTabbar *tabbar = [[JSCustomTabbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-kTabbarHeight, self.view.frame.size.width, kTabbarHeight)];
    tabbar.delegate=self;
    tabbar.datasource=self;
    [self.view addSubview:tabbar];
    self.tabbar=tabbar;
}

-(void)tabbarDidSelected:(NSInteger)index
{
    // 3.监听tabbar内部item的点击
    [self selecteControllerAtIndex:index];
    
}
-(void)createChildViewControllers
{
    UIViewController *view1=[[UIViewController alloc] init];
    view1.title = @"首页";
    [self addChildViewController:view1];
    
    UIViewController *view2=[[UIViewController alloc] init];
    [self addChildViewController:view2];
    
    UIViewController *view3=[[UIViewController alloc] init];
    [self addChildViewController:view3];
    
    MySelfViewController *mySelfView=[[MySelfViewController alloc] init];
    [self addChildViewController:mySelfView];
    
}
////MARK --  选中index位置对应的子控制器
-(void)selecteControllerAtIndex:(NSInteger)index
{
    UINavigationController *newNav = self.childViewControllers[index];
    if (newNav==self.selectedViewController) {
        return;
    }
    else
    {
        // 1.移除当前控制器的view
        [self.selectedViewController.view removeFromSuperview];
        // 2.添加新控制器的view
        newNav.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kTabbarHeight);
        [self.view addSubview:newNav.view];
        //3.让新控制器成为当前当前选中的控制器
        self.selectedViewController=newNav;
    }
}
-(void)setNavigationTheme
{
    // 1.导航栏
    // 1.1.操作navBar相当操作整个应用中的所有导航栏
    UINavigationBar *navBar=[UINavigationBar appearance];
    // 1.2.设置导航栏背景
    [navBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    // 1.3.设置状态栏背景
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //相对于上面的接口，这个接口可以动画的改变statusBar的前景色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleLightContent;
}

-(void)addChildViewController:(UIViewController *)childController
{
    // 1.创建导航控制器的目的：需要一个导航条
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:childController];
    nav.delegate = self;
    // 1.4.设置导航栏的文字
    nav.navigationBar.tintColor = [UIColor whiteColor];
    nav.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    // 2.添加子控制器（包装过后的导航控制器）
    [super addChildViewController:nav];
}
-(NSString*)customTabbar:(JSCustomTabbar *)customTabbar imageNormalForButtonAtIndex:(NSInteger)index
{
    return self.titleArray[index];
}
-(NSString*)customTabbar:(JSCustomTabbar *)customTabbar titleForButtonAtIndex:(NSInteger)index
{
    return self.titleArray[index];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

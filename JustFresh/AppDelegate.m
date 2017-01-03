//
//  AppDelegate.m
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "AppDelegate.h"
#include "MainViewController.h"
#import "JFPay.h"

// 91b237b1ed
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {//1
    // Override point for customization after application launch.
    
    [[JFBaiduMap shareInstance] configBaiduMapAK];
//    [self setbaiduMobStat];
    [WXApi registerApp:@"wx920fde9f97d60569" withDescription:@"demo 2.0"];
    
    [self systemInit];
    [self setIQKeyboardManager];
   
    MainViewController *viewController = [[MainViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

// 系统全局参数初始化
- (void)systemInit {
    AppDelegateInstance.bmkAddressComponent = [[BMKAddressComponent alloc] init];
    AppDelegateInstance.latitude = 0;
    AppDelegateInstance.longitude = 0;
}
// 设置IQKeyboardManager
- (void)setIQKeyboardManager {
    IQKeyboardManager *manage = [IQKeyboardManager sharedManager];
    manage.enable = YES;
    manage.shouldResignOnTouchOutside = YES; // 点击空白收起键盘
    manage.enableAutoToolbar = NO; // 自带键盘工具条开关
}


- (void)setbaiduMobStat{
//    BaiduMobStat* stat = [BaiduMobStat defaultStat];
//    [stat startWithAppId:@"91b237b1ed"];
//    stat.enableExceptionLog = YES;
//    stat.logSendWifiOnly = YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
//    JFLog(@"applicationWillResignActive");//3
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
//    JFLog(@"applicationDidEnterBackground");//4
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
//    JFLog(@"applicationWillEnterForeground"); //5
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
//    JFLog(@"applicationDidBecomeActive");//2  6
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
//    JFLog(@"applicationWillTerminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [JFPay shareJFPay].callBackURL = url;
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    [JFPay shareJFPay].callBackURL = url;
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    [JFPay shareJFPay].callBackURL = url;
    return YES;
}

@end

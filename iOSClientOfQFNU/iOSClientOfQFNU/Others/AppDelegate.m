//
//  AppDelegate.m
//  QFNU for opooc
//
//  Created by doushuyao on 17/6/5.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "AppDelegate.h"
#import "WZXLaunchViewController.h"
//#import "HomeWebViewController.h"

#import "LGSideMenuController.h"
#import "UIViewController+LGSideMenuController.h"
#import "MainController.h"
#import "QFNULoginController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    MainController *rootViewController = [[MainController alloc]init];
    UITableViewController *leftViewController = [UITableViewController new];
    UITableViewController *rightViewController = [UITableViewController new];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    LGSideMenuController *sideMenuController = [LGSideMenuController sideMenuControllerWithRootViewController:navigationController
                                                                                           leftViewController:leftViewController
                                                                                          rightViewController:rightViewController];
    
    sideMenuController.leftViewWidth = 250.0;
    sideMenuController.leftViewPresentationStyle = LGSideMenuPresentationStyleScaleFromBig;
    
    sideMenuController.rightViewWidth = 100.0;
    sideMenuController.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;
    
    
    _window.backgroundColor = [UIColor whiteColor];

    //隐藏电池
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];

    ///设置启动页
    [WZXLaunchViewController showWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-120) ImageURL:@"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg" advertisingURL:@"http://www.opooc.com" timeSecond:10 hideSkip:YES imageLoadGood:^(UIImage *image, NSString *imageURL) {
        /// 广告加载结束
        NSLog(@"%@ %@",image,imageURL);
        
    } clickImage:^(UIViewController *WZXlaunchVC){
        
        /// 点击广告
        
        //2.在webview中打开
//        HomeWebViewController *VC = [[HomeWebViewController alloc] init];
//        VC.urlStr = @"http://www.opooc.com";
//        VC.AppDelegateSele= -1;
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
//        [WZXlaunchVC presentViewController:nav animated:YES completion:nil];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.opooc.com"]];
        _window.rootViewController = sideMenuController;
        
        
    } theAdEnds:^{
        
        
        //广告展示完成回调,设置window根控制器
        
        _window.rootViewController = sideMenuController;

        
        
    }];
        [_window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

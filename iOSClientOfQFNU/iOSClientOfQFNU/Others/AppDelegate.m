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
#import "AFNetworking.h"
#import "QFInfo.h"
#import "CFWebViewController.h"
#import "LGSideMenuController.h"
#import "UIViewController+LGSideMenuController.h"
#import "MainController.h"
#import "LGSideMainViewController.h"
#import "LeftViewController.h"
#import "QFNULoginController.h"
#import <UMSocialCore/UMSocialCore.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"user:%@",[[QFInfo sharedInstance] getUser]);
    if (![[[QFInfo sharedInstance] getUser]isEqualToString:@""]) {
        
            _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        QFNULoginController *loginview=[[QFNULoginController alloc]init];
//        CFWebViewController *webview=[[CFWebViewController alloc]initWithUrl:[NSURL URLWithString:@"http://www.opooc.com/"]];
        
        MainController *rootViewController = [[MainController alloc]init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
        
        LGSideMainViewController *mainViewController = [LGSideMainViewController new];
        mainViewController.rootViewController = navigationController;
        [mainViewController setupWithType:1];
        _window.backgroundColor = [UIColor whiteColor];
        _window.rootViewController = mainViewController;
        [_window makeKeyAndVisible];
        [[QFInfo sharedInstance]loginqfnu:[[QFInfo sharedInstance] getUser] password:[[QFInfo sharedInstance] getPassword]];
    }else{
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    MainController *rootViewController = [[MainController alloc]init];
//    LeftViewController *leftViewController = [LeftViewController new];
//    UITableViewController *rightViewController = [UITableViewController new];
    
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
//    LGSideMenuController *sideMenuController = [LGSideMenuController sideMenuControllerWithRootViewController:navigationController
//                                                                                           leftViewController:leftViewController
//                                                                                          rightViewController:rightViewController];
    
//    sideMenuController.leftViewWidth = 250.0;
//    sideMenuController.leftViewPresentationStyle = LGSideMenuPresentationStyleScaleFromBig;
//    
//    sideMenuController.rightViewWidth = 100.0;
//    sideMenuController.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;
    QFNULoginController *loginview=[[QFNULoginController alloc]init];
    
    _window.backgroundColor = [UIColor whiteColor];

    //隐藏电池
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];

    ///设置启动页
//    [WZXLaunchViewController showWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-120) ImageURL:@"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg" advertisingURL:@"http://www.opooc.com" timeSecond:10 hideSkip:YES imageLoadGood:^(UIImage *image, NSString *imageURL) {
//        /// 广告加载结束
//        NSLog(@"%@ %@",image,imageURL);
//        
//    } clickImage:^(UIViewController *WZXlaunchVC){
//        
//        /// 点击广告
//        
//        //2.在webview中打开
////        HomeWebViewController *VC = [[HomeWebViewController alloc] init];
////        VC.urlStr = @"http://www.opooc.com";
////        VC.AppDelegateSele= -1;
////        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
////        [WZXlaunchVC presentViewController:nav animated:YES completion:nil];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.opooc.com"]];
//        _window.rootViewController = sideMenuController;
//        
//        
//    } theAdEnds:^{
//        
//        
//        //广告展示完成回调,设置window根控制器
//        
//        _window.rootViewController = sideMenuController;
//
//        
//        
//    }];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.opooc.com"]];
    _window.rootViewController = loginview;
        [_window makeKeyAndVisible];
    }

#pragma maeks Umeng
    
    
    
    
    
    
    
    
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"	597ccda1f5ade42df3002215"];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
        return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx67f5ec33b6887d40" appSecret:@"87ae6ae1b05191db770f90be1b71e368" redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106246723"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3011358161"  appSecret:@"f1a5702a877cbb8dddb6b66b64d6393a" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    /* 钉钉的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];
    
    /* 支付宝的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:nil];
    
    
    /* 设置易信的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_YixinSession appKey:@"yx35664bdff4db42c2b7be1e29390c1a06" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置点点虫（原来往）的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_LaiWangSession appKey:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置领英的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81t5eiem37d2sc"  appSecret:@"7dgUXPLH8kA8WHMV" redirectURL:@"https://api.linkedin.com/v1/people"];
    
    /* 设置Twitter的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
    
    /* 设置Facebook的appKey和UrlString */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"506027402887373"  appSecret:nil redirectURL:nil];
    
    /* 设置Pinterest的appKey */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Pinterest appKey:@"4864546872699668063"  appSecret:nil redirectURL:nil];
    
    /* dropbox的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DropBox appKey:@"k4pn9gdwygpy4av" appSecret:@"td28zkbyb9p49xu" redirectURL:@"https://mobile.umeng.com/social"];
    
    /* vk的appkey */
    [[UMSocialManager defaultManager]  setPlaform:UMSocialPlatformType_VKontakte appKey:@"5786123" appSecret:nil redirectURL:nil];
    
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

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
#define appleid @"1277107501"
//#import "CoreLaunchCool.h"

@interface AppDelegate ()
{
    BOOL *isnotice;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *notstr=[[NSString alloc]init];
        NSData *htmlData=[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:@"https://zsqy.illidan.cn/notice"]];
    if(htmlData){
    NSDictionary * htmlnot = [NSJSONSerialization JSONObjectWithData:htmlData options:0 error:nil];
    NSArray *NotArray=htmlnot[@"data"];
    for(NSDictionary *a in NotArray){
        if ([a[@"title"] isEqualToString:@"notswitch"]) {
            if ([a[@"content"]isEqualToString:@"1"]) {
             isnotice=YES;
            }
            
        }
        if ([a[@"title"] isEqualToString:@"not1"]) {
            notstr=a[@"content"];
        }
    }
        if (isnotice) {
      [self ShowNotice:notstr];
        }
      
    }
            [self shareAppVersionAlert];
  
    NSLog(@"user:%@",[[QFInfo sharedInstance] getUser]);
  //  NSString* imaScUrlStr = [[NSBundle mainBundle]pathForResource:@"Screen" ofType:@"png"];
   // UIImage* imaSc = [UIImage imageNamed:@"Screen.png"];
    [[QFInfo sharedInstance]setCoookie];
    if (![[[QFInfo sharedInstance] getCooke]isEqualToString:@""]) {
        
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
    }else{
        
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    QFNULoginController *loginview=[[QFNULoginController alloc]init];
    _window.backgroundColor = [UIColor whiteColor];
        _window.rootViewController = loginview;
        [_window makeKeyAndVisible];
        
        
    //隐藏电池
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];

//    ///设置启动页
//    [WZXLaunchViewController showWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-120) ImageURL:@"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg" advertisingURL:@"http://www.opooc.com" timeSecond:10 hideSkip:YES imageLoadGood:^(UIImage *image, NSString *imageURL) {
//        /// 广告加载结束
//        NSLog(@"%@ %@",image,imageURL);
//        
//    } clickImage:^(UIViewController *WZXlaunchVC){
//
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.opooc.com"]];
//        _window.rootViewController = loginview;
//        
//        
//    } theAdEnds:^{
//
//        //广告展示完成回调,设置window根控制器
//        
//        _window.rootViewController = loginview;
//
//        
//    }];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.opooc.com"]];

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
//判断是否需要提示更新App
- (void)shareAppVersionAlert {
    if(![self judgeNeedVersionUpdate])  return ;
    //App内info.plist文件里面版本号
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = infoDict[@"CFBundleShortVersionString"];
//    NSString *bundleId   = infoDict[@"CFBundleIdentifier"];
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@", appleid];
    //两种请求appStore最新版本app信息 通过bundleId与appleId判断
    //[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleid=%@", bundleId]
    //[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@", appleid]
    NSURL *urlStr = [NSURL URLWithString:urlString];
    //创建请求体
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlStr];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            //            NSLog(@"connectionError->%@", connectionError.localizedDescription);
            return ;
        }
        NSError *error;
        NSDictionary *resultsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            //            NSLog(@"error->%@", error.localizedDescription);
            return;
        }
        NSArray *sourceArray = resultsDict[@"results"];
        if (sourceArray.count >= 1) {
            //AppStore内最新App的版本号
            NSDictionary *sourceDict = sourceArray[0];
            NSString *newVersion = sourceDict[@"version"];
            if ([self judgeNewVersion:newVersion withOldVersion:appVersion])
            {
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示:\n您的App不是最新版本，更新版本会提高App的稳定性哟" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //                    [alertVc dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertVc addAction:action1];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    //跳转到AppStore，该App下载界面
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sourceDict[@"trackViewUrl"]]];
                }];
                [alertVc addAction:action2];
                [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertVc animated:YES completion:nil];
            }
        }
    }];
}
//每天进行一次版本判断
- (BOOL)judgeNeedVersionUpdate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //获取年-月-日
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSString *currentDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentDate"];
    if ([currentDate isEqualToString:dateString]) {
        return NO;
    }
    [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"currentDate"];
    return YES;
}
//判断当前app版本和AppStore最新app版本大小
- (BOOL)judgeNewVersion:(NSString *)newVersion withOldVersion:(NSString *)oldVersion {
    NSArray *newArray = [newVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSArray *oldArray = [oldVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    for (NSInteger i = 0; i < newArray.count; i ++) {
        if ([newArray[i] integerValue] > [oldArray[i] integerValue]) {
            return YES;
        } else if ([newArray[i] integerValue] < [oldArray[i] integerValue]) {
            return NO;
        } else { }
    }
    return NO;
}

-(void)ShowNotice:(NSString *)content{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"公告" message:content delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
    [alertview show];
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

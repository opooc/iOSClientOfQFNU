//
//  QFInfo.m
//  iOSClientOfQFNU
//
//  Created by lyngame on 2017/6/28.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "QFInfo.h"
#import "TFHpple.h"
#import "AFNetworking.h"
#import "BaseRequest.h"
@implementation QFInfo
@synthesize Username;
@synthesize password;
@synthesize token;

;
/**
 单例方法
 可以调用全程，整个程序生命周期调用一个QFInfo的任何东西
 */
+ (QFInfo *)sharedInstance
{
    static QFInfo *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}
//保存用户名密码
- (void)save:(NSString *)user password:(NSString *)passWord{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    [ud setObject:user forKey:@"username"];
    [ud setObject:passWord forKey:@"password"];
        [ud synchronize];
}
//调用用户名，没有就是空
-(NSString *)getUser{
       NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *us=@"";
    if([ud objectForKey:@"username"]){
        us=[ud objectForKey:@"username"];
    }
    return us;
}
//调用密码，没有就是空
-(NSString *)getPassword{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *ps=@"";
    if([ud objectForKey:@"password"]){
        ps=[ud objectForKey:@"password"];
    }
    return ps;
}
-(void)loginqfnu:(NSString *)username password:(NSString *)password{
    NSString *Lt=[[NSString alloc]init];
    NSString *urlstring=@"http://ids.qfnu.edu.cn/authserver/login?service=http%3A%2F%2F202.194.188.19%2Fcaslogin.jsp";
    NSData *htmlData=[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:urlstring]];
    TFHpple *xpathParser=[[TFHpple alloc]initWithXMLData:htmlData];
    NSArray *dataArray=[xpathParser searchWithXPathQuery:@"//input"];
    for (TFHppleElement *hppleElement in dataArray){
        if ([[hppleElement objectForKey:@"name"] isEqualToString:@"lt"]) {
            NSLog(@"%@",[hppleElement objectForKey:@"value"]);
            Lt=[[NSString alloc]init];
            Lt=[hppleElement objectForKey:@"value"];
        }
        
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSHTTPCookie *cookie = [[cookieJar cookiesForURL:[NSURL URLWithString:@"http://ids.qfnu.edu.cn/authserver/login"]]firstObject];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@=%@", [cookie name], [cookie value]] forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *domainStr = @"http://ids.qfnu.edu.cn/authserver/login?service=http%3A%2F%2Fmy.qfnu.edu.cn%2Flogin.portal";
    [BaseRequest postLoginWithURL:domainStr lt:Lt user:@"2013412546" password:@"221716" callBack:^(NSData *data, NSError *error) {
        NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"true:%@",str);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"link_success" object:nil];
        [self saveCookies];

    }];
}

- (void)saveCookies{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"org.skyfox.cookie"];
    [defaults synchronize];
}
- (void)loadCookies{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"org.skyfox.cookie"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
}
@end

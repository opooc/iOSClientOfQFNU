//
//  QFInfo.m
//  iOSClientOfQFNU
//
//  Created by lyngame on 2017/6/28.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "QFInfo.h"

@implementation QFInfo
@synthesize Username;
@synthesize password;
@synthesize token;

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
@end

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
+ (QFInfo *)sharedInstance
{
    static QFInfo *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}
- (void)save:(NSString *)user password:(NSString *)passWord{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    [ud setObject:user forKey:@"username"];
    [ud setObject:passWord forKey:@"password"];
        [ud synchronize];
}
-(NSString *)getUser{
       NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *us=@"";
    if([ud objectForKey:@"username"]){
        us=[ud objectForKey:@"username"];
    }
    return us;
}
-(NSString *)getPassword{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *ps=@"";
    if([ud objectForKey:@"password"]){
        ps=[ud objectForKey:@"password"];
    }
    return ps;
}
@end

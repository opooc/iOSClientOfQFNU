//
//  QFInfo.h
//  iOSClientOfQFNU
//
//  Created by lyngame on 2017/6/28.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFInfo : NSObject
@property (nonatomic, copy) NSString *Username;  //用户名
@property (nonatomic, copy) NSString *password;  //密码
@property (nonatomic, copy) NSString *token;  //每次登陆获取的秘钥
@property (nonatomic, strong) NSString *Lt;
+ (QFInfo *)sharedInstance;//单例方法
-(void)save:(NSString *)user password:(NSString *)passWord;
-(NSString *)getUser;
-(NSString *)getPassword;
-(void)loginqfnu:(NSString *)username password:(NSString *)password;
-(void)saveCookies;
-(void)loadCookies;
@end

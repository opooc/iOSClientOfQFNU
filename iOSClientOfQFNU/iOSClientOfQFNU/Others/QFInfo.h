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
-(void)save:(NSString *)user password:(NSString *)passWord token:(NSString *)Token;
-(NSString *)getCooke;
-(NSString *)getUser;
-(NSString *)getPassword;
-(NSString *)getToken;
-(void)loginqfnu:(NSString *)username password:(NSString *)password;
#pragma mark 课程表
-(NSDictionary *)getCourse;
-(void)savaCourse:(NSDictionary *)course;

#pragma mark 考勤
-(NSString *)getclassUser;
-(void)classUser:(NSString *)classUser;
#pragma mark cookie
-(void)ReLogin:(NSInteger)retry;
-(void)SaveCookie;
- (void)setCoookie;
@end

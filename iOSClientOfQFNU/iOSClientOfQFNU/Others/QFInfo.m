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
#import "MBProgressHUD.h"
#import "MBProgressHUD+NHAdd.h"
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
- (void)save:(NSString *)user password:(NSString *)passWord token:(NSDictionary *)Token{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:Token forKey:@"token"];
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
//调用cookie，没有就是空
-(NSString *)getCooke{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *iscooke=@"";
    if([ud objectForKey:@"cookie"]){
        iscooke=@"true";
    }
    return iscooke;
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
-(NSDictionary *)getToken{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *tk=nil;
    if([ud objectForKey:@"token"]){
        tk=[ud objectForKey:@"token"];
    }
    return tk;
}
-(void)loginqfnu:(NSString *)username password:(NSString *)password{
    NSLog(@"登录的账号是：%@",username);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 7.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];
    
        NSDictionary* dic = @{@"user_id":username,
                              @"password":password
                              };
        NSString *domainStr = @"https://zsqy.illidan.cn/login";
        [manager POST:domainStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {

        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"接口数据： %@",dic);
            if([[dic objectForKey:@"status"]integerValue]==1){
 
                [[QFInfo sharedInstance]save:username password:password token:[[dic objectForKey:@"data"]objectForKey:@"token"]];
                [QFInfo sharedInstance].token=[[dic objectForKey:@"data"] objectForKey:@"token"];
    


            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error：%@",error);
    UIWindow *keywind=[[UIApplication sharedApplication]keyWindow];

            if (error.code==-1001) {
                [MBProgressHUD showError:@"接口服务器连接超时，有些功能可能无法正常使用" toView:keywind.rootViewController.view];

                [MBProgressHUD hideHUDForView:keywind.rootViewController.view animated:YES];

    
            }else{
                [MBProgressHUD showError:@"接口服务器连接失败，有些功能可能无法正常使用" toView:keywind.rootViewController.view];
                [MBProgressHUD hideHUDForView:keywind.rootViewController.view animated:YES];

            }
    
        }];
}

-(void)ReLogin:(NSInteger)retry{

    if (retry<6) {
        
    
    [MBProgressHUD showLoadToView:kWindow title:[NSString stringWithFormat:@"检测到缓存已失效，正在重新登陆   重试次数%d/5",retry]];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
        NSDictionary* dic=[[NSDictionary alloc]init];
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
                NSLog(@"Lt:%@",Lt);
            }
        }

            dic = @{@"username":[[QFInfo sharedInstance]getUser],
                    @"password":[[QFInfo sharedInstance]getPassword],
                    @"lt":Lt,
                    @"execution":@"e1s1",
                    @"_eventId":@"submit",
                    @"submit":@"%%E7%%99%%BB%%E5%%BD%%95"
                    };
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];//请求
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 7.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager POST:urlstring parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

//            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"小明",@"name",@"111401",@"number", nil];
            
            // 2.创建通知
            
            NSNotification *notification =[NSNotification notificationWithName:@"relogin" object:@"true"];
            // 3.通过 通知中心 发送 通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        
            kHiddenHUD;
            NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
            NSLog(@"str:%@",responses.URL);
            TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSString *isLogin=[NSString stringWithFormat:@"%@",responses.URL];
            if ([isLogin isEqualToString:@"http://ids.qfnu.edu.cn/authserver/login?service=http%3A%2F%2F202.194.188.19%2Fcaslogin.jsp"]) {
                NSLog(@"登陆失败");
                //一开始让我清cookie我是拒绝的，但是学校登陆系统里面的Lt，在登陆失败的时候，网页里获取的Lt会更新，但是我查了下，会更新的居然只有我这边！学校那边没更新！只能清cookie让学校认为我是新人了。
                NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
                for (id obj in _tmpArray) {
                    [cookieJar deleteCookie:obj];
                }
                [MBProgressHUD showError:@"1.用户名或密码错误,2.服务器连接失败" toView:kWindow];
                //            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"1.用户名或密码错误,2.服务器连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                //            [alert show];
                
            }
            if([isLogin isEqualToString:@"http://202.194.188.19/caslogin.jsp"]){
                NSLog(@"登陆成功");
                [[QFInfo sharedInstance] SaveCookie];
           
            }
      
            NSArray *dataArray=[xpathParser searchWithXPathQuery:@"//title"];
            for (TFHppleElement *hppleElement in dataArray){
                NSLog(@"title:%@",hppleElement.text);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            kHiddenHUD;
            //清cookie
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
            for (id obj in _tmpArray) {
                [cookieJar deleteCookie:obj];
            }
            if (error.code==-1001) {
                [MBProgressHUD showError:@"校园服务器连接超时，提示：在访问高峰期会导致此情况" toView:kWindow];
                
            }else{
                [MBProgressHUD showError:@"服务器连接失败" toView:kWindow];
            }
        }];
    }else{
                        [MBProgressHUD showError:@"校园服务器登陆超时，提示：在访问高峰期会导致此情况，请重新登陆" toView:kWindow];
    }
    
    }

//获取课程
-(NSDictionary *)getCourse{
    NSUserDefaults *gcou = [NSUserDefaults standardUserDefaults];
    NSDictionary *cou;
    if([gcou objectForKey:@"course"]){
        cou=[gcou objectForKey:@"course"];
    }
    return cou;
    
}
//保存课程
-(void)savaCourse:(NSDictionary *)course{
    NSLog(@"====================保存课程====================");
    NSUserDefaults *cou = [NSUserDefaults standardUserDefaults];
    
    [cou setObject:course forKey:@"course"];
    [cou synchronize];
}

//获取考勤人员
-(NSString *)getclassUser{
    NSUserDefaults *gcu = [NSUserDefaults standardUserDefaults];
    NSString *cu;
    if([gcu objectForKey:@"classUser"]){
        cu=[gcu objectForKey:@"classUser"];
    }
    return cu;
    
}
//保存考勤人员
-(void)classUser:(NSDictionary *)classUser{
    NSLog(@"====================保存考勤人员====================");
    NSUserDefaults *cu = [NSUserDefaults standardUserDefaults];
    [cu setObject:classUser forKey:@"course"];
    [cu synchronize];
}
-(void)SaveCookie
{
    NSLog(@"====================保存cookie====================");
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *tempCookie in cookies) {
        //打印获得的cookie
        NSLog(@"getCookie: %@", tempCookie);
    }
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    //存储归档后的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject: cookiesData forKey: @"cookie"];
}
- (void)setCoookie
{
    NSLog(@"============再取出保存的cookie重新设置cookie===============");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"cookie"]];
    if (cookies) {
        NSLog(@"有cookie");
        //设置cookie
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (id cookie in cookies) {
            [cookieStorage setCookie:(NSHTTPCookie *)cookie];
        }
    }else{
        NSLog(@"无cookie");
    }
    //打印cookie，检测是否成功设置了cookie
    NSArray *cookiesA = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookiesA) {
        NSLog(@"setCookie: %@", cookie);
    }
    NSLog(@"\n");
}
@end

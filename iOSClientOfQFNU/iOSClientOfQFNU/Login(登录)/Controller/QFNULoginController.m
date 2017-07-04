//
//  QFNULoginController.m
//  QFNU for opooc
//
//  Created by doushuyao on 17/6/5.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "QFNULoginController.h"
#import "HyTransitions.h"
#import "HyLoginButton.h"
#import "BaseRequest.h"
#import "MainController.h"
#import "AFNetworking.h"
#import "AFURLSessionManager.h"
#import "QFInfo.h"
@interface QFNULoginController ()<UIViewControllerTransitioningDelegate>
@property (strong,nonatomic)UISwitch *switchButton;
@property (strong,nonatomic)UITextField *UserName;
@property (strong,nonatomic)UITextField *password;
#define kSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define kSCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kSCREEN_SIZE [UIScreen mainScreen].bounds.size
@end

@implementation QFNULoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createButton];
    [self createTextField];
    
}
-(void)createTextField{
    _UserName=[[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetHeight(self.view.bounds) - (170 + 170), kSCREEN_WIDTH - 100, 40)];
    _UserName.borderStyle=UITextBorderStyleLine;
    [self.view addSubview:_UserName];
    _password=[[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetHeight(self.view.bounds) - (100+ 170), kSCREEN_WIDTH - 100, 40)];
    _password.borderStyle=UITextBorderStyleLine;
    [self.view addSubview:_password];
}
- (void)createButton{
    HyLoginButton *loginButton = [[HyLoginButton alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.bounds) - (40 + 130), kSCREEN_WIDTH - 40, 40)];
    [loginButton setBackgroundColor:[UIColor colorWithRed:1 green:0.f/255.0f blue:128.0f/255.0f alpha:1]];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(FirstViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    _switchButton=[[UISwitch alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-50,kSCREENH_HEIGHT-50,50,100)];
    _switchButton.frame=CGRectMake(50, 50, [UIScreen mainScreen].bounds.size.width - 40, kSCREEN_WIDTH-75);
    [self.view addSubview:self.switchButton];
    UILabel *lb=[[UILabel alloc]init];
    lb.frame=CGRectMake(kSCREEN_WIDTH-250, kSCREENH_HEIGHT-114, 200, 50);
    lb.text=@"打开登录，关闭失败";
    [self.view addSubview:lb];
}
- (void)FirstViewController:(HyLoginButton *)button {
    typeof(self) __weak weak = self;
    if ([self isBlankString:_UserName.text]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([self isBlankString:_password.text]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [_UserName resignFirstResponder];
    [_password resignFirstResponder];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];

    NSDictionary* dic = @{@"user_id":_UserName.text,
                          @"password":_password.text
                          };
    NSString *domainStr = @"https://zsqy.illidan.me/login";
    [manager POST:domainStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic %@",dic);
        if([[dic objectForKey:@"status"]integerValue]==1){
            [[QFInfo sharedInstance]save:_UserName.text password:_password.text];
            [QFInfo sharedInstance].token=[dic objectForKey:@"data"];
            [button succeedAnimationWithCompletion:^{
                    [weak didPresentControllerButtonTouch];
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",task);
        [button failedAnimationWithCompletion:^{

                [weak didPresentControllerButtonTouch];

        }];
    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (_switchButton.on) {
//            //网络正常 或者是密码账号正确跳转动画,目前用switch来模拟
//                    if (weak.switchButton.on) {
//    [weak didPresentControllerButtonTouch];
//                    }
//        } else {
//            //网络错误 或者是密码不正确还原动画
//                        if (weak.switchButton.on) {
//            [weak didPresentControllerButtonTouch];
//                        }
//        }
//    });
}
- (void)didPresentControllerButtonTouch {
    UIViewController *controller = [MainController new];
    controller.transitioningDelegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    navigationController.transitioningDelegate = self;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isPush:true];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isPush:false];
}
/**
 检测NSString是否为空
 */
-(BOOL)isBlankString:(NSString *)string{
    
    if (string == nil)
    {  return YES; }
    if (string == NULL)
    {  return YES;  }
    if ([string isKindOfClass:[NSNull class]])
    {  return YES;  }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {  return YES;
    }
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

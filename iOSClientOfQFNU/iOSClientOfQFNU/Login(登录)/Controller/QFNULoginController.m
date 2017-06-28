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
#import "MainController.h"
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
//    [self createTextField];
    
}
-(void)createTextField{
    _UserName=[[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetHeight(self.view.bounds) - (40 + 170), kSCREEN_WIDTH - 100, 40)];
    [self.view addSubview:_UserName];
    _password=[[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetHeight(self.view.bounds) - (100+ 170), kSCREEN_WIDTH - 100, 40)];
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
    lb.frame=CGRectMake(kSCREEN_WIDTH-250, kSCREENH_HEIGHT-50, 200, 50);
    lb.text=@"打开登录，关闭失败";
    [self.view addSubview:lb];
}
- (void)FirstViewController:(HyLoginButton *)button {
    typeof(self) __weak weak = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_switchButton.on) {
            //网络正常 或者是密码账号正确跳转动画,目前用switch来模拟
            [button succeedAnimationWithCompletion:^{
                if (weak.switchButton.on) {
                    [weak didPresentControllerButtonTouch];
                }
            }];
        } else {
            //网络错误 或者是密码不正确还原动画
            [button failedAnimationWithCompletion:^{
                if (weak.switchButton.on) {
                    [weak didPresentControllerButtonTouch];
                }
            }];
        }
    });
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

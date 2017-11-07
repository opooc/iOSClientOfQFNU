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
#import "YJJTextField.h"
#import "CFWebViewController.h"
#import "YGGravityImageView.h"
#import "AppDelegate.h"
#import "LeftViewController.h"
#import "LGSideMainViewController.h"
#import "MLMWaveWaterView.h"
#import "UIView+MLMBorderPath.h"

@interface QFNULoginController ()<UIViewControllerTransitioningDelegate,UITextFieldDelegate>
{
    MLMWaveWaterView* waterView;
    NSTimer *timer;
    HyLoginButton* Loginbtn;//达威定时器
}
@property (strong,nonatomic)UISwitch *switchButton;
@property (strong,nonatomic)YJJTextField *userNameField;
@property (strong,nonatomic)YJJTextField *passwordField;
#define kSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define kSCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kSCREEN_SIZE [UIScreen mainScreen].bounds.size
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

@end

@implementation QFNULoginController
{ HyLoginButton* loginButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addbg];
    [self createButton];
    [self createTextField];
    
    UIImageView* logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qfnulogo.png"]];
    logo.frame = CGRectMake((SCREEN_W-250.0)*0.5, SCREEN_H/12, 250, 200);
    [self.view addSubview:logo];
    
//    YGGravityImageView *imageView = [[YGGravityImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREENH_HEIGHT)];
//    imageView.image = [UIImage imageNamed:@"login_bg6.png"];
//    
//    [self.view addSubview:imageView];
//    [self.view sendSubviewToBack:imageView];

    [self addNoticeForKeyboard];
}
BOOL getRuntimeClassIsIpad()
{   NSString *model = [[UIDevice currentDevice] model];
    if ([model isEqualToString:@"iPad"])
        
    {
        return TRUE;
    }
    
    return FALSE;
}
-(void)addbg{
    BOOL isiPad = getRuntimeClassIsIpad();
    if (isiPad) {
        UIView* imagev = [[UIView alloc]initWithFrame:CGRectMake(-20, 0, kSCREEN_WIDTH+40, kSCREENH_HEIGHT)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH+40, kSCREENH_HEIGHT)];
        imageView.image = [UIImage imageNamed:@"login_bg6.png"];
        
        [imagev addSubview:imageView];
        [self.view addSubview:imagev];
        
        NSLog(@"ipad..++++++++++");
        
   
        
    } else {
        YGGravityImageView *imageView = [[YGGravityImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREENH_HEIGHT)];
        imageView.image = [UIImage imageNamed:@"login_bg6.png"];
        
        [self.view addSubview:imageView];
        [self.view sendSubviewToBack:imageView];
        [imageView startAnimate];
        NSLog(@"iphone++++++++++");
    }


}
-(void)createTextField{
//    _UserName=[[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetHeight(self.view.bounds) - (170 + 170), kSCREEN_WIDTH - 100, 40)];
//    _UserName.borderStyle=UITextBorderStyleLine;
//    [self.view addSubview:_UserName];
//    _password=[[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetHeight(self.view.bounds) - (100+ 170), kSCREEN_WIDTH - 100, 40)];
//    _password.borderStyle=UITextBorderStyleLine;
//    [self.view addSubview:_password];
     _userNameField = [YJJTextField yjj_textField];
    _userNameField.frame = CGRectMake(0, kSCREENH_HEIGHT - (200 + SCREEN_H/12), self.view.frame.size.width, 80);
    _userNameField.maxLength = 10;
    _userNameField.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.4];
    _userNameField.errorStr = @"学籍号长度不超过10位";
    _userNameField.placeholder = @"请输入用户名";
    _userNameField.historyContentKey = @"userName";
        _userNameField.textField.delegate=self;
        _userNameField.textField.returnKeyType=UIReturnKeyNext;
    _userNameField.textField.tag=1;
     _userNameField.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_userNameField];
    _passwordField = [YJJTextField yjj_textField];
    _passwordField.frame = CGRectMake(0, kSCREENH_HEIGHT - (120+ SCREEN_H/12), self.view.frame.size.width, 80);
    _passwordField.maxLength = 16;
    _passwordField.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.4];
    _passwordField.errorStr = @"密码长度不得超过16位，默认为身份证后六位";
    _passwordField.placeholder = @"请输入密码";
    _passwordField.historyContentKey = @"password";
    _passwordField.leftImageName = @"password_login";
    _passwordField.textField.secureTextEntry=YES;
    _passwordField.showHistoryList = NO;
    _passwordField.textField.tag=2;
    _passwordField.textField.delegate=self;
    _userNameField.textField.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:_passwordField];
}
- (void)createButton{
    loginButton = [[HyLoginButton alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.bounds) - (40 + SCREEN_H/12), kSCREEN_WIDTH - 40, 40)];
    [loginButton setBackgroundColor:[UIColor colorWithRed:1 green:0.f/255.0f blue:128.0f/255.0f alpha:1]];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(FirstViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    _switchButton=[[UISwitch alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-50,kSCREENH_HEIGHT-50,50,100)];
    _switchButton.frame=CGRectMake(50, 50, [UIScreen mainScreen].bounds.size.width - 40, kSCREEN_WIDTH-75);
    [_switchButton setOn:NO];
    _switchButton.hidden=YES;
    [self.view addSubview:self.switchButton];
    UILabel *lb=[[UILabel alloc]init];
    lb.frame=CGRectMake(kSCREEN_WIDTH-250, kSCREENH_HEIGHT-114, 200, 50);
    lb.text=@"打开登录，关闭失败";
//    [self.view addSubview:lb];
}
- (void)FirstViewController:(HyLoginButton *)button {
    
    typeof(self) __weak weak = self;
            if (_switchButton.on) {
                //网络正常 或者是密码账号正确跳转动画,目前用switch来模拟
                        if (weak.switchButton.on) {
        [weak didPresentControllerButtonTouch];
                        }
            } else {
                //网络错误 或者是密码不正确还原动画
                            if (weak.switchButton.on) {
                [weak didPresentControllerButtonTouch];
                            }
            
    if ([self isBlankString:_userNameField.textField.text]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [button failedAnimationWithCompletion:^{
            
            [weak didPresentControllerButtonTouch];
            
        }];
        return;
    }
    if ([self isBlankString:_passwordField.textField.text]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [button failedAnimationWithCompletion:^{
            
            [weak didPresentControllerButtonTouch];
            
        }];
        return;
    }
    [_userNameField resignFirstResponder];

    [_passwordField resignFirstResponder];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];

    NSDictionary* dic = @{@"user_id":_userNameField.textField.text,
                          @"password":_passwordField.textField.text
                          };
    NSString *domainStr = @"https://zsqy.illidan.cn/login";
    [manager POST:domainStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        //添加波纹
        waterView = [[MLMWaveWaterView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 60)/2, SCREEN_H/12+200, 60,60)];
        waterView.progress = uploadProgress.fractionCompleted;
        NSLog(@"%f",uploadProgress.fractionCompleted);
        
        if ([NSThread isMainThread])
        {
            [self.view addSubview:waterView];
            [waterView  setNeedsDisplay];
        }
        else
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                //Update UI in UI thread here
             
                [self.view addSubview:waterView];
                [waterView  setNeedsDisplay];
                
            });
        }
        
        
        CGRect rect = waterView.frame;
        CGRect frame = waterView.bounds;
        frame.size.height = frame.size.width * 9 /10;
        waterView.changeFrame = frame;
        
        waterView.borderPath = [UIView heartPathRect:rect lineWidth:0];
        waterView.border_fillColor = [UIColor colorWithRed:92.0/255 green:137.0/255 blue:68.0/255 alpha:1.0];
        
        
         //添加定时器
        Loginbtn = button;
        // 创建定时器
        NSTimer *timerr = [NSTimer timerWithTimeInterval:8.0 target:self selector:@selector(timeOver) userInfo:nil repeats:NO];
        
        // 将定时器添加到runloop中，否则定时器不会启动
        [[NSRunLoop mainRunLoop] addTimer:timerr forMode:NSRunLoopCommonModes];
        timer = timerr;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[QFInfo sharedInstance]loginqfnu:_userNameField.textField.text password:_passwordField.textField.text];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic %@",dic);
        if([[dic objectForKey:@"status"]integerValue]==1){
//            [[QFInfo sharedInstance]loginqfnu:_userNameField.textField.text password:_passwordField.textField.text];
            [[QFInfo sharedInstance]save:_userNameField.textField.text password:_passwordField.textField.text token:[dic objectForKey:@"data"]];
            [QFInfo sharedInstance].token=[dic objectForKey:@"data"];
            
            [button succeedAnimationWithCompletion:^{
                    [self didPresentControllerButtonTouch];
            }];
            //添加定时器
            [timer invalidate];
           //关闭波纹
            if ([NSThread isMainThread])
            {
                [waterView removeFromSuperview];
                [waterView  setNeedsDisplay];
            }
            else
            {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    //Update UI in UI thread here
                    
                    [waterView removeFromSuperview];
                    [waterView  setNeedsDisplay];
                    
                });
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",task);
        [button failedAnimationWithCompletion:^{
            
                [self didPresentControllerButtonTouch];
        }];
        
        [timer invalidate];
        if ([NSThread isMainThread])
        {
            [waterView removeFromSuperview];
            [waterView  setNeedsDisplay];
        }
        else
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                //Update UI in UI thread here
                
                [waterView removeFromSuperview];
                [waterView  setNeedsDisplay];
                
            });
        }
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];

    }];
            }
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
-(void)timeOver{
    [timer invalidate];
    if ([NSThread isMainThread])
    {
        [waterView removeFromSuperview];
        [waterView  setNeedsDisplay];
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            //Update UI in UI thread here
            
            [waterView removeFromSuperview];
            [waterView  setNeedsDisplay];
            
        });
    [Loginbtn failedAnimationWithCompletion:^{
            
            [self didPresentControllerButtonTouch];
        }];
    }
    [Loginbtn failedAnimationWithCompletion:^{
        
        [self didPresentControllerButtonTouch];
    }];
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接超时，请重试。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];


}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didPresentControllerButtonTouch {
    UIViewController *controller = [MainController new];
    controller.transitioningDelegate = self;
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
//    navigationController.transitioningDelegate = self;
  CFWebViewController *webview=[[CFWebViewController alloc]initWithUrl:[NSURL URLWithString:@"http://www.opooc.com/"]];
    MainController *rootViewController = [[MainController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    LGSideMainViewController *mainViewController = [LGSideMainViewController new];
    mainViewController.rootViewController = navigationController;
    [mainViewController setupWithType:1];
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    window.rootViewController = mainViewController;
    
    [UIView transitionWithView:window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
}
#pragma mark - 键盘通知
- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = (_passwordField.frame.origin.y+_passwordField.frame.size.height+loginButton.frame.size.height+10) - (self.view.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
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
#pragma mark -UITextFieldDelegate
- ( void )textFieldDidBeginEditing:( UITextField*)textField{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag==1){
        [_passwordField becomeFirstResponder];
    }else{
     [self.view endEditing:YES];
    }
    return YES;
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

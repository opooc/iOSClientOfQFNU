//
//  QFNULoginController.m
//  QFNU for opooc
//
//  Created by doushuyao on 17/6/5.
//  Copyright © 2017年 opooc. All rights reserved.
//
#import "TFHpple.h"
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
#import "MBProgressHUD.h"
#import "MBProgressHUD+NHAdd.h"
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
    NSString *iscaptcha;
}
@property (strong,nonatomic)UISwitch *switchButton;
@property (strong,nonatomic)YJJTextField *userNameField;
@property (strong,nonatomic)YJJTextField *passwordField;
@property (strong,nonatomic)YJJTextField *captchaField;
@property (strong,nonatomic)UIImageView *imageview;
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
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREENH_HEIGHT)];
        imageView.image = [UIImage imageNamed:@"login_bg6.png"];
        
        [self.view addSubview:imageView];
        [self.view sendSubviewToBack:imageView];
//        [imageView startAnimate];
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
    _userNameField.frame = CGRectMake(0, kSCREENH_HEIGHT - (205 + SCREEN_H/12), self.view.frame.size.width, 80);
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
    _passwordField.frame = CGRectMake(0, kSCREENH_HEIGHT - (125+ SCREEN_H/12), self.view.frame.size.width, 80);
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
        [self.view addSubview:_passwordField];

    _captchaField = [YJJTextField yjj_textField];
    _captchaField.textField.returnKeyType=UIReturnKeyDone;
    _captchaField.frame = CGRectMake(0, kSCREENH_HEIGHT - (125 + SCREEN_H/12), self.view.frame.size.width/2, 80);
    _captchaField.maxLength = 4;
    _captchaField.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.4];
    _captchaField.errorStr = @"验证码长度不超过4位";
    _captchaField.placeholder = @"请输入验证码";
    _captchaField.historyContentKey = @"userName";
    _captchaField.textField.delegate=self;
    _captchaField.textField.tag=3;
    [self.view addSubview:_captchaField];
    _captchaField.hidden=YES;
  
    _imageview=[[UIImageView alloc]init];
    _imageview.userInteractionEnabled=YES;
    _imageview.frame=CGRectMake(self.view.frame.size.width/2+10, kSCREENH_HEIGHT - (125 + SCREEN_H/12)+10, self.view.frame.size.width/2-20, 60);
    [self.view addSubview:_imageview];
    //首先得拿到照片的路径，也就是下边的string参数，转换为NSData型。
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ids.qfnu.edu.cn/authserver/captcha.html"]];
    //然后就是添加照片语句，记得使用imageWithData:方法，不是imageWithName:。
    UIImage* resultImage = [UIImage imageWithData: imageData];
    _imageview.image=resultImage;
    _imageview.hidden=YES;
    //加入了点击验证码修改验证码的功能给你
    UIGestureRecognizer *touchimage=[[UIGestureRecognizer alloc]initWithTarget:self action:@selector(touchImage:)];
    [_imageview addGestureRecognizer:touchimage];
    

}
//想上线,这个点击验证码修改验证码的功能没用
-(void)touchImage:(UIGestureRecognizer *)gest{
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ids.qfnu.edu.cn/authserver/captcha.html"]];
    
    UIImage* resultImage = [UIImage imageWithData: imageData];
    _imageview.image=resultImage;

}
- (void)createButton{
    loginButton = [[HyLoginButton alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.bounds) - (40 + SCREEN_H/12), kSCREEN_WIDTH - 40, 40)];
    [loginButton setBackgroundColor:[UIColor colorWithRed:0.3 green:200.f/255.0f blue:128.0f/255.0f alpha:0.6]];
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
                            if (weak.switchButton.on) {
                [weak didPresentControllerButtonTouch];
                            }
                
                BOOL *ischeck=FALSE;
                NSDictionary* dic=[[NSDictionary alloc]init];
    if([self checkcaptcha]){
        ischeck=TRUE;
         if ([self isBlankString:_captchaField.textField.text]) {
            [MBProgressHUD showError:@"请输入验证码" toView:self.view];
             [button failedAnimationWithCompletion:^{
                        
                        [weak didPresentControllerButtonTouch];
                        
                    }];
                    return;
    }
                
            }
    if ([self isBlankString:_userNameField.textField.text]) {

        [MBProgressHUD showError:@"用户名不能为空" toView:self.view];
        [button failedAnimationWithCompletion:^{
            
            [weak didPresentControllerButtonTouch];
            
        }];
        return;
    }
    if ([self isBlankString:_passwordField.textField.text]) {
        [MBProgressHUD showError:@"密码不能为空" toView:self.view];
        [button failedAnimationWithCompletion:^{
            
            [weak didPresentControllerButtonTouch];
            
        }];
        return;
    }
    [_userNameField resignFirstResponder];

                [_passwordField resignFirstResponder];
                
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
                if (ischeck) {
                    dic = @{@"username":_userNameField.textField.text,
                            @"password":_passwordField.textField.text,
                            @"lt":Lt,
                            @"captchaResponse":_captchaField.textField.text,
                            @"execution":@"e1s1",
                            @"_eventId":@"submit",
                            @"submit":@"%%E7%%99%%BB%%E5%%BD%%95"
                            };
                }else{
                    dic = @{@"username":_userNameField.textField.text,
                            @"password":_passwordField.textField.text,
                            @"lt":Lt,
                            @"execution":@"e1s1",
                            @"_eventId":@"submit",
                            @"submit":@"%%E7%%99%%BB%%E5%%BD%%95"
                            };
                }
   
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 7.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager POST:urlstring parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
            
            //刷新验证码

                NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ids.qfnu.edu.cn/authserver/captcha.html"]];
                UIImage* resultImage = [UIImage imageWithData: imageData];
                _imageview.image=resultImage;


            [button failedAnimationWithCompletion:^{
                
                [self didPresentControllerButtonTouch];
            }];
                    [MBProgressHUD showError:@"1.用户名或密码错误,2.服务器连接失败" toView:self.view];
//            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"1.用户名或密码错误,2.服务器连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];

        }
        if([isLogin isEqualToString:@"http://202.194.188.19/caslogin.jsp"]){
            NSLog(@"登陆成功");
            [[QFInfo sharedInstance] SaveCookie];
            [button succeedAnimationWithCompletion:^{
                [self didPresentControllerButtonTouch];
            }];
                [self didPresentControllerButtonTouch];
            [[QFInfo sharedInstance]loginqfnu:_userNameField.textField.text password:_passwordField.textField.text];

            

           
            }
        
        
        NSArray *dataArray=[xpathParser searchWithXPathQuery:@"//title"];
        for (TFHppleElement *hppleElement in dataArray){
            
            NSLog(@"title:%@",hppleElement.text);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //清cookie
                    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
                    for (id obj in _tmpArray) {
                        [cookieJar deleteCookie:obj];
                    }
        //刷新验证码
        
            NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ids.qfnu.edu.cn/authserver/captcha.html"]];
            UIImage* resultImage = [UIImage imageWithData: imageData];
            _imageview.image=resultImage;
        
        [button failedAnimationWithCompletion:^{
            
            [self didPresentControllerButtonTouch];
        }];
        if (error.code==-1001) {
                                [MBProgressHUD showError:@"校园服务器连接超时，提示：在访问高峰期会导致此情况" toView:self.view];
//            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"校园服务器连接超时，提示：在访问高峰期会导致此情况" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
            
        }else{
            [MBProgressHUD showError:@"服务器连接失败" toView:self.view];
//            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"服务器连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
        }
    }];
            }
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
                        [MBProgressHUD showError:@"1.用户名或密码错误,2.服务器连接失败" toView:self.view];
//    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接超时，请重试。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];


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
    CGFloat offset = (kSCREENH_HEIGHT - (125+ SCREEN_H/12)+_passwordField.frame.size.height+loginButton.frame.size.height+10) - (self.view.frame.size.height - kbHeight);
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
- ( void )textFieldDidEndEditing:( UITextField *)textField{
    if(textField.tag==1){
        [self checkcaptcha];

        
    }
}
-(BOOL)checkcaptcha{

        NSString *urlstring=[NSString stringWithFormat:@"http://ids.qfnu.edu.cn/authserver/needCaptcha.html?username=%@",_userNameField.textField.text];
        NSData *htmlData=[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:urlstring]];
        iscaptcha=[[NSString alloc]initWithData:htmlData encoding:NSUTF8StringEncoding];
        
    

    NSLog(@"是否需要验证码:%@",iscaptcha);
    CGFloat offset=_captchaField.frame.size.height;
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    if([iscaptcha isEqualToString:@"true\n"]){
        //将视图上移计算好的增加了验证码的偏移
        if(offset > 0) {
            [UIView animateWithDuration:0.3 animations:^{
                self.userNameField.frame = CGRectMake(0.0f, kSCREENH_HEIGHT - (205+ SCREEN_H/12)-offset, self.userNameField.frame.size.width, self.userNameField.frame.size.height);
                self.passwordField.frame = CGRectMake(0.0f, kSCREENH_HEIGHT - (125+ SCREEN_H/12)-offset, self.passwordField.frame.size.width, self.passwordField.frame.size.height);
                //                    显示验证码
                _captchaField.hidden=NO;
                _imageview.hidden=NO;
            }];
            
        }
    return YES;
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

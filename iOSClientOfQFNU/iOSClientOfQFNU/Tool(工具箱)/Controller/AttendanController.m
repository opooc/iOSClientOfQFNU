//
//  AttendanController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao-on 2017/11/8.
//      创业项目（opooc享有软件专利/软件著作权）
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//
//

#import "AttendanController.h"
#import "HMScannerController.h"
#import "QFInfo.h"
//指纹

#import <LocalAuthentication/LocalAuthentication.h>
//未导入OH,下一步换CoreData.
//#import "OHMySQL.h"
@interface AttendanController ()

@end

@implementation AttendanController
{
    UILabel* scanResultLabel;
    UILabel  *descriptionLabel;
    UIButton *validBtn;
    CGFloat labViewh;
    CGFloat saoyisaoh;
    CGFloat zhiwenh;
    UITextField* num;
    BOOL NumOK;
    
    UITextField* token;
    UILabel* duibi;
    UIButton* duibibtn;
    
    NSString* inNum ;
    UIButton* idbtn;
    
    UILabel* numLable;
   // OHMySQLStoreCoordinator *coordinator;
    
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self setId];
    [self setsaoyisaoBtn];
    
    [self setzhiwenView];
    [self settijiao];
    
}
-(void)setId{
    UIView* idView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    labViewh = CGRectGetMaxY(idView.frame);
    idView.backgroundColor = [UIColor cyanColor];
    UILabel* idLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(idView.frame)*0.5, 60, 20)];
    idLabel.text = @"学号:";
    idLabel.textAlignment = NSTextAlignmentLeft;
    idLabel.numberOfLines = 0;
    [idView addSubview:idLabel];
    
    
    
    inNum = [[QFInfo sharedInstance]getclassUser];
    NumOK =[inNum isEqualToString:@""];
    if (NumOK) {
        num = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(idLabel.frame), CGRectGetMaxY(idView.frame)*0.5, 200, 20)];
        numLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(idLabel.frame), CGRectGetMaxY(idView.frame)*0.5, 200, 20)];
        num.placeholder = @"确认后学号永久不可更改";
        [idView addSubview:numLable];
        
        [idView addSubview:num];
        
    } else {
        UILabel* num2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(idLabel.frame), CGRectGetMaxY(idView.frame)*0.5, 200, 20)];
        num2.text = inNum;
        [idView addSubview:num2];
    }
    
    //     num = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(idLabel.frame), CGRectGetMaxY(idView.frame)*0.5, 200, 20)];
    //    num.placeholder = @"输入的学号永久不可更改";
    //    [idView addSubview:num];
    
    
    
    
    idbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    idbtn.frame = CGRectMake(CGRectGetMaxX(num.frame),CGRectGetMaxY(idView.frame)*0.5, 100, 20 );
    [idbtn setTitle:@"确定" forState:UIControlStateNormal];
    idbtn.backgroundColor = [UIColor blueColor];
    idbtn.layer.cornerRadius = 5;
    idbtn.layer.masksToBounds =YES;
    [idbtn addTarget:self action:@selector(idOK) forControlEvents:UIControlEventTouchUpInside];
    [idView addSubview:idbtn];
    [self.view addSubview:idView];
    
    if (!NumOK) {
        idbtn.hidden = YES;
    }
    
}
-(void)idOK{
    
    if ([num.text  isEqual: @""]) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未输入学号,填写请谨慎" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else{
        [[QFInfo sharedInstance]classUser:num.text];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存成功," delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
        idbtn.hidden = YES;
        numLable.text = num.text;
        num.hidden =YES;
    }
    
}


-(void)setsaoyisaoBtn{
    UIView* saoyisaoView = [[UIView alloc]initWithFrame:CGRectMake(0, labViewh+3, SCREEN_WIDTH, 300)];
    saoyisaoh = CGRectGetMaxY(saoyisaoView.frame);
    saoyisaoView.backgroundColor = [UIColor cyanColor];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((SCREEN_WIDTH-150)*0.5, 5, 150, 150);
    
    [btn setTitle:@"666" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"saoyisao"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(saoyisao) forControlEvents:UIControlEventTouchUpInside];
    [saoyisaoView addSubview:btn];
    [self.view addSubview:saoyisaoView];
    //口令
    
    UILabel* tip = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame)+10, SCREEN_WIDTH, 20)];
    tip.text =@"请输入口令,并扫二维码,然后进行口令对比";
    tip.numberOfLines = 0;
    tip.textAlignment = NSTextAlignmentCenter;
    [saoyisaoView addSubview:tip];
    
    UILabel* tokenLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(tip.frame)+10, 60, 20)];
    tokenLabel.text = @"口令:";
    tokenLabel.textAlignment = NSTextAlignmentLeft;
    tokenLabel.numberOfLines = 0;
    [saoyisaoView addSubview:tokenLabel];
    
    
    token = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tokenLabel.frame), CGRectGetMaxY(tip.frame)+10, 200, 20)];
    token.placeholder = @"请输入口令";
    [saoyisaoView addSubview:token];
    //扫描结果
    
    scanResultLabel = [[UILabel alloc]init];
    scanResultLabel.text =@"-3141";
    
    //
    //[saoyisaoView addSubview:scanResultLabel];
    [saoyisaoView addSubview:btn];
    [self.view addSubview:saoyisaoView];
    
    // 结果对比
    
    
    duibi = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, CGRectGetMaxY(tokenLabel.frame)+20, 150, 40)];
    duibi.hidden = YES;
    duibi.text = @"验证通过";
    duibi.layer.cornerRadius = 5;
    duibi.clipsToBounds = YES;
    // descriptionLabel.center = self.view.center;
    duibi.textColor = [UIColor whiteColor];
    duibi.textAlignment = NSTextAlignmentCenter;
    duibi.backgroundColor = [UIColor greenColor];
    [saoyisaoView addSubview:duibi];
    
    
    duibibtn = [UIButton buttonWithType:UIButtonTypeCustom];
    duibibtn.frame = CGRectMake((self.view.frame.size.width-150)/2,  CGRectGetMaxY(tokenLabel.frame)+20, 150, 40);
    duibibtn.backgroundColor = [UIColor orangeColor];
    duibibtn.layer.cornerRadius = 5;
    //validBtn.center = self.view.center;
    [duibibtn setTitle:@"口令验证" forState:UIControlStateNormal];
    [duibibtn addTarget:self action:@selector(tokeisOk) forControlEvents:UIControlEventTouchUpInside];
    [saoyisaoView addSubview:duibibtn];
    
    
    
}
-(void)tokeisOk{
    //    if (descriptionLabel.text = ) {
    //        <#statements#>
    //    }
    if ([scanResultLabel.text isEqualToString:token.text]) {
        duibi.hidden = NO;
        duibibtn.hidden = YES;
    } else {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"口令验证失败或未扫码获取口令" delegate:self cancelButtonTitle:@"继续" otherButtonTitles: nil];
        [alert show];
    }
    
    
    
}

-(void)saoyisao{
    NSString *cardName = @"opooc最帅";
    UIImage *avatar = [UIImage imageNamed:@""];
    
    HMScannerController *scanner = [HMScannerController scannerWithCardName:cardName avatar:avatar completion:^(NSString *stringValue) {
        
        scanResultLabel.text = stringValue;
    }];
    
    [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
    
    [self showDetailViewController:scanner sender:nil];
    
    
}
-(void)setzhiwenView{
    
    UIView* zhiwenView = [[UIView alloc]initWithFrame:CGRectMake(0, saoyisaoh+3, SCREEN_WIDTH, 60)];
    zhiwenh = CGRectGetMaxY(zhiwenView.frame);
    
    zhiwenView.backgroundColor = [UIColor cyanColor];
    descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 10, 150, 40)];
    descriptionLabel.hidden = YES;
    descriptionLabel.text = @"验证通过";
    descriptionLabel.layer.cornerRadius = 5;
    descriptionLabel.clipsToBounds = YES;
    // descriptionLabel.center = self.view.center;
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.backgroundColor = [UIColor greenColor];
    [zhiwenView addSubview:descriptionLabel];
    
    validBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    validBtn.frame = CGRectMake((self.view.frame.size.width-150)/2, 10, 150, 40);
    validBtn.backgroundColor = [UIColor orangeColor];
    validBtn.layer.cornerRadius = 5;
    //validBtn.center = self.view.center;
    [validBtn setTitle:@"验证指纹" forState:UIControlStateNormal];
    [validBtn addTarget:self action:@selector(validTouchID) forControlEvents:UIControlEventTouchUpInside];
    [zhiwenView addSubview:validBtn];
    
    [self.view addSubview:zhiwenView];
    
    
}

-(void)settijiao{
    
    UIView* endView = [[UIView alloc]initWithFrame:CGRectMake(0, zhiwenh+3, SCREEN_WIDTH, SCREEN_HEIGHT-zhiwenh)];
    endView.backgroundColor = [UIColor cyanColor];
    UIButton* endbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endbtn.frame = CGRectMake((SCREEN_WIDTH-150)*0.5,10, 150, 40 );
    [endbtn setTitle:@"提交" forState:UIControlStateNormal];
    endbtn.backgroundColor = [UIColor redColor];
    endbtn.layer.cornerRadius = 5;
    endbtn.layer.masksToBounds =YES;
    [endbtn addTarget:self action:@selector(endprove) forControlEvents:UIControlEventTouchUpInside];
    [endView addSubview:endbtn];
    [self.view addSubview:endView];
    
    if ((![inNum isEqualToString:@""]) &&(validBtn.hidden == YES)&&(duibibtn.hidden = YES) ){
        
        
    }
    
}


-(void)validTouchID{
    
    NSTimer *timerr = [NSTimer timerWithTimeInterval:60.0 target:self selector:@selector(timeOver) userInfo:nil repeats:YES];
    
    // 将定时器添加到runloop中,否则定时器不会启动
    [[NSRunLoop mainRunLoop] addTimer:timerr forMode:NSRunLoopCommonModes];
    timer = timerr;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        //获取上下文
        LAContext *myContext = [[LAContext alloc] init];
        NSError *error = nil;
        
        /*!
         *@abstract 判断设备是否支持指纹识别
         *@param    LAPolicyDeviceOwnerAuthenticationWithBiometrics 指纹验证
         *@return   YES:支持 NO:不支持
         */
        if([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
        {
            /*!
             *@abstract 指纹验证以及回调
             *@param    LAPolicyDeviceOwnerAuthenticationWithBiometrics 指纹验证
             *@param    localizedReason 进行指纹验证时的弹窗的展示内容(该参数不能为nil或者空串,否则会抛出异常)
             *@param    reply:验证后的回调block
             */
            [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                      localizedReason:@"通过Home键验证已有指纹"
                                reply:^(BOOL success, NSError * _Nullable error)
             {
                 if (success)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^
                                    {
                                        descriptionLabel.hidden = NO;
                                        validBtn.hidden = YES;
                                        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在一分钟内完成所有操作,否则需要重新验证指纹" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                        [alert show];
                                        
                                    });
                 }
                 else
                 {
                     validBtn.hidden = NO;
                     descriptionLabel.hidden = YES;
                     __block NSString *message = @"";
                     switch (error.code)
                     {
                         case LAErrorAuthenticationFailed: /// 连续三次指纹识别错误
                         {
                             message = @"授权失败！";
                         }
                             break;
                         case LAErrorUserCancel: /// 在TouchID对话框中点击了取消按钮
                         {
                             message = @"用户取消验证Touch ID！";
                         }
                             break;
                         case LAErrorUserFallback: /// 在TouchID对话框中点击了输入密码按钮
                         {
                             dispatch_async(dispatch_get_main_queue(), ^
                                            {
                                                message = @"用户选择输入密码！";
                                            });
                         }
                             break;
                         case LAErrorSystemCancel: /// TouchID对话框被系统取消,例如按下Home或者电源键
                         {
                             message = @"系统取消授权,如其他应用进入前台,用户按下Home或者电源键！";
                         }
                             break;
                         case LAErrorPasscodeNotSet: /// 已录入指纹但设备未设置密码
                         {
                             message = @"设备未设置密码！";
                         }
                             break;
                         case LAErrorTouchIDNotAvailable: /// TouchID不可用
                         {
                             message = @"Touch ID不可用！";
                         }
                             break;
                         case LAErrorTouchIDNotEnrolled:/// 用户未录入指纹
                         {
                             message = @"用户未录入指纹！";
                         }
                             break;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
                         case LAErrorTouchIDLockout: /// 连续五次指纹识别错误,TouchID功能被锁定,下一次需要输入系统密码
                         {
                             message = @"Touch ID被锁,需要用户输入密码解锁！";
                         }
                             break;
                         case LAErrorAppCancel: /// 如突然来了电话,电话应用进入前台,APP被挂起啦
                         {
                             message = @"用户不能控制情况下APP被挂起！";
                         }
                             break;
                         case LAErrorInvalidContext: /// -10 LAContext传递给这个调用之前已经失效
                         {
                             message = @"LAContext传递给这个调用之前已经失效！";
                         }
                             break;
#endif
                         default:
                         {
                             dispatch_async(dispatch_get_main_queue(), ^
                                            {
                                                message = @"其他情况,切换主线程处理！";
                                            });
                             break;
                         }
                     }
                     
                     dispatch_async(dispatch_get_main_queue(), ^
                                    {
                                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"验证失败！" message:message preferredStyle:UIAlertControllerStyleAlert];
                                        
                                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                                        [alertController addAction:cancelAction];
                                        [self presentViewController:alertController animated:YES completion:nil];
                                    });
                 }
             }];
        }
        else
        {
            NSString *message = @"";
            switch (error.code)
            {
                case LAErrorTouchIDNotEnrolled:  /// 支持指纹并已设置密码,但未录入指纹
                {
                    message = @"用户未录入指纹！";
                    break;
                }
                case LAErrorPasscodeNotSet:      /// 支持指纹但未设置密码,并已录入指纹
                {
                    message = @"设备未设置密码！";
                    break;
                }
                default:
                {
                    message = @"不支持指纹识别1！";  /// 不支持指纹
                    break;
                }
            }
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    
    
}
-(void)timeOver{
    
    [timer invalidate];
    if ([NSThread isMainThread])
    {
        validBtn.hidden = NO;
        descriptionLabel.hidden = YES;
        [validBtn  setNeedsDisplay];
        [descriptionLabel  setNeedsDisplay];
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            //Update UI in UI thread here
            
            validBtn.hidden = NO;
            descriptionLabel.hidden = YES;
            [validBtn  setNeedsDisplay];
            [descriptionLabel  setNeedsDisplay];
            
        });}
    
    
}

-(void)endprove{
    if ((![[[QFInfo sharedInstance]getclassUser] isEqualToString:@""]) &&(validBtn.hidden == YES)&&(duibibtn.hidden = YES) ){
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您已验证通过" delegate:self cancelButtonTitle:@"已签到" otherButtonTitles: nil];
        [alert show];
#pragma mark 未修改updateMysql方法！！！！！！！！！
        
        //[self updateMysql];
        
        
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您未完成所有验证" delegate:self cancelButtonTitle:@"继续验证" otherButtonTitles: nil];
        [alert show];
    }
    
    
}
//-(void)updateMysql{
//    NSString* num = [[QFInfo sharedInstance]getclassUser];
//    NSString* condition = [NSString stringWithFormat:@"number=%@",num];
//    
//    OHMySQLUser *user = [[OHMySQLUser alloc] initWithUserName:@"root"
//                                                     password:@"root"
//                                                   serverName:@"123.206.103.115"
//                                                       dbName:@"irs"
//                                                         port:3306
//                                                       socket:@"etc/mysql.sock"];
//    
//    coordinator = [[OHMySQLStoreCoordinator alloc] initWithUser:user];
//    [coordinator connect];
//    
//    OHMySQLQueryContext *queryContext = [OHMySQLQueryContext new];
//    queryContext.storeCoordinator = coordinator;
//    
//    
//    OHMySQLQueryRequest *query = [OHMySQLQueryRequestFactory UPDATE:@"chuqin" set:@{ @"situation": @"1"} condition:num];
//    NSError *error;
//    [queryContext executeQueryRequest:query error:&error];
//    
//    
//}

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
    //获取键盘高度,在不同设备上,以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset =50 - (self.view.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间,这样可以在视图上移的时候更连贯
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [token resignFirstResponder];
    [num resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    
   // [coordinator disconnect];
}




@end


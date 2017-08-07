//
//  MainController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//
#import "QFNUAboutUsController.h"
#import "QFNUBackController.h"
#import "QFNUCConsultController.h"
#import "QFNUCommunityController.h"
#import "QFNUCourseController.h"
#import "QFNULoginController.h"
#import "QFNUNewController.h"
#import "QFNULookController.h"
#import "QFNUToolController.h"
#import "MeController.h"
#import "CFWebViewController.h"
#import "MainController.h"
#import "MainHeadScrollView.h"
#import "MainButtonModel.h"
#import "MainButtonView.h"
#import "MJExtension.h"
#import "UIViewController+LGSideMenuController.h"
#import "QFInfo.h"
#import <UShareUI/UShareUI.h>
@interface MainController ()
@property (assign, nonatomic) NSUInteger type;
@property (nonatomic,strong) MainHeadScrollView* scrollView;
@property (nonatomic, strong) NSArray* dataArr;

@property(nonatomic,strong)UIView* allMainBtnView;
@end

@implementation MainController

-(NSArray*)dataArr{
    if (_dataArr ==nil) {
        NSString* dataPath = [[NSBundle mainBundle]pathForResource:@"MainButtonData" ofType:@"plist"];
        self.dataArr = [NSArray arrayWithContentsOfFile:dataPath];
        NSMutableArray* tempArray = [NSMutableArray array];
        for (NSDictionary* dic in self.dataArr) {
            MainButtonModel* model = [MainButtonModel btnWihtDict:dic];
            [tempArray addObject:model];
        }
        self.dataArr = tempArray;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
       self.automaticallyAdjustsScrollViewInsets = NO;
    NSString *us=[[QFInfo sharedInstance]getUser];
    NSLog(@"us:%@",us);
    if([QFInfo sharedInstance].token){
        NSString *str=[QFInfo sharedInstance].token;
        NSLog(@"str:%@",str);
    }
    for (MainButtonModel* btnView in self.dataArr) {
        NSLog(@"%@",btnView.name);
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setMainHeadScrollView];
    [self setButtonView];

//        self.navigationController.navigationBar.translucent=NO;
    self.edgesForExtendedLayout=UIRectEdgeNone;

    UIImage *menu=[UIImage imageNamed:@"menu"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:menu
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showLeftView)];


}

- (void)showLeftView {
      [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

-(void)setMainHeadScrollView{
    self.scrollView = [[MainHeadScrollView alloc]initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, 200) ImagesCount:5];
    //点击图片的回调＃＃＃＃＃＃＃＃＃＃
    [self.scrollView tapImageViewBlock:^(NSInteger tag) {
        NSLog(@"点击图片Block回调  %zd",tag);
        
    }];
    [self.view addSubview:self.scrollView];
}


-(void)setButtonView{
    CGFloat Bwidth = self.view.frame.size.width;
    CGFloat Bheight = self.view.frame.size.height+64+32;
    NSLog(@"%f,%f",Bheight,Bwidth);
    UIView* allMainBtnView = [[UIView alloc]initWithFrame:CGRectMake(0,Bheight*0.5-64-32-20,Bwidth,Bheight*0.5)];
    
    _allMainBtnView = allMainBtnView;
 //_allMainBtnView.backgroundColor = [UIColor brownColor];
    NSInteger allCols = 4;
    
    // 2.商品的宽度 和 高度
    CGFloat width = 80;
    CGFloat height = 80;
    // 3.求出水平间距 和 垂直间距
    CGFloat allMainBtnviewWidth = self.allMainBtnView.frame.size.width;
    CGFloat allMainBtnviewHeight = self.allMainBtnView.frame.size.height;
    CGFloat hMargin = (allMainBtnviewWidth - allCols * width) / (allCols -1);
    CGFloat vMargin = (allMainBtnviewHeight-32 - 4*height) / 1;
    for (int i=0;i<12;i++) {
    // 4. 设置索引
    NSInteger index = self.allMainBtnView.subviews.count;
    
    // 5.求出x值
    CGFloat x = (hMargin + width) * (index % allCols);
    CGFloat y = (vMargin + height) * (index / allCols);
    
    /***********************.创建一个按钮*****************************/
        MainButtonView *btnView = [[MainButtonView alloc] initWithModel:self.dataArr[index]];
        
        /*****   根据按钮的编号 添加弹出控制器*/
        if (index== 0) {
            [btnView.btn addTarget:self action:@selector(meVc) forControlEvents:UIControlEventTouchUpInside];
        }
        
      else if (index ==1) {
           [btnView.btn addTarget:self action:@selector(loginVc) forControlEvents:UIControlEventTouchUpInside];
        }
      else if (index ==2) {
          [btnView.btn addTarget:self action:@selector(aboutUs) forControlEvents:UIControlEventTouchUpInside];
      }
      else if (index ==3) {
          [btnView.btn addTarget:self action:@selector(webviewtext) forControlEvents:UIControlEventTouchUpInside];
      }
      else if (index ==4) {
          [btnView.btn addTarget:self action:@selector(UshareUI) forControlEvents:UIControlEventTouchUpInside];
      }
        
      else if (index ==5) {
          [btnView.btn addTarget:self action:@selector(course) forControlEvents:UIControlEventTouchUpInside];
      }
      else if (index ==7) {
          [btnView.btn addTarget:self action:@selector(feedback) forControlEvents:UIControlEventTouchUpInside];
      }
        
        btnView.frame = CGRectMake(x, y, width, height);
        NSLog(@"dataArrrrrrr:%@",_dataArr[index]);
        
       // btnView.backgroundColor = [UIColor blueColor];
        [self.allMainBtnView addSubview:btnView];
    
    }
    
    [self.view addSubview:_allMainBtnView];

}
-(void)feedback{

    QFNUBackController* back = [[QFNUBackController alloc]init];
    [self.navigationController pushViewController:back animated:YES];

}
-(void)UshareUI{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Sms)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
       
        if(platformType == UMSocialPlatformType_Sina){
            
            [self shareTextToPlatformType:platformType];
        }
        else{
            
        [self shareWebPageToPlatformType:platformType];}
        
    }];

}



-(void)webviewtext{
    CFWebViewController *webview=[[CFWebViewController alloc]initWithUrl:[NSURL URLWithString:@"http://202.194.188.19/gradeLnAllAction?type=In&oper=qb"]];
    [self.navigationController pushViewController:webview animated:YES];
}
-(void)meVc{

    MeController* me = [[MeController alloc]init];
    [self.navigationController pushViewController:me animated:YES];
}
-(void)loginVc{
    QFNULoginController* loginVc = [[QFNULoginController alloc]init];
    [self.navigationController pushViewController:loginVc animated:YES];
}
-(void)aboutUs{
    QFNUAboutUsController* aboutUs = [[QFNUAboutUsController alloc]init];
    [self.navigationController pushViewController:aboutUs animated:YES];
}
-(void)course{
    QFNUCourseController* course =[[QFNUCourseController alloc]init];
    [self.navigationController pushViewController:course animated:YES];


}
- (void)leftViewWillLayoutSubviewsWithSize:(CGSize)size {
    [super leftViewWillLayoutSubviewsWithSize:size];
    
    if (!self.isLeftViewStatusBarHidden) {
        self.leftView.frame = CGRectMake(0.0, 20.0, size.width, size.height-20.0);
    }
}

- (void)rightViewWillLayoutSubviewsWithSize:(CGSize)size {
    [super rightViewWillLayoutSubviewsWithSize:size];
    
    if (!self.isRightViewStatusBarHidden ||
        (self.rightViewAlwaysVisibleOptions & LGSideMenuAlwaysVisibleOnPadLandscape &&
         UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad &&
         UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation))) {
            self.rightView.frame = CGRectMake(0.0, 20.0, size.width, size.height-20.0);
        }
}

- (BOOL)isLeftViewStatusBarHidden {
    if (self.type == 8) {
        return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    }
    
    return super.isLeftViewStatusBarHidden;
}

- (BOOL)isRightViewStatusBarHidden {
    if (self.type == 8) {
        return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    }
    
    return super.isRightViewStatusBarHidden;
}


- (void)dealloc {
    NSLog(@"MainViewController deallocated");
}


- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"曲园教务";
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"曲园教务" descr:@"曲园教务App是由曲园团队开发，为曲师大学生开发的产品，志于帮助同学们更加便捷的体验校园生活。。" thumImage:[UIImage imageNamed:@"icon-72"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://qfnu.opooc.com";
    //分享消息对象设置分享内容对象
    
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

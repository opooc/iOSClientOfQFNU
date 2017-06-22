//
//  CFNavaigationViewWeb.m
//  iOSClientOfQFNU
//
//  Created by chufeng on 2017/6/22.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "CFNavaigationViewWeb.h"
#import "CFWebViewController.h"
@interface CFNavaigationViewWeb ()
/**
 *  由于 popViewController 会触发 shouldPopItems，因此用该布尔值记录是否应该正确 popItems
 */
@property BOOL shouldPopItemAfterPopVC;
@end

@implementation CFNavaigationViewWeb

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav.jpeg"]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    
    self.shouldPopItemAfterPopVC = NO;
}



-(UIViewController*)popViewControllerAnimated:(BOOL)animated{
    self.shouldPopItemAfterPopVC = YES;
    return [super popViewControllerAnimated:animated];
}

-(NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.shouldPopItemAfterPopVC = YES;
    return [super popToViewController:viewController animated:animated];
}

-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    self.shouldPopItemAfterPopVC = YES;
    return [super popToRootViewControllerAnimated:animated];
}
-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    NSLog(@"------%d",self.shouldPopItemAfterPopVC);
    //! 如果应该pop，说明是在 popViewController 之后，应该直接 popItems
    if (self.shouldPopItemAfterPopVC) {
        self.shouldPopItemAfterPopVC = NO;
        return YES;
    }
    
    //! 如果不应该 pop，说明是点击了导航栏的返回，这时候则要做出判断区分是不是在 webview 中
    if ([self.topViewController isKindOfClass:[CFWebViewController class]]) {
        CFWebViewController* webVC = (CFWebViewController*)self.viewControllers.lastObject;
        if (webVC.webView.canGoBack) {
            [webVC.webView goBack];
            
            self.shouldPopItemAfterPopVC = NO;
            [[self.navigationBar subviews] lastObject].alpha = 1;
            return NO;
        }else{
            [self popViewControllerAnimated:YES];
            return NO;
        }
    }else{
        [self popViewControllerAnimated:YES];
        return NO;
    }
}

@end

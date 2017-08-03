//
//  LGSideMainViewController.m
//  iOSClientOfQFNU
//
//  Created by lyngame on 2017/8/3.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "LGSideMainViewController.h"
#import "LeftViewController.h"

@interface LGSideMainViewController ()
@property (assign, nonatomic) NSUInteger type;
@end

@implementation LGSideMainViewController
- (void)setupWithType:(NSUInteger)type {
    self.type = type;
    
    // -----
    

        self.leftViewController = [LeftViewController new];
//        self.rightViewController = [RightViewController new];
    
        self.leftViewWidth = 250.0;
        self.leftViewBackgroundImage = [UIImage imageNamed:@"imageLeft"];
        self.leftViewBackgroundColor = [UIColor colorWithRed:0.5 green:0.65 blue:0.5 alpha:0.95];
        self.rootViewCoverColorForLeftView = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.05];
        
        
        
//        self.rightViewWidth = 100.0;
//        self.rightViewBackgroundImage = [UIImage imageNamed:@"imageRight"];
//        self.rightViewBackgroundColor = [UIColor colorWithRed:0.65 green:0.5 blue:0.65 alpha:0.95];
//        self.rootViewCoverColorForRightView = [UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:0.05];
    
    
    // -----
    
    UIColor *greenCoverColor = [UIColor colorWithRed:0.0 green:0.1 blue:0.0 alpha:0.3];
    UIColor *purpleCoverColor = [UIColor colorWithRed:0.1 green:0.0 blue:0.1 alpha:0.3];
    UIBlurEffectStyle regularStyle;
    
    if (UIDevice.currentDevice.systemVersion.floatValue >= 10.0) {
        regularStyle = UIBlurEffectStyleRegular;
    }
    else {
        regularStyle = UIBlurEffectStyleLight;
    }

    self.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

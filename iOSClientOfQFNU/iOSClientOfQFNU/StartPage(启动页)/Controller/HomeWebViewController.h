//
//  HomeWebViewController.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WebBack)();

@interface HomeWebViewController : UIViewController

@property (nonatomic,copy)NSString *urlStr;

@property (nonatomic,assign)int AppDelegateSele;

@property (nonatomic,copy) WebBack WebBack;

@end

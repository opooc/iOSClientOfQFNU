//
//  CFWebViewController.h
//  iOSClientOfQFNU
//
//  Created by chufeng on 2017/6/22.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFWebViewController : UIViewController
/**
 *  你的网址
 */
@property (nonatomic)NSURL* url;

/**
 *  我的网页视图
 */
@property (nonatomic)UIWebView* webView;

/**
 *  进度条颜色
 */
@property (nonatomic)UIColor* progressViewColor;

/**
 *  炫酷的载入方法
 */
-(instancetype)initWithUrl:(NSURL*)url;


-(void)reloadWebView;

//图书馆菜单
-(void)loadLibraryMenu;

@end

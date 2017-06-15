//
//  HomeWebViewController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "HomeWebViewController.h"
#import <WebKit/WKWebView.h>

@interface HomeWebViewController ()

@end

@implementation HomeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self HomeWebView];
}

- (void)HomeWebView
{
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:webView];
    
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];

    
    if(self.AppDelegateSele == -1)
    {
          self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    
}

- (void)back
{
    
    if(self.WebBack){
        
        self.WebBack();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSString *)urlStr
{
    if(_urlStr == nil)
    {
        _urlStr = [NSString string];
    }
    return _urlStr;
}

@end

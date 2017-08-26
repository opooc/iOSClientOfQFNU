//
//  xiaoliController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/8/26.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "xiaoliController.h"

@interface xiaoliController ()

@end

@implementation xiaoliController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)load:(NSString*)urlstr{
    UIWebView* xiaoli = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H)];
  
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [xiaoli loadRequest:request];
    [self.view addSubview:xiaoli];
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

//
//  QFNUAboutUsController.m
//  QFNU for opooc
//
//  Created by doushuyao on 17/6/5.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "QFNUAboutUsController.h"
#import "aboutUsView.h"

@interface QFNUAboutUsController ()

@end

@implementation QFNUAboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    AboutUsView* abUsV = [AboutUsView aboutUsView];
    self.view.frame = [[UIScreen mainScreen]bounds];
    abUsV.frame = self.view.bounds;
    self.view = abUsV;
    
    self.navigationItem.title = @"关于";
    UIColor *greyColor        = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    self.view.backgroundColor = greyColor;
    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    
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

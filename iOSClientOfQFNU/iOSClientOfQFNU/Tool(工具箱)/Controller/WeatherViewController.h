//
//  weatherViewController.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/8/23.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeatherViewController : UIViewController

@property(nonatomic,strong)UITextField* area;
@property(nonatomic,strong)UILabel* week;
@property(nonatomic,strong)UILabel* weather;
@property(nonatomic,strong)UILabel* winddirect;
@property(nonatomic,strong)UILabel* temphigh;
@property(nonatomic,strong)UILabel* templow;
@property(nonatomic,strong)UILabel* temp;
@property(nonatomic,strong)UILabel* sport;

@end

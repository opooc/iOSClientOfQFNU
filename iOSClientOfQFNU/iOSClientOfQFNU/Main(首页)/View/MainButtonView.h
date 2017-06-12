//
//  MainButtonView.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainButtonModel;

@interface MainButtonView : UIView

@property(nonatomic,strong)MainButtonModel* btnmodel;
@property(nonatomic,weak)UIButton*  btn;


-(instancetype)initWithModel:(MainButtonModel*)btnmodel;
+(instancetype)modelWithModel:(MainButtonModel*)btnmodel;

@end

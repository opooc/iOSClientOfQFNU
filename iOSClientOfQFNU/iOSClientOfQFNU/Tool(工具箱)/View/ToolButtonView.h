//
//  ToolButtonView.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/8/22.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToolModel;

@interface ToolButtonView : UIView

@property(nonatomic,strong)ToolModel* btnmodel;
@property(nonatomic,weak)UIButton*  btn;
@property(nonatomic,weak)UILabel* label;


-(instancetype)initWithModel:(ToolModel*)btnmodel;
+(instancetype)modelWithModel:(ToolModel*)btnmodel;

@end

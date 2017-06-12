//
//  headBtn.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/12.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "headBtn.h"

@implementation headBtn


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self initUI];
    
    return self;
}
/**
 *  初始化UI
 */
-(void)initUI{
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = true;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
}

@end

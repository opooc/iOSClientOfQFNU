//
//  ToolButtonView.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/8/22.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "ToolButtonView.h"
#import "ToolModel.h"

@interface ToolButtonView()

@end


@implementation ToolButtonView


- (instancetype)init{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}


-(instancetype)initWithModel:(ToolModel*)btnmodel{
    
    if (self = [super init]) {
        
        [self setUp];
        self.btnmodel = btnmodel;
        
    }
    return self;
}
+(instancetype)modelWithModel:(ToolModel *)btnmodel{
    
    return [[self alloc]initWithModel:btnmodel];
}

-(void)setUp{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    btn.layer.cornerRadius =30;
    //btn.layer.masksToBounds = true;
    
    
    [self addSubview:btn];
    _btn = btn;
    
    UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 20, 20)];
    // lable.backgroundColor = [UIColor yellowColor];
    // lable.textColor = [UIColor greenColor];
    [self addSubview:lable];
    _label = lable;
    
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    //CGFloat height = self.frame.size.height;
    
    self.btn.frame = CGRectMake(0, 0, width, width);
    self.btn.imageView.frame = self.btn.frame;
    
    
    self.label.frame = CGRectMake(0, width, width, 20);
    self.label.textAlignment = NSTextAlignmentCenter;
    
    
}

-(void)setBtnmodel:(ToolModel *)btnmodel{
    
    _btnmodel = btnmodel;
   // NSLog(@"%@-------",_btnmodel.icon);
    
    [self.btn setImage:[UIImage imageNamed:_btnmodel.icon] forState:UIControlStateNormal];
    _label.text = _btnmodel.name;
    
}




@end

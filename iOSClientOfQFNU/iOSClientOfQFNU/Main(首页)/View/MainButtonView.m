//
//  MainButtonView.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "MainButtonView.h"
#import "MainButtonModel.h"

@interface MainButtonView()


@property(nonatomic,weak)UILabel* label;

@end

@implementation MainButtonView

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


-(instancetype)initWithModel:(MainButtonModel*)btnmodel{

    if (self = [super init]) {
        
        [self setUp];
        self.btnmodel = btnmodel;
        
    }
    return self;
}
+(instancetype)modelWithModel:(MainButtonModel *)btnmodel{

    return [[self alloc]initWithModel:btnmodel];
}

-(void)setUp{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
   // btn.backgroundColor = [UIColor greenColor];
   // btn.imageView.backgroundColor = [UIColor whiteColor];
    btn.layer.cornerRadius = 25;
    btn.layer.masksToBounds = true;
    

    [self addSubview:btn];
    _btn = btn;
    
    UILabel* lable = [[UILabel alloc]init];
   // lable.backgroundColor = [UIColor yellowColor];
   // lable.textColor = [UIColor greenColor];
    [self addSubview:lable];
    _label = lable;


}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.btn.frame = CGRectMake(0, 0, width, width);
    self.btn.imageView.frame = self.btn.frame;

    
    self.label.frame = CGRectMake(0, width, width, 20);
    self.label.textAlignment = NSTextAlignmentCenter;


}

-(void)setBtnmodel:(MainButtonModel *)btnmodel{

    _btnmodel = btnmodel;
    NSLog(@"%@-------",_btnmodel.icon);
    
    [self.btn setImage:[UIImage imageNamed:_btnmodel.icon] forState:UIControlStateNormal];
    self.label.text = _btnmodel.name;
    self.label.font = [UIFont systemFontOfSize:12];
    

}




@end

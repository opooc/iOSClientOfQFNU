//
//  YGGravityImageView.m
//  zhonggantest
//
//  Created by zhangkaifeng on 16/6/23.
//  Copyright © 2016年 张楷枫. All rights reserved.
//

#import "YGGravityImageView.h"
#import "YGGravity.h"

#define SPEED 50

@implementation YGGravityImageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configUI];
}
-(void)configUI
{
    _myImageView = [[UIImageView alloc]init];
    [self addSubview:_myImageView];
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    _myImageView.image = image;
    [_myImageView sizeToFit];
    _myImageView.frame = CGRectMake(0, 0, self.frame.size.height *(_myImageView.frame.size.width / _myImageView.frame.size.height), self.frame.size.height);
    _myImageView.center = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
}

-(void)startAnimate
{
    float scrollSpeed = (_myImageView.frame.size.width - self.frame.size.width)/2/SPEED;
    [YGGravity sharedGravity].timeInterval = 0.01;
    
    [[YGGravity sharedGravity]startDeviceMotionUpdatesBlock:^(float x, float y, float z) {
        
        [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
            
            if (_myImageView.frame.origin.x <=0 && _myImageView.frame.origin.x >= self.frame.size.width - _myImageView.frame.size.width)
            {
                float invertedYRotationRate = y * -1.0;
                
                float interpretedXOffset = _myImageView.frame.origin.x + invertedYRotationRate * (_myImageView.frame.size.width/[UIScreen mainScreen].bounds.size.width) * scrollSpeed + _myImageView.frame.size.width/2;
                
                _myImageView.center = CGPointMake(interpretedXOffset, _myImageView.center.y);
            }
            
            if (_myImageView.frame.origin.x >0)
            {
                _myImageView.frame = CGRectMake(0, _myImageView.frame.origin.y, _myImageView.frame.size.width, _myImageView.frame.size.height);
            }
            if (_myImageView.frame.origin.x < self.frame.size.width - _myImageView.frame.size.width)
            {
                _myImageView.frame = CGRectMake(self.frame.size.width - _myImageView.frame.size.width, _myImageView.frame.origin.y, _myImageView.frame.size.width, _myImageView.frame.size.height);
            }
        } completion:nil];
        
        
    }];
}

-(void)stopAnimate
{
    [[YGGravity sharedGravity] stop];
}

@end

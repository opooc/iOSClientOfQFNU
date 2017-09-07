//
//  WaveWaterView.m
//  WaveWaterProgress
//
//  Created by my on 2016/11/9.
//  Copyright © 2016年 my. All rights reserved.
//

#import "MLMWaveWaterView.h"

@interface MLMWaveWaterView ()
{
    CGFloat _wave_offsety;//根据进度计算(波峰所在位置的y坐标)
    CGFloat _offsety_scale;//上升的速度
    
    CGFloat _wave_move_width;//移动的距离，配合速率设置
    
    CGFloat _wave_offsetx;//偏移,animation
    
    CADisplayLink *_waveDisplaylink;
    
}

@end

@implementation MLMWaveWaterView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    
    return self;
}

#pragma mark - initView
- (void)initView {
    
    _wave_Amplitude = self.frame.size.height/20;
    _wave_Cycle = 2*M_PI/(self.frame.size.width * .9);
    
    
    _wave_h_distance = 2*M_PI/_wave_Cycle * .65;
    _wave_v_distance = _wave_Amplitude * .2;

    _wave_move_width = 0.5;
    
    _wave_scale = 0.5;
    
    _offsety_scale = 0.01;
    
    _topColor = [UIColor colorWithRed:79/255.0 green:240/255.0 blue:255/255.0 alpha:1];
    _bottomColor = [UIColor colorWithRed:79/255.0 green:240/255.0 blue:255/255.0 alpha:.3];
    
    _progress_animation = YES;
    _wave_offsety = (1-_progress) * (self.frame.size.height + 2* _wave_Amplitude);
    [self startWave];
}


#pragma mark - drawRect
- (void)drawRect:(CGRect)rect {
    if (_borderPath) {
        if (_border_fillColor) {
            [_border_fillColor setFill];
            [_borderPath fill];
        }
        
        if (_border_strokeColor) {
            [_border_strokeColor setStroke];
            [_borderPath stroke];
        }
        
        [_borderPath addClip];
    }
    [self drawWaveColor:_topColor offsetx:0 offsety:0];
    [self drawWaveColor:_bottomColor offsetx:_wave_h_distance offsety:_wave_v_distance];

}

#pragma mark - draw wave
- (void)drawWaveColor:(UIColor *)color offsetx:(CGFloat)offsetx offsety:(CGFloat)offsety {
    
    //波浪动画，所以进度的实际操作范围是，多加上两个振幅的高度,到达设置进度的位置y坐标
    CGFloat end_offY = (1-_progress) * (self.frame.size.height + 2* _wave_Amplitude);
    if (_progress_animation) {
        if (_wave_offsety != end_offY) {
            if (end_offY < _wave_offsety) {//上升
                _wave_offsety = MAX(_wave_offsety-=(_wave_offsety - end_offY)*_offsety_scale, end_offY);
            } else {
                _wave_offsety = MIN(_wave_offsety+=(end_offY-_wave_offsety)*_offsety_scale, end_offY);
            }
        }
    } else {
        _wave_offsety = end_offY;
    }
    
    UIBezierPath *wave = [UIBezierPath bezierPath];
    for (float next_x= 0.f; next_x <= self.frame.size.width; next_x ++) {
        //正弦函数
        CGFloat next_y = _wave_Amplitude * sin(_wave_Cycle*next_x + _wave_offsetx + offsetx/self.bounds.size.width*2*M_PI) + _wave_offsety + offsety;
        if (next_x == 0) {
            [wave moveToPoint:CGPointMake(next_x, next_y - _wave_Amplitude)];
        } else {
            [wave addLineToPoint:CGPointMake(next_x, next_y - _wave_Amplitude)];
        }
    }
    [wave addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [wave addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [color set];
    [wave fill];
}

#pragma mark - animation
- (void)changeoff {
    _wave_offsetx += _wave_move_width*_wave_scale;
    [self setNeedsDisplay];
}

#pragma mark - reStart
- (void)startWave {
    
    if (!_waveDisplaylink) {
        _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeoff)];
        [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)dealloc {
    if (_waveDisplaylink) {
        [_waveDisplaylink invalidate];
        _waveDisplaylink = nil;
    }
    
}

@end

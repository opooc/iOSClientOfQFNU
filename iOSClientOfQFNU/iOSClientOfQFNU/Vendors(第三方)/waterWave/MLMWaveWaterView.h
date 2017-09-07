//
//  WaveWaterView.h
//  WaveWaterProgress
//
//  Created by my on 2016/11/9.
//  Copyright © 2016年 my. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLMWaveWaterView.h"

typedef enum {
    WaveDirectionLeft,
    WaveDirectionRight,
    WaveDirectionTop,
    WaveDirectionBottom
} WaveDirection;


@interface MLMWaveWaterView : UIView

///边界path，水波的容器
@property (nonatomic, strong) UIBezierPath *borderPath;
//容器填充色
@property (nonatomic, strong) UIColor *border_fillColor;
//容器描边色
@property (nonatomic, strong) UIColor *border_strokeColor;

@property (nonatomic, assign) WaveDirection *waveDirection;

///前方波纹颜色
@property (nonatomic, strong) UIColor *topColor;
///后方波纹颜色
@property (nonatomic, strong) UIColor *bottomColor;

//y = asin(wx+φ) + k
///进度,计算k
@property (nonatomic, assign) CGFloat progress;
///振幅，a
@property (nonatomic, assign) CGFloat wave_Amplitude;
///周期，w
@property (nonatomic, assign) CGFloat wave_Cycle;
///两个波水平之间偏移
@property (nonatomic, assign) CGFloat wave_h_distance;
///两个波竖直之间偏移
@property (nonatomic, assign) CGFloat wave_v_distance;

///水波速率
@property (nonatomic, assign) CGFloat wave_scale;
///progress速率
@property (nonatomic, assign) CGFloat progress_scale;

///是否需要进度变化的动画，默认YES
@property (nonatomic, assign) BOOL progress_animation;

///对于不规则图形，进度变化相对于自身的frame
@property (nonatomic) CGRect changeFrame;

@end

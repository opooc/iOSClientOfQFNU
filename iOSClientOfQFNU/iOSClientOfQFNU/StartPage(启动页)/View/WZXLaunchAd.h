//
//  WZXLaunchAd.h
//  MyHome
//
//  Created by DHSoft on 16/10/11.
//  Copyright © 2016年 DHSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LaunchAdClick)();

typedef void(^LaunchAdCallback)(UIImage *image, NSString *ImageURL);
typedef void (^EndPlays)();

@interface WZXLaunchAd : UIView

@property (nonatomic,assign) BOOL isClick;

@property (nonatomic,copy) dispatch_source_t timer;

@property (nonatomic,copy) dispatch_source_t noDataTimer;

/// 广告显示几秒钟
@property (nonatomic,assign) NSInteger TimeInteger;

/// 广告图
@property (nonatomic, strong) UIImageView *adImageView;

/// 广告图的frame
@property (nonatomic, assign) CGRect adImageFrame;

/// 点击广告图
@property (nonatomic, copy) LaunchAdClick ImageClick;

/// 是否显示跳过按钮
@property (nonatomic, assign) BOOL hideSkip;

/// 广告加载完
@property (nonatomic, copy) LaunchAdCallback launchAdCallback;

/// 广告播放结束
@property (nonatomic, copy) EndPlays endPlays;

/// 是否点击广告
@property (nonatomic, assign) BOOL ClickAds;


/**
 *  WZXLaunchAd
 *
 *  @param frame            广告图片的位置
 *  @param imageURL         加载广告的URL 可以是图片 也可以是GIF
 *  @param timeSecond       广告的时长
 *  @param hideSkip         是否隐藏“跳过按钮” YES隐藏  NO显示
 *  @param LaunchAdCallback 广告图片加载完成 回调
 *  @param ImageClick       点击广告 回调
 *  @param endPlays         广告播放结束 回调
 *
 *  @return WZXLaunchAd
 */
+ (instancetype)initImageWithframe:(CGRect)frame imageURL:(NSString *)imageURL timeSecond:(NSInteger )timeSecond hideSkip:(BOOL)hideSkip LaunchAdCallback:(LaunchAdCallback)LaunchAdCallback ImageClick:(LaunchAdClick)ImageClick endPlays:(EndPlays)endPlays;


@end

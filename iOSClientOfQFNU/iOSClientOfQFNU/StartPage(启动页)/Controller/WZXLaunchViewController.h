//
//  WZXLaunchViewController.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ImageLoadingGood)(UIImage *image,NSString *imageURL);

typedef void (^ClickImage)(UIViewController *advertisingVC);

typedef void (^TheAdEnds)();

@interface WZXLaunchViewController : UIViewController

@property (nonatomic,copy) ImageLoadingGood imageLoadGood;

@property (nonatomic,copy) ClickImage clickImage;

@property (nonatomic,copy) TheAdEnds  theAdEnds;





/**
 *  WZXLaunchViewController
 *
 *  @param imageFrame            广告图片的位置
 *  @param ImageURL         加载广告的URL 可以是图片 也可以是GIF
 *  @param advertisingURL   广告的URL
 *  @param timeSecond       广告的时长
 *  @param hideSkip         是否隐藏“跳过按钮” YES隐藏  NO显示
 *  @param imageLoadGood    广告图片加载完成 回调
 *  @param clickImage       点击广告 回调
 *  @param theAdEnds         广告播放结束 回调
 *
 */
+ (void)showWithFrame:(CGRect)imageFrame ImageURL:(NSString *)ImageURL advertisingURL:(NSString *)advertisingURL timeSecond:(NSInteger)timeSecond hideSkip:(BOOL)hideSkip imageLoadGood:(ImageLoadingGood)imageLoadGood clickImage:(ClickImage)clickImage theAdEnds:(TheAdEnds)theAdEnds;



@end

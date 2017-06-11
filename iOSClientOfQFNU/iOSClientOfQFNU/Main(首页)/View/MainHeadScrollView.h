//
//  MainHeadScrollView.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapImageViewBlock)(NSInteger tag);

@interface MainHeadScrollView : UIView

@property (strong, nonatomic)  UIScrollView *scrollView;
/**
 分页指示器
 */
@property (strong, nonatomic)  UIPageControl *pageControl;

@property (nonatomic,strong) UIImageView *imageView;

//定时器
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic,strong) TapImageViewBlock tapImageBlock;

-(void) tapImageViewBlock:(TapImageViewBlock)tapImageBlock;

-(instancetype)initWithFrame:(CGRect)frame ImagesCount:(NSInteger )ImageCount;

@end

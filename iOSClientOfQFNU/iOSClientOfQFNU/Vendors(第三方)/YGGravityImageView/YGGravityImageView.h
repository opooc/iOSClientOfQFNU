//
//  YGGravityImageView.h
//  zhonggantest
//
//  Created by zhangkaifeng on 16/6/23.
//  Copyright © 2016年 张楷枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGGravityImageView : UIView

/**
 *  显示的图片
 */
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong,readonly) UIImageView * myImageView;

/**
 *  开始重力感应
 */
-(void)startAnimate;

/**
 *  停止重力感应
 */
-(void)stopAnimate;

@end

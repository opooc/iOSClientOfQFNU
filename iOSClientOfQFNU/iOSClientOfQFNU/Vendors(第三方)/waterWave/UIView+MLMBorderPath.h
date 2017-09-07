//
//  UIView+MLMBorderPath.h
//  MLMProgressView
//
//  Created by my on 2016/11/17.
//  Copyright © 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MLMBorderPath)
//******建议的宽高比是为了确保设置的进度准确显示********//


///心形效果建议设置一块矩形区域(宽高比10:9)，具体效果自己查看
+ (UIBezierPath *)heartPathRect:(CGRect)rect
                      lineWidth:(CGFloat)width;

///圆形区域的path
+ (UIBezierPath *)circlePathRect:(CGRect)rect
                       lineWidth:(CGFloat)width;

///星星path，设置为建议举行区域(宽高比： 2:(sin(3*M_PI/10) + 1)  )
+ (UIBezierPath *)startPathRect:(CGRect)rect
                      lineWidth:(CGFloat)width;
@end

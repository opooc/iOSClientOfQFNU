//
//  UIView+MLMBorderPath.m
//  MLMProgressView
//
//  Created by my on 2016/11/17.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "UIView+MLMBorderPath.h"

@implementation UIView (MLMBorderPath)

+ (UIBezierPath *)heartPathRect:(CGRect)rect
                       lineWidth:(CGFloat)width {
    CGFloat radius = rect.size.width/4;
    
    CGPoint center1 = CGPointMake(radius, radius);
    CGPoint center2 = CGPointMake(3*radius, radius);
    
    CGPoint bottom = CGPointMake(2*radius, rect.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center1 radius:radius startAngle:0 endAngle:3*M_PI_4 clockwise:NO];
    
    [path addLineToPoint:bottom];
    [path addArcWithCenter:center2 radius:radius startAngle:M_PI_4 endAngle:M_PI clockwise:NO];
    
    [path setLineCapStyle:kCGLineCapRound];
    
    [path setLineWidth:width];

    return path;
}

///圆形区域的path
+ (UIBezierPath *)circlePathRect:(CGRect)rect
                       lineWidth:(CGFloat)width {
    //没有直接使用rect防止传入的是frame而不是试图的bounds
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [path setLineWidth:width];

    return path;
}

+ (UIBezierPath *)startPathRect:(CGRect)rect
                      lineWidth:(CGFloat)width {
    UIBezierPath *star = [UIBezierPath bezierPath];
    //确定中心点
    CGPoint centerPoint = CGPointMake(rect.size.width/2, rect.size.width/2);
    //确定半径
    CGFloat bigRadius = rect.size.width/2;
    CGFloat smallRadius = bigRadius * sin(2*M_PI/20) / cos(2*M_PI/10);
    //起始点
    CGPoint start=CGPointMake(rect.size.width/2, 0);
    [star moveToPoint:start];
    //五角星每个顶角与圆心连线的夹角 2π/5，
    CGFloat angle=2*M_PI/5.0;
    for (int i=1; i<=10; i++) {
        CGFloat x;
        CGFloat y;
        NSInteger c = i/2;
        if (i%2 == 0) {
            x=centerPoint.x-sinf(c*angle)*bigRadius;
            y=centerPoint.y-cosf(c*angle)*bigRadius;
        } else {
            x=centerPoint.x-sinf(c*angle + angle/2)*smallRadius;
            y=centerPoint.y-cosf(c*angle + angle/2)*smallRadius;
        }
        [star addLineToPoint:CGPointMake(x, y)];
    }
    [star setLineWidth:width];
    
    return star;
}

@end

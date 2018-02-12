//
//  LCUserFeedbackViewController.h
//
//  Created by yang chaozhong on 4/24/14.
//  Copyright (c) 2014 LeanCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LCUserFeedbackNavigationBarStyleBlue = 0,
    LCUserFeedbackNavigationBarStyleNone,
} LCUserFeedbackNavigationBarStyle;

@interface LCUserFeedbackViewController : UIViewController

/**
 *  导航栏主题，默认是蓝色主题
 */
@property(nonatomic, assign) LCUserFeedbackNavigationBarStyle navigationBarStyle;

/**
 *  是否隐藏联系方式表头, 默认不隐藏。假如不需要用户提供联系方式则可以隐藏。
 */
@property(nonatomic, assign) BOOL contactHeaderHidden;

/**
 *  设置字体。默认是大小为 16 的系统字体。
 */
@property(nonatomic, strong) UIFont *feedbackCellFont;

/**
 *  这个是网站看到的用户反馈标题。默认采用第一条反馈作为标题。
 */
@property(nonatomic, copy) NSString *feedbackTitle;

/**
 *  联系人。nil 需要用户自己填写。如果不需要用户填写联系方式，请设置 contactHeaderHidden
 */
@property(nonatomic, copy) NSString *contact;

/**
 *  是否使用 present 方式弹出。默认为YES，决定返回按钮样式和返回方式
 */
@property(nonatomic, assign) BOOL presented;

@end

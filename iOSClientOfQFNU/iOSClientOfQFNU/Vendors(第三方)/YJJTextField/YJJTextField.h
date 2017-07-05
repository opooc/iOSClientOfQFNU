//
//  YJJTextField.h
//  YJJTextField
//
//  Created by arges on 2017/6/5.
//  Copyright © 2017年 ArgesYao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJJTextField : UIView

/** 内容文本框 */
@property (weak, nonatomic) IBOutlet UITextField *textField;

/** 最大字数(必填) */
@property (nonatomic,assign) NSInteger maxLength;
/** 输入内容错误提示(必填) */
@property (nonatomic,strong) NSString *errorStr;
/** 占位文字(必填) */
@property (nonatomic,strong) NSString *placeholder;
/** 保存输入内容的KEY(必填) */
@property (nonatomic,strong) NSString *historyContentKey;
/** 左侧图标名称(有默认图片) */
@property (nonatomic,strong) NSString *leftImageName;
/** 文本字体大小(默认15.0) */
@property (nonatomic,assign) CGFloat textFont;
/** 文本颜色(默认DarkGray) */
@property (nonatomic,strong) UIColor *textColor;
/** 文本字体大小(默认15.0) */
@property (nonatomic,assign) CGFloat placeHolderFont;
/** 文本颜色(默认LightGray) */
@property (nonatomic,strong) UIColor *placeHolderColor;
/** 字数限制文本颜色(默认灰色) */
@property (nonatomic,strong) UIColor *textLengthLabelColor;
/** 上浮的占位文本颜色(默认深绿色) */
@property (nonatomic,strong) UIColor *placeHolderLabelColor;
/** 底部线条默认颜色(默认灰色) */
@property (nonatomic,strong) UIColor *lineDefaultColor;
/** 底部线条选中颜色(默认深绿色) */
@property (nonatomic,strong) UIColor *lineSelectedColor;
/** 底部线条错误警告颜色(默认红色) */
@property (nonatomic,strong) UIColor *lineWarningColor;
/** 是否需要显示历史记录列表(默认YES) */
@property (nonatomic,assign) BOOL showHistoryList;


/**
 初始化方法
 */
+ (instancetype)yjj_textField;


/**
 上浮占位文字的显示与隐藏
 @param isHidden 是否隐藏
 */
- (void)setPlaceHolderLabelHidden:(BOOL)isHidden;

/**
 取消历史数据列表
 */
- (void)dismissTheHistoryContentTableView;
@end

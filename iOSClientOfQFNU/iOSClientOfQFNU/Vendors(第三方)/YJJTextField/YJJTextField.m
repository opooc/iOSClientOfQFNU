//
//  YJJTextField.m
//  YJJTextField
//
//  Created by arges on 2017/6/5.
//  Copyright © 2017年 ArgesYao. All rights reserved.
//

#import "YJJTextField.h"
#import "HistoryContentCell.h"

#define YJJ_Color(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
const static CGFloat margin = 10.0;
const static CGFloat tableViewH = 100.0;
const static CGFloat animateDuration = 0.5;

@interface YJJTextField ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

/** 上浮的占位文本 */
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
/** 左侧小图标 */
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
/** 字数限制文本 */
@property (weak, nonatomic) IBOutlet UILabel *textLengthLabel;
/** 底部线条 */
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
/** 错误提示文本 */
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

/** 窗口 */
@property (nonatomic,strong) UIWindow *window;
/** 表格视图 */
@property (nonatomic,strong) UITableView *tableView;
/** 历史数据 */
@property (nonatomic,strong) NSArray *historyContentArr;


@end

@implementation YJJTextField

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.alpha = 0.0;
        _tableView.layer.borderWidth = 1.0;
        _tableView.layer.borderColor = YJJ_Color(220, 220, 220).CGColor;
        _tableView.layer.cornerRadius = 5.0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
#pragma mark - 初始化
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textField.delegate = self;
    
    self.textColor = YJJ_Color(85, 85, 85);
    self.textLengthLabelColor = YJJ_Color(92, 94, 102);
    self.placeHolderLabelColor = YJJ_Color(1, 183, 164);
    self.lineDefaultColor = YJJ_Color(220, 220, 220);
    self.lineSelectedColor = YJJ_Color(1, 183, 164);
    self.lineWarningColor = YJJ_Color(252, 57, 24);
    
    self.showHistoryList = YES;
}


#pragma mark - 公共方法
+ (instancetype)yjj_textField
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

- (void)setPlaceHolderLabelHidden:(BOOL)isHidden
{
    if (isHidden) {
        [UIView animateWithDuration:animateDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.placeHolderLabel.alpha = 0.0f;
            self.textField.placeholder = self.placeholder;
            self.bottomLine.backgroundColor = self.lineDefaultColor;
        } completion:nil];
    }else{
        [UIView animateWithDuration:animateDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.placeHolderLabel.alpha = 1.0f;
            self.placeHolderLabel.text = self.placeholder;
            self.textField.placeholder = @"";
            self.bottomLine.backgroundColor = self.lineSelectedColor;
        } completion:nil];
    }
}

#pragma mark - 提示列表
- (void)showTheHistoryContentTableView:(CGFloat)y
{
    self.window = [UIApplication sharedApplication].keyWindow;
    self.window.backgroundColor = [UIColor clearColor];
    [self.window addSubview:self.tableView];
    self.tableView.frame = CGRectMake(margin, y, self.frame.size.width-margin*2, tableViewH);
    [self.tableView reloadData];
    
    [UIView animateWithDuration:animateDuration animations:^{
        self.tableView.alpha = 1.0;
    }];
}

- (void)dismissTheHistoryContentTableView
{
    [UIView animateWithDuration:animateDuration animations:^{
        self.tableView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.tableView removeFromSuperview];
        self.window = nil;
    }];
}

- (void)loadHistoryContentWithKey:(NSString *)key
{
    self.historyContentArr = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults objectForKey:@"historyContent"];
    for (NSString *string in dic.allKeys) {
        if ([string isEqualToString:key]) {
            self.historyContentArr = dic[string];
            break;
        }
    }
}

#pragma mark - UITextFieldDelegate
- (IBAction)textFieldEditingChanged:(UITextField *)sender
{
    if (sender.text.length > self.maxLength) {
        [UIView animateWithDuration:animateDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.errorLabel.alpha = 1.0;
            self.errorLabel.textColor = self.lineWarningColor;
            self.bottomLine.backgroundColor = self.lineWarningColor;
            self.textLengthLabel.textColor = self.lineWarningColor;
            self.textField.textColor = self.lineWarningColor;
            //self.placeHolderLabel.textColor = self.lineWarningColor;
        } completion:nil];
    }else{
        [UIView animateWithDuration:animateDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.errorLabel.alpha = 0.0;
            self.bottomLine.backgroundColor = self.lineSelectedColor;
            self.textLengthLabel.textColor = self.textLengthLabelColor;
            self.textField.textColor = self.textColor;
            //self.placeHolderLabel.textColor = self.placeHolderLabelColor;
        } completion:nil];
    }
    self.textLengthLabel.text = [NSString stringWithFormat:@"%zd/%zd",sender.text.length,self.maxLength];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self setPlaceHolderLabelHidden:NO];
    
    [self loadHistoryContentWithKey:self.historyContentKey];
    
    if (self.historyContentArr.count != 0 && self.showHistoryList) {
        CGFloat y = CGRectGetMaxY(self.frame);
        [self showTheHistoryContentTableView:y];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self setPlaceHolderLabelHidden:YES];
    [self dismissTheHistoryContentTableView];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    
    [self setPlaceHolderLabelHidden:YES];
    [self dismissTheHistoryContentTableView];
    
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyContentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryContentCell *cell = [HistoryContentCell cellWithTableView:tableView];
    
    cell.contentLabel.text = self.historyContentArr[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.textField.text = self.historyContentArr[indexPath.row];
    
    self.textLengthLabel.text = [NSString stringWithFormat:@"%zd/%zd",self.textField.text.length,self.maxLength];
    
    [self dismissTheHistoryContentTableView];
}

#pragma mark - setter
- (void)setMaxLength:(NSInteger)maxLength
{
    _maxLength = maxLength;
    self.textLengthLabel.text = [NSString stringWithFormat:@"0/%zd",maxLength];
}
- (void)setErrorStr:(NSString *)errorStr
{
    _errorStr = errorStr;
    self.errorLabel.text = errorStr;
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
    self.placeHolderLabel.text = placeholder;
}
- (void)setHistoryContentKey:(NSString *)historyContentKey
{
    _historyContentKey = historyContentKey;
}
- (void)setLeftImageName:(NSString *)leftImageName
{
    _leftImageName = leftImageName;
    self.leftImageView.image = [UIImage imageNamed:leftImageName];
}
- (void)setTextFont:(CGFloat)textFont
{
    _textFont = textFont;
    self.textField.font = [UIFont systemFontOfSize:textFont];
}
- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textField.textColor = textColor;
    self.tintColor = textColor;         // 光标颜色
}
- (void)setPlaceHolderFont:(CGFloat)placeHolderFont
{
    _placeHolderFont = placeHolderFont;
    [self.textField setValue:[UIFont systemFontOfSize:placeHolderFont] forKeyPath:@"_placeholderLabel.font"];
}
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    [self.textField setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)setTextLengthLabelColor:(UIColor *)textLengthLabelColor
{
    _textLengthLabelColor = textLengthLabelColor;
    self.textLengthLabel.textColor = textLengthLabelColor;
}
- (void)setPlaceHolderLabelColor:(UIColor *)placeHolderLabelColor
{
    _placeHolderLabelColor = placeHolderLabelColor;
    self.placeHolderLabel.textColor = placeHolderLabelColor;
}
- (void)setLineDefaultColor:(UIColor *)lineDefaultColor
{
    _lineDefaultColor = lineDefaultColor;
    self.bottomLine.backgroundColor = lineDefaultColor;
}
- (void)setLineSelectedColor:(UIColor *)lineSelectedColor
{
    _lineSelectedColor = lineSelectedColor;
}
- (void)setLineWarningColor:(UIColor *)lineWarningColor
{
    _lineWarningColor = lineWarningColor;
}
@end

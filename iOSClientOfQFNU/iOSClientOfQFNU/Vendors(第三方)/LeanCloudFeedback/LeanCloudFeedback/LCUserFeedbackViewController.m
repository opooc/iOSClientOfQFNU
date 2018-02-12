//
//  LCUserFeedbackViewController.m
//  Feedback
//
//  Created by yang chaozhong on 4/24/14.
//  Copyright (c) 2014 LeanCloud. All rights reserved.
//

#import "LCUserFeedbackViewController.h"
#import "LCUserFeedbackReplyCell.h"
#import "LCUserFeedbackThread.h"
#import "LCUserFeedbackThread_Internal.h"
#import "LCUserFeedbackReply_Internal.h"
#import "LCUserFeedbackReply.h"
#import "LCUserFeedbackAgent.h"
#import "LCUserFeedbackImageViewController.h"
#import "LCUtils.h"

#define kInputViewColor [UIColor colorWithRed:247.0f/255 green:248.0f/255 blue:248.0f/255 alpha:1]

#define TAG_TABLEView_Header 1
#define TAG_InputFiled 2

static CGFloat const kInputViewHeight = 48;
static CGFloat const kContactHeaderHeight = 48;
static CGFloat const kAddImageButtonWidth = 40;
static CGFloat const kSendButtonWidth = 60;

@interface LCUserFeedbackViewController () <UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, LCUserFeedbackReplyCellDelegate> {
    NSMutableArray *_feedbackReplies;
    LCUserFeedbackThread *_userFeedback;
}

@property(nonatomic, strong) UIRefreshControl *refreshControl;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UITextField *tableViewHeader;
@property(nonatomic, strong) UITextField *inputTextField;
@property(nonatomic, strong) UIButton *addImageButton;
@property(nonatomic, strong) UIButton *sendButton;
@property(nonatomic, strong) UIBarButtonItem *closeButtonItem;

@end

@implementation LCUserFeedbackViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _feedbackReplies = [[NSMutableArray alloc] init];
        // Custom initialization
        _navigationBarStyle = LCUserFeedbackNavigationBarStyleBlue;
        _contactHeaderHidden = NO;
        _feedbackCellFont = [UIFont systemFontOfSize:16];
        _presented = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
//    [self keyboardWillHide:nil];
    [self loadFeedbackThreads];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 记录最后阅读时，看到了多少条反馈
    if (_userFeedback !=nil && _feedbackReplies.count > 0) {
        NSString *localKey = [NSString stringWithFormat:@"feedback_%@", _userFeedback.objectId];
        [[NSUserDefaults standardUserDefaults] setObject:@(_feedbackReplies.count) forKey:localKey];
    }
}

- (void)setupUI {
    if (self.presented) {
        self.navigationItem.leftBarButtonItem = self.closeButtonItem;
    }
    
    [self.navigationItem setTitle:LCLocalizedString(@"User Feedback")];
    [self setupNavigaionBar];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addImageButton];
    [self.view addSubview:self.sendButton];
    [self.view addSubview:self.inputTextField];

    [[[LCUserFeedbackReplyCell class] appearance] setCellFont:self.feedbackCellFont];
    
    [self.tableView addSubview:self.refreshControl];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tap];
}

#pragma mark - Properties

- (UIButton *)closeButton {
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeButtonImage = [UIImage imageNamed:@"feedback_back"];
    [closeButton setImage:closeButtonImage forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(0, 0, closeButtonImage.size.width, closeButtonImage.size.height);
    closeButton.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    return closeButton;
}

- (UIBarButtonItem *)closeButtonItem {
    if (_closeButtonItem == nil) {
        if (self.presented) {
            _closeButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(closeButtonClicked:)];
        } else {
            UIButton *closeButton = [self closeButton];
            [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            _closeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
        }

    }
    return _closeButtonItem;
}


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - kInputViewHeight)
                                                      style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIButton *)addImageButton {
    if (_addImageButton == nil) {
        _addImageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - kInputViewHeight, kAddImageButtonWidth, kInputViewHeight)];
        _addImageButton.backgroundColor = kInputViewColor;
        [_addImageButton setImage:[UIImage imageNamed:@"feedback_add_image"] forState:UIControlStateNormal];
        _addImageButton.contentMode = UIViewContentModeScaleAspectFill;
        [_addImageButton addTarget:self action:@selector(addImageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageButton;
}

- (UIButton *)sendButton {
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _sendButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - kSendButtonWidth, CGRectGetHeight(self.view.frame) - kInputViewHeight, kSendButtonWidth, kInputViewHeight);
        [_sendButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_sendButton setTitleColor:[UIColor colorWithRed:137.0f/255 green:137.0f/255 blue:137.0f/255 alpha:1] forState:UIControlStateNormal];
        [_sendButton setTitle:LCLocalizedString(@"Send") forState:UIControlStateNormal];
        [_sendButton setBackgroundColor: kInputViewColor];
        [_sendButton addTarget:self action:@selector(sendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UITextField *)inputTextField {
    if (_inputTextField == nil) {
        _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(kAddImageButtonWidth, CGRectGetMinY(self.sendButton.frame), CGRectGetWidth(self.view.frame)- kSendButtonWidth - kAddImageButtonWidth, kInputViewHeight)];
        _inputTextField.tag = TAG_InputFiled;
        [_inputTextField setFont:[UIFont systemFontOfSize:12]];
        _inputTextField.backgroundColor = kInputViewColor;
        _inputTextField.placeholder = LCLocalizedString(@"Please write your feedback");
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        _inputTextField.leftView = paddingView;
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        _inputTextField.returnKeyType = UIReturnKeyDone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        _inputTextField.delegate = self;
    }
    return _inputTextField;
}

- (void)setupNavigaionBar {
    switch (self.navigationBarStyle) {
        case LCUserFeedbackNavigationBarStyleBlue: {
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
            UIColor *blue =[UIColor colorWithRed:85.0f/255 green:184.0f/255 blue:244.0f/255 alpha:1];
            self.navigationController.navigationBar.barTintColor = blue;
            self.closeButtonItem.tintColor = [UIColor whiteColor];
            break;
        }
        case LCUserFeedbackNavigationBarStyleNone:
            break;
        default:
            break;
    }
}

- (UIRefreshControl *)refreshControl {
    if (_refreshControl == nil) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

#pragma mark - load data

- (void)fetchRepliesWithBlock:(AVArrayResultBlock)block {
    [LCUserFeedbackThread fetchFeedbackWithBlock:^(LCUserFeedbackThread *feedback, NSError *error) {
        if (error) {
            block(nil, error);
        } else {
            if (feedback) {
                _userFeedback = feedback;
                if (self.contact == nil) {
                    self.contact = feedback.contact;
                }
                [_userFeedback fetchFeedbackRepliesInBackgroundWithBlock:block];
            } else {
                block([NSArray array], nil);
            }
        }
    }];
}

- (void)loadFeedbackThreads {
    if (![_refreshControl isRefreshing]) {
        [_refreshControl beginRefreshing];
    }
    [self fetchRepliesWithBlock:^(NSArray *objects, NSError *error) {
        [_refreshControl endRefreshing];
        if ([self filterError:error]) {
            if (objects.count > 0) {
                [_feedbackReplies removeAllObjects];
                [_feedbackReplies addObjectsFromArray:objects];
                
                [_tableView reloadData];
                [self scrollToBottom];
            }
        }
    }];
}

- (void)handleRefresh:(id)sender {
    [self loadFeedbackThreads];
}
 
#pragma mark - util

- (void)alertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alertView show];
}

- (BOOL)filterError:(NSError *)error {
    if (error) {
        [self alertWithTitle:@"出错了" message:[error description]];
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - send action

- (void)popImageViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didSelectImageViewOnFeedbackReply:(LCUserFeedbackReply *)feedbackReply {
    LCUserFeedbackImageViewController *imageViewController = [[LCUserFeedbackImageViewController alloc] init];
    imageViewController.image = feedbackReply.attachmentImage;
    if (self.navigationBarStyle == LCUserFeedbackNavigationBarStyleBlue) {
        UIButton *button = [self closeButton];
        [button addTarget:self action:@selector(popImageViewController:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        imageViewController.navigationItem.leftBarButtonItem = item;
    }
    [self.navigationController pushViewController:imageViewController animated:YES];
}

- (void)closeButtonClicked:(id)sender {
    if (self.presented) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSString *)currentContact {
    NSString *contact = self.tableViewHeader.text;
    return contact.length > 0 ? contact : _contact;
}

- (void)addImageButtonClicked:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.navigationBar.barStyle = UIBarStyleBlack;
    pickerController.delegate = self;
    pickerController.editing = NO;
    pickerController.allowsEditing = NO;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *originImage = info[UIImagePickerControllerOriginalImage];
    [self prepareFeedbackWithBlock:^(BOOL succeeded, NSError *error) {
        if ([self filterError:error]) {
            AVFile *attachment = [AVFile fileWithName:@"feedback.png" data:UIImageJPEGRepresentation(originImage, 0.6)];
            [attachment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if ([self filterError:error]) {
                    LCUserFeedbackReply *feedbackReply = [LCUserFeedbackReply feedbackReplyWithAttachment:attachment.url type:LCReplyTypeUser];
                    feedbackReply.attachmentImage = originImage;
                    [self saveFeedbackReply:feedbackReply AtFeedback:_userFeedback];
                }
            }];
        }
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareFeedbackWithBlock:(AVBooleanResultBlock)block {
    NSString *contact = [self currentContact];
    NSString *content = self.inputTextField.text;
    if (_userFeedback) {
        block(YES, nil);
    } else {
        _contact = contact;
        NSString *title = _feedbackTitle ?: content;
        if (title.length == 0) {
            title = @"用户反馈";
        }
        [LCUserFeedbackThread feedbackWithContent:title contact:_contact create:YES withBlock:^(id object, NSError *error) {
            if (error) {
                block(NO, error);
            } else {
                _userFeedback = object;
                block(YES, nil);
            }
        }];
    }
}

- (void)sendButtonClicked:(id)sender {
    NSString *content = self.inputTextField.text;
    if (content.length) {
        self.sendButton.enabled = NO;
        [self prepareFeedbackWithBlock:^(BOOL succeeded, NSError *error) {
            if ([self filterError:error]) {
                LCUserFeedbackReply *feedbackReply = [LCUserFeedbackReply feedbackReplyWithContent:content type:LCReplyTypeUser];
                [self saveFeedbackReply:feedbackReply AtFeedback:_userFeedback];
            } else {
                self.sendButton.enabled = YES;
            }
        }];
    }
}

- (void)saveFeedbackReply:(LCUserFeedbackReply *)feedbackReply AtFeedback:(LCUserFeedbackThread *)feedback {
    [_userFeedback saveFeedbackReplyInBackground:feedbackReply withBlock:^(id object, NSError *error) {
        if ([self filterError:error]) {
            [_feedbackReplies addObject:feedbackReply];
            [self.tableView reloadData];
            [self scrollToBottom];
            
            if ([_inputTextField.text length] > 0) {
                _inputTextField.text = @"";
            }
        }
        self.sendButton.enabled = YES;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIKeyboard Notification

- (void)updateHeightWhenKeyboardHide:(UIView *)bottomView {
    CGRect bottomViewFrame = bottomView.frame;
    bottomViewFrame.origin.y = self.view.bounds.size.height - bottomViewFrame.size.height;
    bottomView.frame = bottomViewFrame;
}

- (void)updateHeightWhenKeyboardShow:(UIView *)bottomView keyboardHeight:(CGFloat)keyboardHeight{
    CGRect bottomViewFrame = bottomView.frame;
    bottomViewFrame.origin.y = self.view.bounds.size.height - keyboardHeight - bottomViewFrame.size.height;
    bottomView.frame = bottomViewFrame;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if ([self.tableViewHeader isFirstResponder]) {
        return;
    }
    
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         [self updateHeightWhenKeyboardShow:self.addImageButton keyboardHeight:keyboardHeight];
                         [self updateHeightWhenKeyboardShow:self.inputTextField keyboardHeight:keyboardHeight];
                         [self updateHeightWhenKeyboardShow:self.sendButton keyboardHeight:keyboardHeight];
                         
                         CGRect tableViewFrame = self.tableView.frame;
                         tableViewFrame.size.height = self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - keyboardHeight;
                         self.tableView.frame = tableViewFrame;
                     }
                     completion:^(BOOL finished) {
                         [self scrollToBottom];
                     }
     ];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if ([self.tableViewHeader isFirstResponder]) {
        return;
    }
    
    [UIView beginAnimations:@"bottomBarDown" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [self updateHeightWhenKeyboardHide:self.addImageButton];
    [self updateHeightWhenKeyboardHide:self.inputTextField];
    [self updateHeightWhenKeyboardHide:self.sendButton];
    
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height = CGRectGetHeight(self.view.frame) - kInputViewHeight;
    self.tableView.frame = tableViewFrame;
    
    [UIView commitAnimations];
}

- (void)closeKeyboard:(id)sender {
    [self.inputTextField resignFirstResponder];
}

#pragma mark UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == TAG_TABLEView_Header && [textField.text length] > 0 && _userFeedback) {
        _userFeedback.contact = textField.text;
        [LCUserFeedbackThread updateFeedback:_userFeedback withBlock:^(id object, NSError *error) {
            if ([self filterError:error]) {
                [self alertWithTitle:@"提示" message:@"更改成功"];
            }
        }];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollToBottom {
    if ([self.tableView numberOfRowsInSection:0] > 1) {
        NSInteger lastRowNumber = [self.tableView numberOfRowsInSection:0] - 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - UITableViewDelegate and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_feedbackReplies count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.contactHeaderHidden) {
        return 0;
    } else {
        return kContactHeaderHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.tableViewHeader = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, kContactHeaderHeight)];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    self.tableViewHeader.leftView = paddingView;
    self.tableViewHeader.leftViewMode = UITextFieldViewModeAlways;
    
    self.tableViewHeader.delegate = (id <UITextFieldDelegate>) self;
    self.tableViewHeader.tag = TAG_TABLEView_Header;
    [self.tableViewHeader setBackgroundColor:[UIColor colorWithRed:247.0f/255 green:248.0f/255 blue:248.0f/255 alpha:1]];
    self.tableViewHeader.textAlignment = NSTextAlignmentLeft;
    self.tableViewHeader.placeholder = LCLocalizedString(@"Email Or QQ");
    [self.tableViewHeader setFont:[UIFont systemFontOfSize:12.0f]];
    if (_contact) {
        self.tableViewHeader.text = _contact;
    }
    return _tableViewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  [LCUserFeedbackReplyCell heightForFeedbackReply:(LCUserFeedbackReply *)_feedbackReplies[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCUserFeedbackReply *feedbackReply = _feedbackReplies[indexPath.row];
    static NSString *cellIdentifier = @"feedbackReplyCell";
    LCUserFeedbackReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LCUserFeedbackReplyCell alloc] initWithFeedbackReply:feedbackReply reuseIdentifier:cellIdentifier];;
        cell.delegate = self;
    }
    [cell configuareCellWithFeedbackReply:feedbackReply];
    return cell;
}

@end



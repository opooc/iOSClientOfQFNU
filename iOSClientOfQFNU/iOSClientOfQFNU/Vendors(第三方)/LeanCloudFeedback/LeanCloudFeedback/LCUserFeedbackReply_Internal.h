
//
//  LCUserFeedbackReply_Internal.h
//  LeanCloudFeedback
//
//  Created by lzw on 15/7/21.
//  Copyright (c) 2015年 LeanCloud. All rights reserved.
//

#import "LCUserFeedbackReply.h"

@interface LCUserFeedbackReply()

@property(nonatomic, strong, readwrite) UIImage *attachmentImage;
@property(nonatomic, copy, readwrite) NSString *createAt;

@end
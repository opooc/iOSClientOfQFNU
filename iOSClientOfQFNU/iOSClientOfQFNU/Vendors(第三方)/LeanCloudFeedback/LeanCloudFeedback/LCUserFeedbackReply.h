//
//  LCUserFeedbackReply.h
//
//  Created by yang chaozhong on 4/21/14.
//  Copyright (c) 2014 LeanCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVOSCloud.h"

typedef enum : NSInteger {
    LCContentTypeText = 0 ,
    LCContentTypeImage
}LCContentType;

typedef enum : NSInteger {
    LCReplyTypeUser = 0,
    LCReplyTypeDev,
}LCReplyType;

@class LCUserFeedbackThread;

@interface LCUserFeedbackReply : NSObject

@property(nonatomic, retain) LCUserFeedbackThread *feedback;

@property(nonatomic, copy, readonly) NSString *content;
@property(nonatomic, copy, readonly) NSString *attachment;
@property(nonatomic, strong, readonly) UIImage *attachmentImage;
@property(nonatomic, assign, readonly) LCReplyType type;
@property(nonatomic, copy, readonly) NSString *createAt;

+ (instancetype)feedbackReplyWithContent:(NSString *)content type:(LCReplyType)type;
+ (instancetype)feedbackReplyWithAttachment:(NSString *)attachment type:(LCReplyType)type;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (LCContentType)contentType;

@end

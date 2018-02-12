//
//  LCUserFeedbackReply.m
//
//  Created by yang chaozhong on 4/21/14.
//  Copyright (c) 2014 LeanCloud. All rights reserved.
//

#import "LCUserFeedbackReply.h"
#import "LCUserFeedbackReply_Internal.h"
#import "LCUserFeedbackThread.h"
#import "LCHttpClient.h"
#import "LCUtils.h"

@interface LCUserFeedbackReply ()

@property(nonatomic, assign, readwrite) LCReplyType type;
@property(nonatomic, copy, readwrite) NSString *attachment;
@property(nonatomic, copy, readwrite) NSString *content;

@end

@implementation LCUserFeedbackReply

- (NSDictionary *)dictionary {
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
    
    if (self.type == LCReplyTypeDev) {
        [data setObject:@"dev" forKey:@"type"];
    } else {
        [data setObject:@"user" forKey:@"type"];
    }
    if (self.content) {
        [data setObject:self.content forKey:@"content"];
    }
    if (self.attachment) {
        [data setObject:self.attachment forKey:@"attachment"];
    }
    return [data copy];
}

+ (instancetype)feedbackReplyWithContent:(NSString *)content type:(LCReplyType)type {
    LCUserFeedbackReply *feedbackReply = [[LCUserFeedbackReply alloc] init];
    feedbackReply.content = content;
    feedbackReply.type = type;
    return feedbackReply;
}

+ (instancetype)feedbackReplyWithAttachment:(NSString *)attachment type:(LCReplyType)type {
    LCUserFeedbackReply *feedbackReply = [[LCUserFeedbackReply alloc] init];
    feedbackReply.attachment = attachment;
    feedbackReply.type = type;
    return feedbackReply;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    LCUserFeedbackReply *feedbackReply = [[LCUserFeedbackReply alloc] init];
    feedbackReply.content = [dictionary objectForKey:@"content"];
    feedbackReply.createAt = [dictionary objectForKey:@"createdAt"];
    NSString *type = [dictionary objectForKey:@"type"];
    if ([type isEqualToString:@"user"]) {
        feedbackReply.type = LCReplyTypeUser;
    } else {
        feedbackReply.type = LCReplyTypeDev;
    }
    NSString *attachment = [dictionary objectForKey:@"attachment"];
    feedbackReply.attachment = attachment;
    return feedbackReply;
}

- (LCContentType)contentType {
    if (self.attachment) {
        return LCContentTypeImage;
    } else {
        return LCContentTypeText;
    }
}

@end

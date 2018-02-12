//
//  LCUserFeedbackThread.h
//  Feedback
//
//  Created by yang chaozhong on 4/21/14.
//  Copyright (c) 2014 LeanCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVConstants.h"

@class LCUserFeedbackThread;
@class LCUserFeedbackReply;

typedef void (^LCUserFeedbackBlock)(LCUserFeedbackThread *feedback, NSError *error);


@interface LCUserFeedbackThread : NSObject

@property(nonatomic, copy) NSString *objectId;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *contact;

+(void)fetchFeedbackWithBlock:(LCUserFeedbackBlock)block;
+(void)fetchFeedbackWithContact:(NSString*)contact withBlock:(AVIdResultBlock)block AV_DEPRECATED("Use + fetchFeedbackWithBlock: instead");
+(void)feedbackWithContent:(NSString *)content contact:(NSString *)contact withBlock:(AVIdResultBlock)block AV_DEPRECATED("Use + fetchFeedbackWithBlock: instead");

+(void)updateFeedback:(LCUserFeedbackThread *)feedback withBlock:(AVIdResultBlock)block;

+(void)deleteFeedback:(LCUserFeedbackThread *)feedback withBlock:(AVIdResultBlock)block;

-(instancetype)initWithDictionary:(NSDictionary*)dict;

-(void)saveFeedbackReplyInBackground:(LCUserFeedbackReply *)feedbackReply withBlock:(AVIdResultBlock)block;

-(void)fetchFeedbackRepliesInBackgroundWithBlock:(AVArrayResultBlock)block;

@end

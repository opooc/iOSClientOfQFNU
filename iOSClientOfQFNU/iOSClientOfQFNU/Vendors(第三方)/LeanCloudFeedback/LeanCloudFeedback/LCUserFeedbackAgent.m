//
//  LCUserFeedbackAgent.m
//  Feedback
//
//  Created by yang chaozhong on 4/22/14.
//  Copyright (c) 2014 LeanCloud. All rights reserved.
//

#import "LCUserFeedbackAgent.h"
#import "LCUserFeedbackThread.h"
#import "LCUserFeedbackReply.h"
#import "LCUserFeedbackViewController.h"
#import "LCUtils.h"

@interface LCUserFeedbackAgent()
    
@property(nonatomic, retain) LCUserFeedbackThread *userFeedback;

@end

@implementation LCUserFeedbackAgent

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static LCUserFeedbackAgent * sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)showConversations:(UIViewController *)viewController title:(NSString *)title contact:(NSString *)contact{
    LCUserFeedbackViewController *feedbackViewController = [[LCUserFeedbackViewController alloc] init];
    feedbackViewController.feedbackTitle = title;
    feedbackViewController.contact = contact;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [viewController presentViewController:navigationController animated:YES completion:^{
    }];
}

- (void)syncFeedbackThreadsWithBlock:(NSString *)title contact:(NSString *)contact block:(AVArrayResultBlock)block {
    [self syncFeedbackThreadsWithContact:contact block:block];
}

- (void)syncFeedbackThreadsWithContact:(NSString *)contact block:(AVArrayResultBlock)block {
    [LCUserFeedbackThread fetchFeedbackWithContact:contact withBlock:^(id object, NSError *error) {
        if (!error) {
            if (object) {
                NSDictionary *dict = [[object objectForKey:@"results"] firstObject];
                self.userFeedback = [[LCUserFeedbackThread alloc] initWithDictionary:dict];

                [self.userFeedback fetchFeedbackRepliesInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    [LCUtils callArrayResultBlock:block array:objects error:error];
                }];
            } else {
                [LCUtils callArrayResultBlock:block array:[NSArray array] error:nil];
            }
        } else {
            [LCUtils callIdResultBlock:block object:object error:error];
        }
    }];
}

- (void)postFeedbackThread:(NSString *)content block:(AVIdResultBlock)block {
    [self postFeedbackThread:content contact:nil block:block];
}

- (void)postFeedbackThread:(NSString *)content contact:(NSString *)contact block:(AVIdResultBlock)block {
    if ([_userFeedback objectId]) {
        LCUserFeedbackReply *feedbackReply = [LCUserFeedbackReply feedbackReplyWithContent:content type:LCReplyTypeUser];
        [self.userFeedback saveFeedbackReplyInBackground:feedbackReply withBlock:^(id object, NSError *error) {
            [LCUtils callIdResultBlock:block object:object error:error];
        }];
    } else {
        [LCUserFeedbackThread feedbackWithContent:content contact:contact withBlock:^(id object, NSError *error) {
            if (object && !error) {
                self.userFeedback = (LCUserFeedbackThread *)object;
                [self postFeedbackThread:content contact:contact block:block];
            } else {
                [LCUtils callIdResultBlock:block object:nil error:error];
            }
        }];
    }
}

- (void)countUnreadFeedbackThreadsWithBlock:(AVIntegerResultBlock)block {
    [LCUserFeedbackThread fetchFeedbackWithBlock:^(LCUserFeedbackThread *feedback, NSError *error) {
        if (error) {
            block(0, error);
        } else {
            if (feedback == nil) {
                block(0, nil);
            } else {
                NSString *localKey = [NSString stringWithFormat:@"feedback_%@", feedback.objectId];
                [feedback fetchFeedbackRepliesInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (error) {
                        block(0 ,error);
                    } else {
                        NSUInteger lastThreadsCounts = [[[NSUserDefaults standardUserDefaults] objectForKey:localKey] intValue];
                        NSUInteger unreadCount = objects.count - lastThreadsCounts;
                        block(unreadCount, nil);
                    }
                }];
            }
        }
    }];
}

@end

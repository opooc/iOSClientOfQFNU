//
//  LCUserFeedbackThread.m
//  Feedback
//
//  Created by yang chaozhong on 4/21/14.
//  Copyright (c) 2014 LeanCloud. All rights reserved.
//

#import "LCUserFeedbackThread.h"
#import "LCUserFeedbackThread_Internal.h"
#import "LCUserFeedbackReply.h"
#import "LCUserFeedbackReply_Internal.h"
#import "LCHttpClient.h"
#import "LCUtils.h"

static NSString *const kLCUserFeedbackObjectId = @"LCUserFeedbackObjectId";

@interface LCUserFeedbackThread()

@property(nonatomic, copy) NSString *appSign;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *remarks;
@property(nonatomic, copy) NSString *iid;

@end

#define LC_FEEDBACK_BASE_PATH @"feedback"

@implementation LCUserFeedbackThread

+ (NSString *)objectPath {
    return LC_FEEDBACK_BASE_PATH;
}

- (NSString *)threadsPath {
    return [NSString stringWithFormat:@"%@/%@/threads", LC_FEEDBACK_BASE_PATH, self.objectId];
}

-(NSMutableDictionary *)postData {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (_content) {
        [data setObject:self.content forKey:@"content"];
    }
    
    if (_contact) {
        [data setObject:self.contact forKey:@"contact"];
    }
    
    if (_status) {
        [data setObject:self.status forKey:@"status"];
    }
    
    if (_remarks) {
        [data setObject:self.remarks forKey:@"remarks"];
    }
    _iid = [AVInstallation currentInstallation].objectId;
    if (_iid) {
        [data setObject:self.iid forKey:@"iid"];
    }
    
    return data;
}

-(instancetype)initWithDictionary:(NSDictionary*)dict {
    self = [super init];
    if (self && dict) {
        self.contact = [dict objectForKey:@"contact"];
        self.content = [dict objectForKey:@"content"];
        self.status = [dict objectForKey:@"status"];
        self.iid = [dict objectForKey:@"iid"];
        self.remarks = [dict objectForKey:@"remarks"];
        self.objectId = [dict objectForKey:@"objectId"];
    }
    return self;
}

+(void)fetchFeedbackWithBlock:(LCUserFeedbackBlock)block {
    NSString *feedbackObjectId = [[NSUserDefaults standardUserDefaults] objectForKey:kLCUserFeedbackObjectId];
    if (feedbackObjectId == nil) {
        // do not create empty feedback
        block(nil, nil);
    } else {
        LCHttpClient *client = [LCHttpClient sharedInstance];
        NSString *path = [[LCUserFeedbackThread objectPath] stringByAppendingPathComponent:feedbackObjectId];
        [client getObject:path withParameters:nil block:^(id object, NSError *error) {
            if (error) {
                [LCUtils callIdResultBlock:block object:nil error:error];
            } else {
                if (object) {
                    LCUserFeedbackThread *feedback = [[LCUserFeedbackThread alloc] initWithDictionary:object];
                    [LCUtils callIdResultBlock:block object:feedback error:nil];
                } else {
                    [LCUtils callIdResultBlock:block object:nil error:nil];
                }
            }
        }];
    }
}

+(void)fetchFeedbackWithContact:(NSString*)contact withBlock:(AVIdResultBlock)block {
    LCHttpClient *client = [LCHttpClient sharedInstance];
    [client getObject:[LCUserFeedbackThread objectPath] withParameters:[NSDictionary dictionaryWithObject:contact forKey:@"contact"] block:^(id object, NSError *error) {
        if (error) {
            [LCUtils callIdResultBlock:block object:nil error:error];
        } else {
            [LCUtils callIdResultBlock:block object:object error:nil];
        }
    }];
}

+(void)feedbackWithContent:(NSString *)content
                   contact:(NSString *)contact
                    create:(BOOL)create
                 withBlock:(AVIdResultBlock)block {
    if (create) {
        LCUserFeedbackThread *feedback = [[LCUserFeedbackThread alloc] init];
        feedback.content = content;
        feedback.contact = contact;
        
        LCHttpClient *client = [LCHttpClient sharedInstance];
        [client postObject:[LCUserFeedbackThread objectPath] withParameters:[feedback postData] block:^(id object, NSError *error) {
            if (!error) {
                feedback.objectId = [(NSDictionary *)object objectForKey:@"objectId"];
                [[NSUserDefaults standardUserDefaults] setObject:feedback.objectId forKey:kLCUserFeedbackObjectId];
                [LCUtils callIdResultBlock:block object:feedback error:error];
            } else {
                [LCUtils callIdResultBlock:block object:nil error:error];
            }
        }];
    } else {
        [LCUtils callIdResultBlock:block object:nil error:[NSError new]];
    }
}

+(void)feedbackWithContent:(NSString *)content
                   contact:(NSString *)contact
                 withBlock:(AVIdResultBlock)block {
    [self feedbackWithContent:content contact:contact create:YES withBlock:block];
}


+(void)updateFeedback:(LCUserFeedbackThread *)feedback withBlock:(AVIdResultBlock)block {
    [[LCHttpClient sharedInstance] putObject:[NSString stringWithFormat:@"%@/%@", [LCUserFeedbackThread objectPath], feedback.objectId]
                              withParameters:[feedback postData]
                                       block:^(id object, NSError *error) {
                                           [LCUtils callIdResultBlock:block object:object error:error];
                                       }];
}

+(void)deleteFeedback:(LCUserFeedbackThread *)feedback withBlock:(AVIdResultBlock)block {
    [[LCHttpClient sharedInstance] deleteObject:[NSString stringWithFormat:@"%@/%@", [LCUserFeedbackThread objectPath], feedback.objectId]
                                 withParameters:nil
                                          block:^(id object, NSError *error) {
                                              [LCUtils callIdResultBlock:block object:object error:error];
                                          }];
}

- (NSDictionary *)parametersWithFeedbackReply:(LCUserFeedbackReply *)feedbackReply {
    NSMutableDictionary *parameters = [[feedbackReply dictionary] mutableCopy];

    parameters[@"feedback"] = self.objectId;

    return [parameters copy];
}

- (void)saveFeedbackReplyInBackground:(LCUserFeedbackReply *)feedbackReply withBlock:(AVIdResultBlock)block {
	if (!self.objectId) return;
    [[LCHttpClient sharedInstance] postObject:[self threadsPath] withParameters:[self parametersWithFeedbackReply:feedbackReply] block:^(id object, NSError *error){
        if (!error) {
            feedbackReply.createAt = [object objectForKey:@"createdAt"];
        }
        [LCUtils callIdResultBlock:block object:object error:error];
    }];
}

- (void)fetchFeedbackRepliesInBackgroundWithBlock:(AVArrayResultBlock)block {
    [[LCHttpClient sharedInstance] getObject:[self threadsPath]
                              withParameters:nil
                                       block:^(id object, NSError *error)
    {
        NSArray *results = [object objectForKey:@"results"];
        NSMutableArray *replies = [NSMutableArray arrayWithCapacity:[results count]];

        for (NSDictionary *dictionary in results) {
            [replies addObject:[[LCUserFeedbackReply alloc] initWithDictionary:dictionary]];
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (LCUserFeedbackReply *reply in replies) {
                if (reply.attachment) {
                    AVFile *attachmentFile = [AVFile fileWithURL:reply.attachment];
                    NSError *error;
                    NSData *data;
                    data = [attachmentFile getData:&error];
                    if (error) {
                        FLog(@"attachment getData error");
                    } else {
                        reply.attachmentImage = [UIImage imageWithData:data];
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [LCUtils callArrayResultBlock:block array:replies error:error];
            });
        });
    }];
}

@end

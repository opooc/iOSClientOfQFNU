//
//  LCUserFeedbackAgent.h
//  Feedback
//
//  Created by yang chaozhong on 4/22/14.
//  Copyright (c) 2014 LeanCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVConstants.h"

@interface LCUserFeedbackAgent : NSObject

#pragma mark - methods

/**
 *  AVUserFeedbackAgent 实例
 */
+(instancetype)sharedInstance;

/**
 *  打开默认用户反馈界面
 *  @param viewController 默认的用户反馈界面将会展示在 viewController 之上，可以设置为当前的 viewController，比如 self。
 *  @param title 反馈标题，如果传 nil，默认将 thread 中的第一条反馈消息作为标题。
 *  @param contact 联系方式，邮箱或qq。
 */
- (void)showConversations:(UIViewController *)viewController title:(NSString *)title contact:(NSString *)contact;

/**
 *  统计未读反馈数目
 *
 *  @param block 结果回调。
 *  @discussion 可用来设置小红点，提醒用户查看反馈
 */
- (void)countUnreadFeedbackThreadsWithBlock:(AVIntegerResultBlock)block;

/**
 *  从服务端同步反馈回复，按照 contact 同步。
 *  @param title 该字段已废弃，应该传 nil。
 *  @param contact 联系方式，邮箱或qq。
 *  @param block 结果回调。
 *  @discussion 可以在 block 中处理反馈数据 (AVUserFeedbackThread 数组)，然后将其传入自定义用户反馈界面。
 */
- (void)syncFeedbackThreadsWithBlock:(NSString *)title contact:(NSString *)contact block:(AVArrayResultBlock)block AV_DEPRECATED("Use -syncFeedbackThreadsWithContact:block: instead");

/**
 *  从服务端同步反馈回复，按照 contact 同步。
 *  @param contact 联系方式，邮箱或qq。
 *  @param block 结果回调。
 *  @discussion 可以在 block 中处理反馈数据 (AVUserFeedbackThread 数组)，然后将其传入自定义用户反馈界面。
 */
- (void)syncFeedbackThreadsWithContact:(NSString *)contact block:(AVArrayResultBlock)block  AV_DEPRECATED("Because now feedback module is an open source project, you should tweak the UI in LCUserFeedbackViewController, do not make new UI and sync feedback threads by your own.");

/**
 *  发送用户反馈
 *  @param content 同上，用户反馈内容。
 *  @param block 结果回调。
 */
- (void)postFeedbackThread:(NSString *)content block:(AVIdResultBlock)block AV_DEPRECATED("Use -postFeedbackThread:contact:block: instead");

/**
 *  发送用户反馈
 *  @param content 同上，用户反馈内容。
 *  @param contact 联系方式，邮箱或qq。
 *  @param block 结果回调。
 */
- (void)postFeedbackThread:(NSString *)content contact:(NSString *)contact block:(AVIdResultBlock)block AV_DEPRECATED("Because now feedback module is an open source project, you should tweak the UI in LCUserFeedbackViewController, do not make new UI and post feedback by your own.");

@end

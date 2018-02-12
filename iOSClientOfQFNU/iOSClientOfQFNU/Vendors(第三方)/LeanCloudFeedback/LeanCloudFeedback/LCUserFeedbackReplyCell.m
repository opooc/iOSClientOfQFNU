//
//  LCUserFeedbackCell.m
//
//  Created by yang chaozhong on 4/24/14.
//  Copyright (c) 2014 LeanCloud. All rights reserved.
//

#import "LCUserFeedbackReplyCell.h"
#import "LCUserFeedbackReply.h"

static CGFloat const kLabelVerticalPadding = 10;
static CGFloat const kTimestampLabelHeight = 18;
static CGFloat const kMaxiumCellWidth = 226;
static CGFloat const kBubbleHorizontalPadding = 10;
static CGFloat const kContentHorizontalPadding = 10;
static CGFloat const kContentVerticalPadding = 10;

static CGFloat const kBubbleArrowHeight = 14; /**< 气泡尖嘴的高度 */

@interface LCUserFeedbackReplyCell()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *timestampLabel;

@property (nonatomic, strong) UIImageView *bubbleImageView;

@property (nonatomic, strong) LCUserFeedbackReply *feedbackReply;

@end

@implementation LCUserFeedbackReplyCell

#pragma mark - life cycle

- (id)initWithFeedbackReply:(LCUserFeedbackReply *)reply reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupWithFeedbackReply:reply];
    }
    return self;
}

- (void)setupWithFeedbackReply:(LCUserFeedbackReply *)reply {
    self.backgroundColor = [UIColor clearColor];
    [self setupTextLabel];
    [self setupImageView];
    [self.contentView addSubview:self.timestampLabel];
    switch (reply.contentType) {
        case LCContentTypeText:
            [self.contentView insertSubview:self.bubbleImageView belowSubview:self.textLabel];
            break;
        case LCContentTypeImage:
            [self.contentView insertSubview:self.bubbleImageView belowSubview:self.imageView];
            break;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - property

- (void)setupTextLabel {
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0f) {
        self.textLabel.backgroundColor = [UIColor whiteColor];
    }
    self.textLabel.font = [[LCUserFeedbackReplyCell appearance] cellFont];
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.numberOfLines = 0;
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.textColor = [UIColor blackColor];
}

- (void)setupImageView {
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.userInteractionEnabled = YES;
}

- (UILabel *)timestampLabel {
    if (_timestampLabel == nil) {
        _timestampLabel = [[UILabel alloc] init];
        _timestampLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _timestampLabel.textAlignment = NSTextAlignmentCenter;
        _timestampLabel.backgroundColor = [UIColor clearColor];
        _timestampLabel.font = [UIFont systemFontOfSize:9.0f];
        _timestampLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
        _timestampLabel.frame = CGRectMake(0.0f, kLabelVerticalPadding, self.bounds.size.width, kTimestampLabelHeight);
    }
    return _timestampLabel;
}

- (UIImageView *)bubbleImageView {
    if (_bubbleImageView == nil) {
        _bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _bubbleImageView;
}

#pragma mark - size or frame

+ (CGSize)getBubbleSizeWithReply:(LCUserFeedbackReply *)reply {
    CGSize bubbleSize;
    switch (reply.contentType) {
        case LCContentTypeText: {
            bubbleSize = [self caculateLabelSizeForText:reply.content];
            break;
        }
        case LCContentTypeImage:
            bubbleSize = CGSizeMake(120, 120);
            break;
    }
    bubbleSize = CGSizeMake(bubbleSize.width + kContentHorizontalPadding * 2, bubbleSize.height + kContentVerticalPadding * 2);
    bubbleSize.height += kBubbleArrowHeight;
    return bubbleSize;
}

+ (CGFloat)heightForFeedbackReply:(LCUserFeedbackReply *)reply {
    CGFloat height = kTimestampLabelHeight + 2 * kLabelVerticalPadding;
    CGSize bubbleSize = [self getBubbleSizeWithReply:reply];
    height += bubbleSize.height;
    return height;
}

- (CGRect)bubbleFrame {
    CGSize bubbleSize = [[self class] getBubbleSizeWithReply:self.feedbackReply];
    
    CGFloat paddingX = kBubbleHorizontalPadding;
    if (self.feedbackReply.type == LCReplyTypeUser) {
        paddingX = CGRectGetWidth(self.bounds) - bubbleSize.width - kBubbleHorizontalPadding;
    }
    CGFloat originY = CGRectGetMaxY(self.timestampLabel.frame) + kLabelVerticalPadding;
    return CGRectMake(paddingX, originY, bubbleSize.width, bubbleSize.height);
}
/**
 *  气泡去除掉尖嘴的 frame
 */
- (CGRect)bubbleContentFrame {
    CGRect contentFrame = [self bubbleFrame];
    switch (self.feedbackReply.type) {
        case LCReplyTypeDev: {
            // 尖嘴在上方
            contentFrame.origin.y += kBubbleArrowHeight;
            contentFrame.size.height -= kBubbleArrowHeight;
        }
            break;
        case LCReplyTypeUser:
            // 尖嘴在下方
            contentFrame.size.height -= kBubbleArrowHeight;
            break;
    }
    return contentFrame;
}

#pragma mark - configuare

- (void)configuareCellWithFeedbackReply:(LCUserFeedbackReply *)reply {
    for (UIGestureRecognizer *recognizer in self.contentView.gestureRecognizers) {
        [self.imageView removeGestureRecognizer:recognizer];
    }
    
    self.feedbackReply = reply;
    self.bubbleImageView.image = [self backgroundImageForFeedbackReply:reply];
    self.timestampLabel.text = [self formatDateString:reply.createAt];
    switch (reply.contentType) {
        case LCContentTypeText:
            self.textLabel.text = reply.content;
            break;
        case LCContentTypeImage:
            self.imageView.image =  reply.attachmentImage;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
            tap.delegate = self;
            tap.cancelsTouchesInView = NO;
            [self.imageView addGestureRecognizer:tap];
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bubbleFrame = [self bubbleFrame];
    self.bubbleImageView.frame = bubbleFrame;
    CGRect contentFrame = [self bubbleContentFrame];
    CGRect innerContentFrame = CGRectMake(CGRectGetMinX(contentFrame) + kContentHorizontalPadding, CGRectGetMinY(contentFrame) + kContentVerticalPadding, CGRectGetWidth(contentFrame) - kContentHorizontalPadding * 2, CGRectGetHeight(contentFrame) - kContentVerticalPadding * 2);
    switch (self.feedbackReply.contentType) {
        case LCContentTypeText: {
            self.textLabel.frame = innerContentFrame;
            break;
        }
        case LCContentTypeImage: {
            self.imageView.frame = innerContentFrame;
            break;
        }
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.timestampLabel.text = nil;
    self.textLabel.text = nil;
    self.imageView.image = nil;
    self.bubbleImageView.image = nil;
}

#pragma mark - action

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateEnded) {
        if ([self.delegate respondsToSelector:@selector(didSelectImageViewOnFeedbackReply:)]) {
            [self.delegate didSelectImageViewOnFeedbackReply:self.feedbackReply];
        }
    }
}

#pragma mark - utils

+ (CGSize)caculateLabelSizeForText:(NSString *)text {
    UILabel *gettingSizeLabel = [[UILabel alloc] init];
    gettingSizeLabel.font = [[LCUserFeedbackReplyCell appearance] cellFont];
    gettingSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    gettingSizeLabel.numberOfLines = 0;
    gettingSizeLabel.text = text;
    CGSize maxiumLabelSize = CGSizeMake(kMaxiumCellWidth, MAXFLOAT);
    return [gettingSizeLabel sizeThatFits:maxiumLabelSize];
}

- (UIImage *)backgroundImageForFeedbackReply:(LCUserFeedbackReply *)reply {
	if (reply.type == LCReplyTypeDev) {
		return [[UIImage imageNamed:@"feedback_bg_1"] stretchableImageWithLeftCapWidth:20 topCapHeight:16];
	} else {
		return [[UIImage imageNamed:@"feedback_bg_2"] stretchableImageWithLeftCapWidth:1 topCapHeight:16];;
	}
}

- (NSString *)formatDateString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark -

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end

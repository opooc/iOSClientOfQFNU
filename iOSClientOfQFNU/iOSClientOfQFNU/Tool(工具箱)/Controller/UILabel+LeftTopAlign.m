//
//  UILabel+LeftTopAlign.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/8/27.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "UILabel+LeftTopAlign.h"

@implementation UILabel (LeftTopAlign)

- (void) textLeftTopAlign
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    CGRect dateFrame =CGRectMake(2, 140, CGRectGetWidth(self.frame)-5, labelSize.height);
    self.frame = dateFrame;
}
@end

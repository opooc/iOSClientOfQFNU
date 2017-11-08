//
//  aboutUsView.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/15.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "AboutUsView.h"

@implementation AboutUsView

+(instancetype)aboutUsView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
- (void)awakeFromNib{
    [super awakeFromNib];
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    _version.text=app_Version;
    
    _ico.layer.cornerRadius = 8;
    _ico.layer.masksToBounds =YES;

}
@end

//
//  aboutUsView.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/15.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *ico;

@property (weak, nonatomic) IBOutlet UILabel *version;

+(instancetype)aboutUsView;

@end

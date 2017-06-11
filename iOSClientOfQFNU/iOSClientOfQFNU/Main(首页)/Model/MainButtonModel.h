//
//  MainButtonModel.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainButtonModel : NSObject

@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* icon;

-(instancetype)initWithDict:(NSDictionary*)dic;
+(instancetype)btnWihtDict:(NSDictionary*)dic;

@end

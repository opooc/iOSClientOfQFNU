//
//  ToolModel.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/8/22.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolModel : NSObject

@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* icon;

-(instancetype)initWithDict:(NSDictionary*)dic;
+(instancetype)btnWihtDict:(NSDictionary*)dic;

@end

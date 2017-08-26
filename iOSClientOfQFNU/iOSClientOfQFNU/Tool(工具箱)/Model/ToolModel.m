//
//  ToolModel.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/8/22.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "ToolModel.h"

@implementation ToolModel

-(instancetype)initWithDict:(NSDictionary*)dic{
    if (self = [super init]) {
        
        self.icon = dic[@"icon"];
        self.name = dic[@"name"];
        
    }
    return self;
    
}

+(instancetype)btnWihtDict:(NSDictionary*)dic{
    
    return [[self alloc]initWithDict:dic];
}


@end

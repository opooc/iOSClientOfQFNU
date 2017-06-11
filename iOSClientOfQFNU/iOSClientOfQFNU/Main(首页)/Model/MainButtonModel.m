//
//  MainButtonModel.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "MainButtonModel.h"

@implementation MainButtonModel

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

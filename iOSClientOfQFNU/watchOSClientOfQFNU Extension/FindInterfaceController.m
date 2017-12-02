//
//  FindInterfaceController.m
//  watchOSClientOfQFNU Extension
//
//  Created by doushuyao on 2017/12/2.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "FindInterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface FindInterfaceController()<WCSessionDelegate>
{
    WCSession * session;
}

@end

@implementation FindInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}
- (IBAction)openCourse {
    if ([WCSession isSupported]) {
        session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
     NSDictionary *dic =session.receivedApplicationContext[@"Coursedic"];
    
    [self pushControllerWithName:@"courseVc" context:dic];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end




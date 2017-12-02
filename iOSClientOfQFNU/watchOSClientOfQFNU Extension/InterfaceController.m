//
//  InterfaceController.m
//  watchOSClientOfQFNU Extension
//
//  Created by doushuyao on 2017/12/2.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "InterfaceController.h"

#import "FindInterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>


@interface InterfaceController()<WCSessionDelegate>
{
    WCSession * session;
}
@property(nonatomic,strong)NSDictionary * allCourseDic;
@property(nonatomic,strong)NSArray* lessonsArr;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *course1;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *course2;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *course3;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *course4;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *course5;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *course6;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *course7;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *course8;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *course9;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *course10;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *course11;

@property(nonatomic,assign)BOOL ok;
@end


@implementation InterfaceController
- (IBAction)sliderChange:(float)value {
    if (value != 0 ){
        [self setBtnvalue:(value-1)];
        [self willActivate];
    }
    
    

}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    _allCourseDic =context;
    _ok = YES;
    // Configure interface objects here.
}



- (void)willActivate {
    [super willActivate];
    
    
    if (_ok == YES) {
        _lessonsArr = [_allCourseDic objectForKey:@"lessons"];
        [self setBtnvalue:0];
        _ok = NO;
    }
    
}
-(void)setBtnvalue:(int)i{
     NSArray*day1 = [_lessonsArr objectAtIndex:i];
    if ([[day1 objectAtIndex:0]count]==1) {
        NSString* nameStr = [[day1 objectAtIndex:0]objectForKey:@"name"];
        [_course1 setTitle:nameStr];
    }else{
        [_course1 setTitle:@"无"];
    }
    
    
    if ([[day1 objectAtIndex:1]count]==1) {
        NSString* nameStr = [[day1 objectAtIndex:1]objectForKey:@"name"];
        [_course2 setTitle:nameStr];
    }else{
        [_course2 setTitle:@"无"];
    }
    
    
    if ([[day1 objectAtIndex:2]count]==1) {
        NSString* nameStr = [[day1 objectAtIndex:2]objectForKey:@"name"];
        [_course3 setTitle:nameStr];
    }else{
        [_course3 setTitle:@"无"];
    }
    
    
    if ([[day1 objectAtIndex:3]count]==1) {
        NSString* nameStr = [[day1 objectAtIndex:3]objectForKey:@"name"];
        [_course4 setTitle:nameStr];
    }else{
        [_course4 setTitle:@"无"];
    }
    
    
    if ([[day1 objectAtIndex:4]count]==1) {
        NSString* nameStr = [[day1 objectAtIndex:4]objectForKey:@"name"];
        [_course5 setTitle:nameStr];
    }else{
        [_course5 setTitle:@"无"];
    }
    
    
    if ([[day1 objectAtIndex:5]count]==1) {
        NSString* nameStr = [[day1 objectAtIndex:5]objectForKey:@"name"];
        [_course6 setTitle:nameStr];
    }else{
        [_course6 setTitle:@"无"];
    }
    
    if ([[day1 objectAtIndex:6]count]==1) {
        NSString* nameStr = [[day1 objectAtIndex:6]objectForKey:@"name"];
        [_course7 setTitle:nameStr];
    }else{
        [_course7 setTitle:@"无"];
    }
    
    
    
    if ([[day1 objectAtIndex:7]count]==1) {
        NSString* nameStr = [[day1 objectAtIndex:7]objectForKey:@"name"];
        [_course8 setTitle:nameStr];
    }else{
        [_course8 setTitle:@"无"];
    }
    
    
    if ([[day1 objectAtIndex:8]count]==1) {
        NSString* nameStr = [[day1 objectAtIndex:8]objectForKey:@"name"];
        [_course9 setTitle:nameStr];
    }else{
        [_course9 setTitle:@"无"];
    }
    
    
    if ([[day1 objectAtIndex:9]count]==1) {
        NSString* nameStr = [[day1 objectAtIndex:9]objectForKey:@"name"];
        [_course10 setTitle:nameStr];
    }else{
        [_course10 setTitle:@"无"];
    }
    
    
    if ([[day1 objectAtIndex:10]count]==1) {
        NSString* nameStr = [[day1 objectAtIndex:10]objectForKey:@"name"];
        [_course11 setTitle:nameStr];
    }else{
        [_course11 setTitle:@"无"];
    }
    
    
}
- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}





@end




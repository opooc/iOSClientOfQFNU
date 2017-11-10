//
//  freeRoomCell.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/11/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface freeRoomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *location;

@property (weak, nonatomic) IBOutlet UILabel *type;

@property (nonatomic, strong) NSDictionary *dataSource;
-(void)setDataSource:(NSDictionary *)dataSource;

@end

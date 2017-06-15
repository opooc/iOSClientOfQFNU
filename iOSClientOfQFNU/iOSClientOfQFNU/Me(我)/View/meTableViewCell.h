//
//  meTableViewCell.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/12.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface meTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *contenLabel;

//@property (nonatomic, strong) UILabel *dateLabel;


@property (nonatomic, strong) NSDictionary *dataSource;
@property (weak, nonatomic) IBOutlet UILabel *DataLable;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;

@end



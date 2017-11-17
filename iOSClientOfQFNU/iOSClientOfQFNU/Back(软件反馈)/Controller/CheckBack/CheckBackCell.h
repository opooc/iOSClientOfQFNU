//
//  CheckBackCell.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/11/17.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckBackCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *touxiang;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *wayLable;
@property (weak, nonatomic) IBOutlet UILabel *noteLable;

@property(nonatomic,strong )NSDictionary* checkDataSource;

-(void)setCheckDataSource:(NSDictionary *)checkDataSource;


@end

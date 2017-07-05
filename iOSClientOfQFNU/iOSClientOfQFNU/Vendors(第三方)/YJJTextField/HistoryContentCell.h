//
//  HistoryContentCell.h
//  MyTextFieldDemo
//
//  Created by arges on 2017/6/22.
//  Copyright © 2017年 ArgesYao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryContentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

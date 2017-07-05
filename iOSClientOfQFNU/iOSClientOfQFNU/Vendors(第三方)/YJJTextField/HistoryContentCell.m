//
//  HistoryContentCell.m
//  MyTextFieldDemo
//
//  Created by arges on 2017/6/22.
//  Copyright © 2017年 ArgesYao. All rights reserved.
//

#import "HistoryContentCell.h"

@implementation HistoryContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"historyContent";
    HistoryContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    }
    
    return cell;
}

@end

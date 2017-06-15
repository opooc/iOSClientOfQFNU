//
//  meTableViewCell.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/12.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "meTableViewCell.h"

@implementation meTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
   // [self initUI];
    
    return self;
}
/**
 *  初始化UI
 */
//-(void)initUI{
//    _contenLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 20)];
//    _contenLabel.textColor = [UIColor blackColor];
//    _contenLabel.font = [UIFont systemFontOfSize:15];
//    [self.contentView addSubview:_contenLabel];
//    
//    
//    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_contenLabel.frame)+5, SCREEN_WIDTH-40, 20)];
//    _dateLabel.textColor = [UIColor lightGrayColor];
//    _dateLabel.font = [UIFont systemFontOfSize:14];
//    [self.contentView addSubview:_dateLabel];
//    
//}
//


-(void)setDataSource:(NSDictionary *)dataSource{
    _dataSource = dataSource;
//    _contenLabel.text = dataSource[@"title"];
//    _dateLabel.text = dataSource[@"date"];
    
    _DataLable.text = dataSource[@"title"];
    _TimeLable.text = dataSource[@"date"];
    
    
    
}

@end

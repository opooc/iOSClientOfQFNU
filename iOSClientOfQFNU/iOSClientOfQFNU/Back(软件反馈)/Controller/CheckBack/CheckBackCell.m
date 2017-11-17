//
//  CheckBackCell.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/11/17.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "CheckBackCell.h"

@implementation CheckBackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _touxiang.layer.cornerRadius = _touxiang.frame.size.width*0.5;
    _touxiang.layer.borderWidth = 0.2;
    _touxiang.layer.borderColor = [[UIColor orangeColor]CGColor];
    _touxiang.layer.masksToBounds = YES;
    
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    return [super initWithStyle:style reuseIdentifier:reuseIdentifier];
}
-(void)setCheckDataSource:(NSDictionary *)checkDataSource{
    _nameLable.text = [checkDataSource objectForKey:@"name"];
    _timeLable.text = [checkDataSource objectForKey:@"time"];
    _wayLable.text  = [checkDataSource objectForKey:@"way"];
    _noteLable.text = [checkDataSource objectForKey:@"note"];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

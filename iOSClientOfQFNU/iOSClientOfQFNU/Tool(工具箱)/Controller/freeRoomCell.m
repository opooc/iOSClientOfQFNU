//
//  freeRoomCell.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/11/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "freeRoomCell.h"

@implementation freeRoomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    return self;
}

-(void)setDataSource:(NSDictionary *)dataSource{
    _dataSource = dataSource;
    NSString* locationStr =[_dataSource objectForKey:@"classroom"];
    NSLog(@"%@",locationStr);
    _location.text = locationStr;
    _type.text = [_dataSource objectForKey:@"type"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

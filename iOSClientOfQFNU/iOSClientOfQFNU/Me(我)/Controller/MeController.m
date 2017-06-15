//
//  MeController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/12.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "MeController.h"
#import "meTableViewCell.h"
#import "meTableHeadView.h"

@interface MeController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MeController
{
    UITableView *_tableView;
    
    NSArray *dataSource;
    
    meTableHeadView *head;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
/**
 *  初始化UI
 */
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.navigationController.navigationBar.subviews[0].alpha = 0;
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    dataSource = @[@{@"title":@"下午三点要开会，记得提醒我下午三点要开会，记得提醒我下午三点要开会，记得提醒我下午三点要开会，记得提醒我",@"date":@"6-12"},@{@"title":@"下午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开午三点要开会，记得提醒我",@"date":@"6-12"},@{@"title":@"下午三点要开会，记得提醒我下午三点要开会，记得提醒我下午三点要开会，记得提醒我下午三点要开会，记得提醒我",@"date":@"6-12"},@{@"title":@"下午三点要开会，记得提醒我下午三点要开会，记得提醒我下午三点要开会，记得提醒我下午三点要开会，记得提醒我",@"date":@"6-12"},@{@"title":@"下午三点要开会，记得提醒我下午三点要开会，记得提醒我下午三点要开会，记得提醒我下午三点要开会，记得提醒我",@"date":@"6-12"}];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.masksToBounds = false;
    
    _tableView.estimatedRowHeight = 80;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
         //表示tableViewCell 动态返回
    
    //    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    //    footView.backgroundColor = [UIColor blueColor];
    //    _tableView.tableFooterView = footView;      //去除多余的横线
    
    _tableView.tableFooterView = [[UIView alloc]init];

    
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"meTableViewCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
    
    
    head = [[meTableHeadView alloc]init];
    _tableView.tableHeaderView = head;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = dataSource[indexPath.row];
    meTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    cell.dataSource = dict;
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = _tableView.contentOffset.y;
    CGFloat Alpha = offset/(SCREEN_WIDTH/4*3);
    self.navigationController.navigationBar.subviews[0].alpha = Alpha;
    
    if (offset<0) {
        head.bg.frame = CGRectMake(0, -64+offset, SCREEN_WIDTH, SCREEN_WIDTH/4*3-offset);
    }
    
    
}


/**
 *  分割线顶头
 */
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    
    [_tableView setLayoutMargins:UIEdgeInsetsZero];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
}



@end

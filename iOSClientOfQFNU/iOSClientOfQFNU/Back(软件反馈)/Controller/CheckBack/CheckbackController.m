//
//  CheckbackController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/11/17.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "CheckbackController.h"

@interface CheckbackController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* checkView;

@end

@implementation CheckbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView* checkView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self setupRefresh:checkView];
    checkView.delegate = self;
    checkView.dataSource  =self;
    
}
-(void)setupRefresh:(UITableView*)roomtableView{
    UIView* footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0,roomtableView.frame.size.width , 0);
   
    
    UILabel* footerLable = [[UILabel alloc]init];
    footerLable.frame = footer.bounds;
    footerLable.backgroundColor  =[UIColor redColor];
    footerLable.text = @"上拉可以加载更多";
    footerLable.textColor = [UIColor whiteColor];
    footerLable.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:footerLable];
   
    
    _checkView.tableFooterView = footer;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 0;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

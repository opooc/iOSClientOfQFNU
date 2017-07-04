//
//  LeftViewController.m
//  iOSClientOfQFNU
//
//  Created by lyngame on 2017/6/29.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (weak, nonatomic) IBOutlet UILabel *namelb;
@property (strong,nonatomic)NSArray *dataArray;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createdata];
    _tb.delegate=self;
    _tb.dataSource=self;
    _tb.showsVerticalScrollIndicator = NO;   //关右侧滑动条
    _tb.separatorStyle = NO;    //关线
    _tb.bounces=NO;   //关弹簧
}
-(void)createdata{
    _dataArray=[[NSArray alloc]init];
    _dataArray=[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"每日一览",@"我的课表",@"周课表",@"信息门户",nil],[NSArray arrayWithObjects:@"图书馆",@"校园资讯",@"教务资讯",nil],[NSArray arrayWithObjects:@"工具箱",@"软件反馈",@"软件分享",@"关于我们",@"软件设置",nil],nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView的协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return  array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * ID = @"e";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    //取出对应组的数据数组
    NSArray *array = self.dataArray[indexPath.section];
    //取出对应行的食谱模型

    
    cell.textLabel.text = array[indexPath.row];
    
    //设置图片
    
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 20)];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    NSArray *titleArray = @[@"| 学习工具  >",@"| 校园生活  >",@"| 其他功能  >"];
    label.text = titleArray[section];
    return label;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"你点击的是%@组%@行",indexPath.section,indexPath.row);
    //http://m.5read.com/4581 图书馆
    //www.qfnu.edu.cn  校园资讯
    
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

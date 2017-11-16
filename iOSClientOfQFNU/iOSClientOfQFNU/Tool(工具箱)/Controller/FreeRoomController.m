//
//  FreeRoomController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/11/8.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "FreeRoomController.h"
#import "BRPickerView.h"
#import "BRTextField.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NHAdd.h"
#import "freeRoomCell.h"

@interface FreeRoomController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic,strong)UITableView* roomtableView;
/** 上拉刷新控件 */
@property (nonatomic, weak) UIView *footer;
/** 上拉刷新控件里面的文字 */
@property (nonatomic, weak) UILabel *footerLabel;
/** 上拉刷新控件时候正在刷新 */
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;

/** 地区 */
@property (nonatomic, strong) BRTextField *addressTF;
/** 学历 */
@property (nonatomic, strong) BRTextField *educationTF;
/** 其它 */
@property (nonatomic, strong) BRTextField *otherTF;

@property (nonatomic, strong) NSArray *titleArr;

@property(nonatomic,strong)NSArray *roomData;

@end

@implementation FreeRoomController
{
    int bulidingnum;
    int campusnum;
    int weeknum;
    int timenum;
    int sessionnum;
    MBProgressHUD *hud;
}

- (void)viewDidLoad {
    self.navigationItem.title = @"无课自习室查询";
    self.automaticallyAdjustsScrollViewInsets = false;
   // self.navigationController.navigationBar.subviews[0].alpha = 0;
 
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:236.0 green:126.0/255.0 blue:152.0/255.0 alpha:0.5];
    //选择器的tableV
    self.tableView.hidden = NO;
    
    //自习室的tableV
    
//    self.roomtableView.hidden = NO;
//    self.roomtableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
//    self.roomtableView.scrollIndicatorInsets = self.roomtableView.contentInset;
//    [_roomtableView registerNib:[UINib nibWithNibName:@"freeRoomCell" bundle:nil] forCellReuseIdentifier:@"freeroom"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"查询" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveBtn)];
    
    
}
- (void)clickSaveBtn {
    _roomtableView =nil;
    NSLog(@"查询");
    
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    hud.label.text = NSLocalizedString(@"数据加载中...", @"Please wait a little!");
    
    // Set the details label text. Let's make it multiline this time.
    
    hud.detailsLabel.text = NSLocalizedString(@"Please Wait a minute！", @"HUD title");
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSLog(@"bulidingnum:%d--campusnum:%d--weeknum:%d--timenum:%d--sessionnum:%d",bulidingnum,campusnum,weeknum,timenum,sessionnum);
        
        AFHTTPSessionManager* manager =[AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"wG63PyJ_Lb9l3ZKXk-5KApObBcXKI_I1" forHTTPHeaderField:@"Authorization"];
        
        NSString*  bulidingnumStr = [NSString stringWithFormat:@"%d",bulidingnum];
        NSString*  campusnumStr = [NSString stringWithFormat:@"%d",campusnum];
        NSString*  weeknumStr = [NSString stringWithFormat:@"%d",weeknum];
        NSString*  timenumStr = [NSString stringWithFormat:@"%d",timenum];
        NSString*  sessionnumStr = [NSString stringWithFormat:@"%d",sessionnum];
        
        
        NSDictionary* dic = @{@"building":bulidingnumStr,
                              @"campus":campusnumStr,
                              @"week":weeknumStr,
                              @"time":timenumStr,
                              @"session":sessionnumStr
                              };
//        NSDictionary* dic = @{@"building":@"1",
//                              @"campus":@"1",
//                              @"week":@"1",
//                              @"time":@"1",
//                              @"session":@"1"
//                              };
        NSString *domainStr = @"https://zsqy.illidan.cn/urp/free-room";
        [manager POST:domainStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
           // if ([[dic objectForKey:@"status"]isEqualToString:@"1"])
            {
                  _roomData = [dic objectForKey:@"data"];
                if (_roomData.count != 0 ) {
                    NSLog(@"dic %@",_roomData);
                    self.roomtableView.hidden = NO;
                    self.roomtableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
                    self.roomtableView.scrollIndicatorInsets = self.roomtableView.contentInset;
                    [_roomtableView registerNib:[UINib nibWithNibName:@"freeRoomCell" bundle:nil] forCellReuseIdentifier:@"freeroom"];
                    [hud hideAnimated:YES];
                }
                else{
                    [hud hideAnimated:YES];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       
                        [MBProgressHUD showError:@"老铁，你的输入条件有误" toView:self.view];
                        
                    });
                   
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                }
//                NSLog(@"dic %@",_roomData);
//                self.roomtableView.hidden = NO;
//                self.roomtableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
//                self.roomtableView.scrollIndicatorInsets = self.roomtableView.contentInset;
//                [_roomtableView registerNib:[UINib nibWithNibName:@"freeRoomCell" bundle:nil] forCellReuseIdentifier:@"freeroom"];
//                  [hud hideAnimated:YES];
                
        
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [MBProgressHUD showError:@"网络超时，自习室查询失败" toView:self.view];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        
            [self initClasstable];
        });
        
 
   
    
}

-(void)initClasstable{
    
    
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        //_tableView.scrollEnabled = NO;
       // _tableView.contentSize = CGSizeMake(50, 0);
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(UITableView *)roomtableView{
    if(!_roomtableView){
        
        _roomtableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), SCREEN_W, SCREEN_H-CGRectGetMaxY(_tableView.frame))];
        _roomtableView.backgroundColor = [UIColor yellowColor];
        _roomtableView.dataSource = self;
        _roomtableView.delegate = self;
        _roomtableView.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_roomtableView];
        [self setupRefresh:_roomtableView];
    }
    
    return _roomtableView;
}
//设置上拉刷新
-(void)setupRefresh:(UITableView*)roomtableView{
    UIView* footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0,roomtableView.frame.size.width , 0);
    self.footer = footer;
    
    UILabel* footerLable = [[UILabel alloc]init];
    footerLable.frame = footer.bounds;
    footerLable.backgroundColor  =[UIColor redColor];
    footerLable.text = @"上拉可以加载更多";
    footerLable.textColor = [UIColor whiteColor];
    footerLable.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:footerLable];
    self.footerLabel = footerLable;
    
    self.roomtableView.tableFooterView = footer;
}


#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([tableView isEqual:_tableView]) {
        return 1;
    }else if([ tableView isEqual:_roomtableView]){
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_tableView]) {
       return self.titleArr.count;
    }else if([ tableView isEqual:_roomtableView]){
        return self.roomData.count;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_tableView]) {
        
    
    static NSString *cellID = @"testCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.textLabel.textColor = RGB_HEX(0x464646, 1.0f);
    NSString *title = [self.titleArr objectAtIndex:indexPath.row];
    if ([title hasPrefix:@"* "]) {
        NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc]initWithString:title];
        [textStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[[textStr string]rangeOfString:@"* "]];
        cell.textLabel.attributedText = textStr;
    } else {
        cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    }
    
    switch (indexPath.row) {
        
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupAddressTF:cell];
        }
            break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupsolo:cell];
        }
             break;
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupOtherTF:cell];
        }
            break;
            
            
        default:
            break;
    }
    
        return cell;
        
    }
    else if ([tableView isEqual:_roomtableView]){
        
         NSDictionary *dict = _roomData[indexPath.row];
        freeRoomCell*  roomCell = [tableView dequeueReusableCellWithIdentifier:@"freeroom" forIndexPath:indexPath];
        
        roomCell.dataSource = dict;
        
        
        return  roomCell;
    }
    return  nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (BRTextField *)getTextField:(UITableViewCell *)cell {
    BRTextField *textField = [[BRTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 230, 0, 200, 50)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16.0f];
    textField.textAlignment = NSTextAlignmentRight;
    textField.textColor = RGB_HEX(0x666666, 1.0);
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}


#pragma mark - * 校区&教学楼 textField
- (void)setupAddressTF:(UITableViewCell *)cell {
    if (!_addressTF) {
        _addressTF = [self getTextField:cell];
        _addressTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _addressTF.tapAcitonBlock = ^{
            [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@0, @0] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
                NSLog(@"%@%@",selectAddressArr[0], selectAddressArr[1]);
                weakSelf.addressTF.text = [NSString stringWithFormat:@"%@%@", selectAddressArr[0], selectAddressArr[1]];
                NSString* campus  = selectAddressArr[0];
                NSString* building = selectAddressArr[1];
                if ([campus isEqualToString:@"曲阜校区"]) {
                    campusnum = 1;
                    if ([building isEqualToString:@"班会楼"]) {
                        bulidingnum = 0;
                    }
                    else if([building isEqualToString:@"原音乐楼"]){
                        bulidingnum = 1;
                        
                    }else if([building isEqualToString:@"外语楼"]){
                        bulidingnum = 2;
                        
                    }else if([building isEqualToString:@"书法楼"]){
                        bulidingnum = 3;
                        
                    }else if([building isEqualToString:@"教育楼"]){
                        bulidingnum = 5;
                        
                    }else if([building isEqualToString:@"数学楼"]){
                        bulidingnum = 6;
                        
                    }else if([building isEqualToString:@"化学楼"]){
                        bulidingnum = 7;
                        
                    }else if([building isEqualToString:@"8号(原地理楼)"]){
                        bulidingnum = 8;
                        
                    }else if([building isEqualToString:@"物理楼"]){
                        bulidingnum = 9;
                        
                    }else if([building isEqualToString:@"综合教学楼"]){
                        bulidingnum = 10;
                        
                    }else if([building isEqualToString:@"生物楼"]){
                        bulidingnum = 11;
                        
                    }else if([building isEqualToString:@"老文史楼"]){
                        bulidingnum = 12;
                        
                    }else if([building isEqualToString:@"文史楼"]){
                        bulidingnum = 13;
                        
                    }else if([building isEqualToString:@"体育楼"]){
                        bulidingnum = 14;
                        
                    }else if([building isEqualToString:@"实验中心A区"]){
                        bulidingnum = 15;
                        
                    }else if([building isEqualToString:@"实验中心B区"]){
                        bulidingnum = 16;
                        
                    }else if([building isEqualToString:@"实验中心C区"]){
                        bulidingnum = 17;
                        
                    }else if([building isEqualToString:@"实验中心D区"]){
                        bulidingnum = 18;
                        
                    }else if([building isEqualToString:@"科技实验楼"]){
                        bulidingnum = 19;
                        
                    }else if([building isEqualToString:@"老干部楼"]){
                        bulidingnum = 20;
                        
                    }else if([building isEqualToString:@"西联教室"]){
                        bulidingnum = 21;
                        
                    }else if([building isEqualToString:@"东门开发房"]){
                        bulidingnum = 22;
                        
                    }
                    
                }
                else {
                    campusnum = 2;
                    if ([building isEqualToString:@"教学楼A"]) {
                        bulidingnum = 0;
                    }else if ([building isEqualToString:@"教学楼B"]){
                        bulidingnum = 1;
                    }else if ([building isEqualToString:@"教学楼C"]){
                        bulidingnum = 2;
                    }
                    else if ([building isEqualToString:@"教学楼D"]){
                        bulidingnum = 3;
                    }
                    else if ([building isEqualToString:@"教学楼E"]){
                        bulidingnum = 4;
                    }
                    else if ([building isEqualToString:@"实验中心"]){
                        bulidingnum = 5;
                    }
                    else if ([building isEqualToString:@"美术楼"]){
                        bulidingnum = 6;
                    }
                    else if ([building isEqualToString:@"音乐楼"]){
                        bulidingnum = 7;
                    }else if ([building isEqualToString:@"教学楼S"]){
                        bulidingnum = 8;
                    }
                }
            }];
        };
    }
}

-(void)setupsolo:(UITableViewCell*) cell{
    
    if (!_educationTF) {
        _educationTF = [self getTextField:cell];
        _educationTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _educationTF.tapAcitonBlock = ^{
            
            [BRStringPickerView showStringPickerWithTitle:@"周次" dataSource:@[@"第1周", @"第2周", @"第3周", @"第4周", @"第5周", @"第6周", @"第7周", @"第8周", @"第9周", @"第10周", @"第11周", @"第12周", @"第13周", @"第14周", @"第15周", @"第16周", @"第17周", @"第18周", ] defaultSelValue:@"第1周" isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.educationTF.text = selectValue;
                NSString* week =selectValue;
                if ([week isEqualToString:@"第1周"]) {
                    weeknum = 1;
                    
                    
                }else if ([week isEqualToString:@"第2周"]){
                    weeknum = 2;
                    
                }else if ([week isEqualToString:@"第3周"]){
                    weeknum = 3;
                    
                }else if ([week isEqualToString:@"第4周"]){
                    weeknum = 4;
                    
                }else if ([week isEqualToString:@"第5周"]){
                    weeknum = 5;
                    
                }else if ([week isEqualToString:@"第6周"]){
                    weeknum = 6;
                    
                }else if ([week isEqualToString:@"第7周"]){
                    weeknum = 7;
                    
                }else if ([week isEqualToString:@"第8周"]){
                    weeknum = 8;
                    
                }else if ([week isEqualToString:@"第9周"]){
                    weeknum = 9;
                    
                }else if ([week isEqualToString:@"第10周"]){
                    weeknum = 10;
                    
                }else if ([week isEqualToString:@"第11周"]){
                    weeknum = 11;
                    
                }else if ([week isEqualToString:@"第12周"]){
                    weeknum = 12;
                    
                }else if ([week isEqualToString:@"第13周"]){
                    weeknum = 13;
                    
                }else if ([week isEqualToString:@"第14周"]){
                    weeknum = 14;
                    
                }else if ([week isEqualToString:@"第15周"]){
                    weeknum = 15;
                    
                }else if ([week isEqualToString:@"第16周"]){
                    weeknum = 16;
                    
                }else if ([week isEqualToString:@"第17周"]){
                    weeknum = 17;
                    
                }else if ([week isEqualToString:@"第18周"]){
                    weeknum = 18;
                    
                }
                    
                    
                    
                
                
            }];
            
        };
    }
    
}


#pragma mark - * 星期&节次 textField
- (void)setupOtherTF:(UITableViewCell *)cell {
    if (!_otherTF) {
        _otherTF = [self getTextField:cell];
        _otherTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _otherTF.tapAcitonBlock = ^{
            
            NSArray *dataSources = @[@[@"周一", @"周二", @"周三",@"周四",@"周五",@"周六",@"周日"], @[@"第1节", @"第2节", @"第3节", @"第4节", @"第5节", @"第6节",  @"第7节", @"第8节", @"第9节", @"第10节", @"第11节"]];
            [BRStringPickerView showStringPickerWithTitle:@"星期几？第几节？" dataSource:dataSources defaultSelValue:@[@"周一", @"第1节"] isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.otherTF.text = [NSString stringWithFormat:@"%@，%@", selectValue[0], selectValue[1]];
                 NSString* time  = selectValue[0];
                NSString* session =selectValue[1];
                if ([time isEqualToString:@"周一"]) {
                    timenum = 1;
                    
                   
                }else if ([time isEqualToString:@"周二"]){
                    timenum = 2;
                    
                    
                }else if ([time isEqualToString:@"周三"]){
                    timenum = 3;
                    
                }else if ([time isEqualToString:@"周四"]){
                    timenum = 4;
                    
                }else if ([time isEqualToString:@"周五"]){
                    timenum = 5;
                    
                }else if ([time isEqualToString:@"周六"]){
                    timenum = 6;
                    
                }else if ([time isEqualToString:@"周日"]){
                    timenum = 7;
                    
                }
                
                if ([session isEqualToString:@"第1节"]) {
                    sessionnum = 1;
                }else if ([session isEqualToString:@"第2节"]){
                    sessionnum = 2;
                }else if ([session isEqualToString:@"第3节"]){
                    sessionnum = 3;
                }
                else if ([session isEqualToString:@"第4节"]){
                    sessionnum = 4;
                }
                else if ([session isEqualToString:@"第5节"]){
                    sessionnum = 5;
                }
                else if ([session isEqualToString:@"第6节"]){
                    sessionnum = 6;
                }
                else if ([session isEqualToString:@"第7节"]){
                    sessionnum = 7;
                }else if ([session isEqualToString:@"第8节"]){
                    sessionnum = 8;
                }
                else if ([session isEqualToString:@"第9节"]){
                    sessionnum = 9;
                }
                else if ([session isEqualToString:@"第10节"]){
                    sessionnum = 10;
                }
                else {
                    sessionnum = 11;
                }
            }];
        };
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 4) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"* 校区&教学楼", @"* 周次",@"* 星期&节次"];
    }
    return _titleArr;
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // 还没有任何内容的时候，不需要判断
//    if (self.roomtableView.contentSize.height == 0)
//       
//        return;
//  
//    // 如果正在刷新，直接返回
//    if (self.isFooterRefreshing) return;
//    
//    // 当scrollView的偏移量y值 >= offsetY时，代表footer已经完全出现
//    CGFloat ofsetY = self.tableView.contentSize.height + self.roomtableView.contentInset.bottom - self.roomtableView.frame.size.height;
//    
//    if (self.roomtableView.contentOffset.y >= ofsetY) {
//        // 进入刷新状态
//        self.footerRefreshing = YES;
//        self.footerLabel.text = @"正在加载更多数据...";
//        self.footerLabel.backgroundColor = [UIColor blueColor];
//        
//        // 发送请求给服务器
//        NSLog(@"发送请求给服务器 - 加载更多数据");
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 服务器请求回来了
//            //self.dataCount += 5;
//            [self.roomtableView reloadData];
//            
//            // 结束刷新
//            self.footerRefreshing = NO;
//            self.footerLabel.text = @"上拉可以加载更多";
//            self.footerLabel.backgroundColor = [UIColor redColor];
//        });
//    }
//}


//分割线顶头
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [_roomtableView setSeparatorInset:UIEdgeInsetsZero];
    
    [_roomtableView setLayoutMargins:UIEdgeInsetsZero];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_roomtableView]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
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

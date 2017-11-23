//
//  CheckbackController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/11/17.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "CheckbackController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "CheckBackCell.h"

@interface CheckbackController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* checkView;
@property(nonatomic,assign)NSInteger i;
@property(nonatomic,strong)NSArray* checkData;

@end

@implementation CheckbackController{
    NSMutableArray* stmpArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _i =1;

    _checkView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self setupRefresh:_checkView];
    _checkView.delegate = self;
    _checkView.dataSource  =self;
    [self.view addSubview:_checkView];

    [_checkView registerNib:[UINib nibWithNibName:@"CheckBackCell" bundle:nil] forCellReuseIdentifier:@"checkback"];
    
    
    //设置刷新头
    //设置回调(一旦你进入刷新状态，然后调用目标的动作，即调用[self loadNewData])
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingTarget:self  refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
    
    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=60; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [idleImages addObject:image];
//    }
    [header setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    //设置标题
    self.checkView.mj_header = header;
    
    
    
    
    
    
    
    //设置刷新尾
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // Set the normal state of the animated image
    [footer setImages:idleImages forState:MJRefreshStateIdle];
    //  Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
    [footer setImages:refreshingImages forState:MJRefreshStatePulling];
    // Set the refreshing state of animated images
    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // Set footer
    _checkView.mj_footer = footer;
    
    
    [self loadNewData];
}

-(void)loadNewData{
     stmpArr =  [_checkData mutableCopy];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager .responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString* postUrl =@"http://qfnu.vlove.me/opooc/public/index.php/api/v1/param/";
    NSString* newPostUrl = [NSString stringWithFormat:@"%@%ld/5",postUrl,(long)_i];
 NSLog(@"%@",newPostUrl);
    [manager GET:newPostUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        NSArray* newarr = [dic objectForKey:@"data"];
        for (id i in newarr) {
            [stmpArr addObject:i];
        }
        
        _checkData = [stmpArr copy];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self.checkView.mj_header endRefreshing];

    });
    _i  = _i + 5;
    [self.checkView reloadData];
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
    CheckBackCell* cell = [tableView dequeueReusableCellWithIdentifier:@"checkback" ];
    cell.checkDataSource = _checkData[indexPath.row];
    return cell;
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

//
//  QFNUToolController.m
//  QFNU for opooc
//
//  Created by doushuyao on 17/6/5.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "QFNUToolController.h"
#import "CFWebViewController.h"
#import "WeatherViewController.h"
#import "ToolButtonView.h"
#import "xiaoliController.h"

@interface QFNUToolController ()
@property (nonatomic, strong) NSArray* dataArr;

@property(nonatomic,strong)UIView* allMainBtnView;
@end

@implementation QFNUToolController

-(NSArray*)dataArr{
    if (_dataArr ==nil) {
        NSString* dataPath = [[NSBundle mainBundle]pathForResource:@"ToolData" ofType:@"plist"];
        self.dataArr = [NSArray arrayWithContentsOfFile:dataPath];
        NSMutableArray* tempArray = [NSMutableArray array];
        for (NSDictionary* dic in self.dataArr) {
            MainButtonModel* model = [MainButtonModel btnWihtDict:dic];
            [tempArray addObject:model];
        }
        self.dataArr = tempArray;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setButtonView];

}
-(void)setButtonView{
    CGFloat Bwidth = self.view.frame.size.width;
    CGFloat Bheight = self.view.frame.size.height+64+32;

    UIView* allMainBtnView = [[UIView alloc]initWithFrame:CGRectMake(0,64,Bwidth,Bheight*0.5)];
    
    _allMainBtnView = allMainBtnView;
    //_allMainBtnView.backgroundColor = [UIColor brownColor];
    NSInteger allCols = 4;
    
    // 2.商品的宽度 和 高度
    CGFloat width = 80;
    CGFloat height = 80;
    // 3.求出水平间距 和 垂直间距
    CGFloat allMainBtnviewWidth = self.allMainBtnView.frame.size.width;
    CGFloat allMainBtnviewHeight = self.allMainBtnView.frame.size.height;
    CGFloat hMargin = (allMainBtnviewWidth - allCols * width) / (allCols -1);
    CGFloat vMargin = (allMainBtnviewHeight-32 - 4*height) / 1;
    for (int i=0;i<12;i++) {
        // 4. 设置索引
        NSInteger index = self.allMainBtnView.subviews.count;
        // 5.求出x值
        CGFloat x = (hMargin + width) * (index % allCols);
        CGFloat y = (vMargin + height) * (index / allCols);
        
        /***********************.创建一个按钮*****************************/
        ToolButtonView *btnView = [[ToolButtonView alloc] initWithModel:self.dataArr[index]];
        btnView.label.font = [UIFont systemFontOfSize:15];
        btnView.label.textColor = TEXT_GRAYCOLOR;
        
        /*****   根据按钮的编号 添加弹出控制器*/
        if (index== 0) {
            [btnView.btn addTarget:self action:@selector(cet) forControlEvents:UIControlEventTouchUpInside];
        }
      else if (index== 1) {
            [btnView.btn addTarget:self action:@selector(xiaoli) forControlEvents:UIControlEventTouchUpInside];
        }
      else if (index== 2) {
          [btnView.btn addTarget:self action:@selector(weather) forControlEvents:UIControlEventTouchUpInside];
      }
        
        btnView.frame = CGRectMake(x, y, width, height);
        NSLog(@"dataArrrrrrr:%@",_dataArr[index]);
        
        // btnView.backgroundColor = [UIColor blueColor];
        [self.allMainBtnView addSubview:btnView];
        
    }
    
    [self.view addSubview:_allMainBtnView];
    
}
-(void)cet{
    CFWebViewController* cet = [[CFWebViewController alloc]initWithUrl:[NSURL URLWithString:@"http://cet.neea.edu.cn/cet"]];
    [self.navigationController pushViewController:cet animated:YES];
    
}
-(void)xiaoli{
    xiaoliController* xiaoli = [[xiaoliController alloc]init];
    [xiaoli load:@"http://jwc.qfnu.edu.cn/__local/7/E6/90/1AD52DD6E2D4D341A6CFA3DA12A_241AEED1_203B6.pdf"];
    [self.navigationController pushViewController:xiaoli animated:YES];

}

-(void)weather{
    WeatherViewController* weather = [[WeatherViewController alloc]init];
    
    [self.navigationController pushViewController:weather animated:YES];

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

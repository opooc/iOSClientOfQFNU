//
//  MainController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//
#import "QFNUAboutUsController.h"
#import "QFNUBackController.h"
#import "QFNUCConsultController.h"
#import "QFNUCommunityController.h"
#import "QFNUCourseController.h"
#import "QFNULoginController.h"
#import "QFNUNewController.h"
#import "QFNULookController.h"
#import "QFNUToolController.h"
#import "MeController.h"
#import "CFWebViewController.h"
#import "MainController.h"
#import "MainHeadScrollView.h"
#import "MainButtonModel.h"
#import "MainButtonView.h"
#import "MJExtension.h"
#import "UIViewController+LGSideMenuController.h"
#import "LGSideMainViewController.h"
#import "QFInfo.h"
#import "MBProgressHUD+NHAdd.h"

#import "UIColor+FlatColors.h"

@interface MainController ()
@property (assign, nonatomic) NSUInteger type;
@property (nonatomic,strong) MainHeadScrollView* scrollView;
@property (nonatomic, strong) NSArray* dataArr;

@property(nonatomic,strong)UIView* allMainBtnView;

@end

@implementation MainController
int dayx;
CGFloat barheight;




- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setMainHeadScrollView];

//        self.navigationController.navigationBar.translucent=NO;
    

    UIImage *menu=[UIImage imageNamed:@"menu"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:menu
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showLeftView)];
    [self setbar];
    [self setlist];
    [self loadGIF];
    [MBProgressHUD showLoadToView:self.view title:@"正在与服务器通讯"];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stoploading) name:@"link_success" object:nil];
}
-(void)stoploading{
    dispatch_async(dispatch_get_main_queue(), ^{
    [MBProgressHUD hideHUDForView:self.view];
    });
}

- (void)showLeftView {
      [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

-(void)setMainHeadScrollView{
    self.scrollView = [[MainHeadScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 170) ImagesCount:5];
    //点击图片的回调＃＃＃＃＃＃＃＃＃＃
    [self.scrollView tapImageViewBlock:^(NSInteger tag) {
        NSLog(@"点击图片Block回调  %zd",tag);
        
    }];
    [self.view addSubview:self.scrollView];
    
}

-(void)setbar{

    UIView* content = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame), SCREEN_W, 80)];
    barheight = content.frame.origin.y-45;

    UIImageView* qiqiu = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"balloon.png"]];
    qiqiu.frame = CGRectMake(0, 1, 50, 76);
    
    UIView* meiriView = [[UIView alloc]initWithFrame:CGRectMake(60, 0, 80, 20)];
    UILabel* meiriLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, 30)];
    meiriLable.text = @"每日一言";
    UIImageView* shuView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shu.png"]];
    shuView.frame = CGRectMake(0, 0, 8, 30);
    meiriLable.textColor = TEXT_GRAYCOLOR;
    meiriLable.font = [UIFont systemFontOfSize:15];
    [meiriView addSubview:meiriLable];
    [meiriView addSubview:shuView];

    
    UILabel* time = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W-100, content.frame.size.height-15, 100, 15)];
    time.text = [self gettime];
    time.font = [UIFont systemFontOfSize:12];
    time.textColor = TEXT_GRAYCOLOR;
    
    UILabel* mingyan = [[UILabel alloc]initWithFrame:CGRectMake(80, meiriView.frame.size.height, SCREEN_W-170, 60)];
    
    mingyan.numberOfLines = 0;
    
    switch (dayx%10) {
        case 0:
             mingyan.text = @"没有等出来的辉煌;只有走出来的美丽。";
            break;
        case 1:
            mingyan.text = @"凡事要三思，但比三思更重要的是三思而行。";
            break;
        case 2:
            mingyan.text = @"当你懈怠的时候，请想一下你父母期盼的眼神。";
            break;
        case 3:
            mingyan.text = @"成功是别人失败时还在坚持。";
            break;
        case 4:
            mingyan.text = @"生命之灯因热情而点燃，生命之舟因拼搏而前行。";
            break;
        case 5:
            mingyan.text = @"空谈不如实干。踱步何不向前行。";
            break;
        case 6:
            mingyan.text = @"如果要挖井，就要挖到水出为止。";
            break;
        case 7:
            mingyan.text = @"贪图省力的船夫，目标永远下游。";
            break;
        case 8:
            mingyan.text = @"成功决不喜欢会见懒汉，而是唤醒懒汉。";
            break;
        case 9:
            mingyan.text = @"机遇永远是准备好的人得到的。";
            break;
        default:
            break;
    }
   
    
    
    [self.view addSubview:content];
    [content addSubview:qiqiu];
    [content addSubview:meiriView];
    [content addSubview:time];
    [content addSubview:mingyan];
    


}
-(NSString*)gettime{
    NSDate *now                               = [NSDate date];
    NSCalendar *calendar                      = [NSCalendar currentCalendar];
    NSUInteger unitFlags                      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent           = [calendar components:unitFlags fromDate:now];
    int y                                     = (short)[dateComponent year];//年
    int m                                    =(short) [dateComponent month];//月
    int mou                                    = (short)[dateComponent month];//月
    int d                                      = (short)[dateComponent day];//日
    int day                                      = (short)[dateComponent day];//日
    if(m==1||m==2) {
        m+=12;
        y--;
    }
    int iWeek=(d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7+1;
    NSString *Week;
    switch (iWeek) {
        case 1:
            Week=@"一";
            break;
        case 2:
            Week=@"二";
            break;
        case 3:
            Week=@"三";
            break;
        case 4:
            Week=@"四";
            break;
        case 5:
            Week=@"五";
            break;
        case 6:
            Week=@"六";
            break;
        case 7:
            Week=@"日";
            break;
        default:
            Week=@"";
            break;
    }
    NSString*str =[NSString stringWithFormat:@"%d月%d日 星期%@",mou,day,Week];
    dayx = day;
    return str;


}
-(void)setlist{
    
    self.mTableView = [[TQMultistageTableView alloc] initWithFrame:CGRectMake(0, barheight, SCREEN_W    , SCREEN_H)];

    self.mTableView.dataSource = self;
    self.mTableView.delegate   = self;
    self.mTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mTableView];

}
- (NSInteger)mTableView:(TQMultistageTableView *)mTableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    else if(section == 1){
        return 9;
    }
    else if(section == 2){
        return 3;
    }
    else if(section == 3){
        return 6;
    }
    else if(section == 4){
        return 9;
    }
    else if(section == 5){
        return 3;
    }
    else {
        return 7;
    }
}

- (UITableViewCell *)mTableView:(TQMultistageTableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TQMultistageTableViewCell";
    UITableViewCell *cell = [mTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *array=[NSArray arrayWithObjects:@"个人信息",@"学籍信息",@"学籍异动",@"奖惩信息",@"辅修方案注册",@"学籍异动申请",@"网上选题",@"论文提交",@"毕业设计成绩查询",@"优秀毕业设计名单查询",nil];
       
        cell.textLabel.text=[array objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 1) {
        NSArray *array=[NSArray arrayWithObjects:@"网上选课",@"选课结果",@"退课", @"无效选课结果",@"本学期课表",@"本学期综合课表",@"未选中、已删除课程",@"历年课表",@"实验课选课",nil];
        
        cell.textLabel.text=[array objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 2) {
        NSArray *array=[NSArray arrayWithObjects:@"考试安排",@"考试报名",@"考试成绩", nil];
        cell.textLabel.text=[array objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 3) {
        NSArray *array=[NSArray arrayWithObjects:@"教室课表",@"课程课表",@"自习教室（无课教室）",@"教室使用状况查询",@"教师课表",@"班级课表" ,nil];
        
        cell.textLabel.text=[array objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 4) {
        NSArray *array=[NSArray arrayWithObjects:@"全部及格成绩",@"课程属性成绩",@"方案成绩",@"不及格成绩",@"本学期成绩",@"课程基本信息",@"方案完成情况",@"指导性教学计划",@"本学期课程安排", nil];
        //
        cell.textLabel.text=[array objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 5) {
        NSArray *array=[NSArray arrayWithObjects:@"评估公告",@"教学评估",@"毕业生评估", nil];
        cell.textLabel.text=[array objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 6) {
        NSArray *array=[NSArray arrayWithObjects:@"评估公告",@"教材查询",@"教材选定查询",@"教材领取查询",@"收费标准查询",@"审查体系",@"审查结论",nil];
        //@"教材领取查询",@"收费标准查询",@"审查体系",@"审查结论"
        cell.textLabel.text=[array objectAtIndex:indexPath.row];
    }
    

    UIView *view = [[UIView alloc] initWithFrame:cell.bounds] ;
    view.layer.backgroundColor  = [UIColor colorWithRed:246/255.0 green:213/255.0 blue:105/255.0 alpha:1].CGColor;
    view.layer.masksToBounds    = YES;
    view.layer.borderWidth      = 0.5;
    view.layer.borderColor      = [UIColor colorWithRed:250/255.0 green:77/255.0 blue:83/255.0 alpha:1].CGColor;
    
    cell.backgroundView = view;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(TQMultistageTableView *)mTableView
{
    return 7;
}

#pragma mark - Table view delegate

- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForAtomAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UIView *)mTableView:(TQMultistageTableView *)mTableView viewForHeaderInSection:(NSInteger)section;
{
    
    NSArray *array=[NSArray arrayWithObjects:@"学籍管理",@"选课管理",@"考务管理",@"教学资源",@"成绩查询",@"教学评估",@"教学资源", nil];
    UIView *header = [[UIView alloc] init];
    
    UILabel *mylable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 44)];
    
    mylable.text=[array objectAtIndex:section];
    
    [header addSubview:mylable];
    
    header.layer.backgroundColor    = [UIColor colorWithRed:218/255.0 green:249/255.0 blue:255/255.0 alpha:1].CGColor;
    header.layer.masksToBounds      = YES;
    header.layer.borderWidth        = 0.5;
    header.layer.borderColor        = [UIColor colorWithRed:179/255.0 green:143/255.0 blue:195/255.0 alpha:1].CGColor;
    return header;
}

-(void)webviewtext:(NSString *)urlstring{
    LGSideMainViewController *mainViewController = (LGSideMainViewController *)self.sideMenuController;
    UINavigationController *navigationController = (UINavigationController *)mainViewController.rootViewController;
    
    NSLog(@"你正在打开的网站是：%@",urlstring);
    CFWebViewController *webview=[[CFWebViewController alloc]initWithUrl:[NSURL URLWithString:urlstring]];
    [navigationController pushViewController:webview animated:YES];
    [mainViewController hideLeftViewAnimated:YES completionHandler:nil];
}


- (void)mTableView:(TQMultistageTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRow ----%ld,%ld",(long)indexPath.section,(long)indexPath.row);
    if (indexPath.section == 0 && indexPath.row== 0 ) {
         [self webviewtext:@"http://202.194.188.19/userInfo.jsp"];
    }
   else if (indexPath.section == 0 && indexPath.row== 1 ) {
        [self webviewtext:@"http://202.194.188.19/xjInfoAction.do?oper=xjxx"];
    }
   else if (indexPath.section == 0 && indexPath.row== 2 ) {
        [self webviewtext:@"http://202.194.188.19/xjInfoAction.do?oper=ydxx"];
    }
   else if (indexPath.section == 0 && indexPath.row== 3 ) {
       [self webviewtext:@"http://202.194.188.19/xjInfoAction.do?oper=jcxx"];

    }
   else if (indexPath.section == 0 && indexPath.row== 4 ) {
       [self webviewtext:@"http://202.194.188.19/xsFabgsqAction.do?oper=faxdsq1"];

    }
   else if (indexPath.section == 0 && indexPath.row== 5 ) {
       [self webviewtext:@"http://202.194.188.19/xjydcxAction.do"];
       
   }
   else if (indexPath.section == 0 && indexPath.row== 6 ) {
       [self webviewtext:@"http://202.194.188.19/xtcxAction.do"];
       
   }
   else if (indexPath.section == 0 && indexPath.row== 7 ) {
       [self webviewtext:@"http://202.194.188.19/lwtjAction.do?type=showXtjg"];
       
   }
   else if (indexPath.section == 0 && indexPath.row== 8 ) {
       [self webviewtext:@"http://202.194.188.19/queryAction.do"];
       
   }
   else if (indexPath.section == 0 && indexPath.row== 9 ) {
       [self webviewtext:@"http://202.194.188.19/lwyxsjAction.do"];
       
   }
    
    //////////////////////////////11111111111111111
   else if (indexPath.section == 1 && indexPath.row== 0 ) {
       [self webviewtext:@"http://202.194.188.19/xkAction.do"];
       
   }
   else if (indexPath.section == 1 && indexPath.row== 1 ) {
       [self webviewtext:@"http://202.194.188.19/xkAction.do?actionType=6"];
       
   }
   else if (indexPath.section == 1 && indexPath.row== 2 ) {
       [self webviewtext:@"http://202.194.188.19/xkAction.do?actionType=7"];
       
   }
   else if (indexPath.section == 1 && indexPath.row== 3 ) {
       [self webviewtext:@"http://202.194.188.19/xkAction.do?actionType=16"];
       
   }
   else if (indexPath.section == 1 && indexPath.row== 4 ) {
       [self webviewtext:@"http://202.194.188.19/xkAction.do?actionType=6"];
       
   }
   else if (indexPath.section == 1 && indexPath.row== 5 ) {
       [self webviewtext:@"http://202.194.188.19/syglSyxkAction.do?&oper=xsxkKcbAll"];
       
   }
   else if (indexPath.section == 1 && indexPath.row== 6) {
       [self webviewtext:@"http://202.194.188.19/lnkbcxAction.do"];
       
   }
    
   else if (indexPath.section == 1 && indexPath.row== 7) {
           [self webviewtext:@"http://202.194.188.19/lnkbcxAction.do"];
           
       }
   else if (indexPath.section == 1 && indexPath.row== 8 ) {
       [self webviewtext:@"http://202.194.188.19/syglSyxkAction.do?ejkch=&oper=goTosykcList"];

    }
    
    
    /////////////2222222222222222222222222222222222222222222222222
    
   else if (indexPath.section == 2 && indexPath.row== 0 ) {
       [self webviewtext:@"http://202.194.188.19/ksApCxAction.do?oper=getKsapXx"];

    }
   else if (indexPath.section == 2 && indexPath.row== 1 ) {
       [self webviewtext:@"http://202.194.188.19/kwBmAction.do?oper=getKsList"];

   }
   else if (indexPath.section == 2 && indexPath.row== 2 ) {
       [self webviewtext:@"http://202.194.188.19/cjSearchAction.do?oper=getKscjList"];

   }
    ////////////333333333333333333333333333333333333333333333333
   else if (indexPath.section == 3 && indexPath.row== 0 ) {
       [self webviewtext:@"http://202.194.188.19/jskbcxAction.do?oper=jskb_lb"];

   }
   else if (indexPath.section == 3 && indexPath.row== 1 ) {
       [self webviewtext:@"http://202.194.188.19/kckbcxAction.do?oper=kckb_lb"];

   }
   else if (indexPath.section == 3 && indexPath.row== 2 ) {
       [self webviewtext:@"http://202.194.188.19/xszxcxAction.do?oper=xszxcx_lb"];

   }
   else if (indexPath.section == 3 && indexPath.row== 3 ) {
       [self webviewtext:@"http://202.194.188.19/jxlCxAction.do?oper=ori"];

   }
   else if (indexPath.section == 3 && indexPath.row== 4 ) {
       [self webviewtext:@"http://202.194.188.19/lskbcxAction.do?oper=lskb_lb"];
       
   }
   else if (indexPath.section == 3 && indexPath.row== 5 ) {
       [self webviewtext:@"http://202.194.188.19/bjkbcxAction.do?oper=bjkb_lb"];
       
   }
    
    
    ////////////4444444444444444444444444444444444444444444444444444444
   else if (indexPath.section == 4 && indexPath.row== 0 ) {
       [self webviewtext:@"http://202.194.188.19/gradeLnAllAction.do?type=ln&oper=qb"];

   }
   else if (indexPath.section == 4 && indexPath.row== 1 ) {
       [self webviewtext:@"http://202.194.188.19/gradeLnAllAction.do?type=ln&oper=sx"];

   }
   else if (indexPath.section == 4 && indexPath.row== 2 ) {
       [self webviewtext:@"http://202.194.188.19/gradeLnAllAction.do?type=ln&oper=fa"];

   }
   else if (indexPath.section == 4 && indexPath.row== 3 ) {
       [self webviewtext:@"http://202.194.188.19/gradeLnAllAction.do?type=ln&oper=bjg"];

   }
   else if (indexPath.section == 4 && indexPath.row== 4 ) {
       [self webviewtext:@"http://202.194.188.19/bxqcjcxAction.do"];

   }
   else if (indexPath.section == 4 && indexPath.row== 5 ) {
       [self webviewtext:@"http://202.194.188.19/gradeLnAllAction.do?type=ln&oper=lnfaqk&flag=zx"];
       
   }
   else if (indexPath.section == 4 && indexPath.row== 6 ) {
       [self webviewtext:@"http://202.194.188.19/gradeLnAllAction.do?type=ln&oper=lnjhqk"];
       
   }
   else if (indexPath.section == 4 && indexPath.row== 7 ) {
       [self webviewtext:@"http://202.194.188.19/courseSearchAction.do?temp=1"];
       
   }
    
    
    ////////////55555555555555555555555555555555555555555555555555

   else if (indexPath.section == 5 && indexPath.row== 0 ) {
       [self webviewtext:@"http://202.194.188.19/ckgg.jsp?type=-1"];

   }
   else if (indexPath.section == 5 && indexPath.row== 1 ) {
       [self webviewtext:@"http://202.194.188.19/jxpgXsAction.do?oper=listWj"];

   }
   else if (indexPath.section == 5 && indexPath.row== 2 ) {
       [self webviewtext:@"http://202.194.188.19/byspgXsAction.do?oper=listWj"];

   }
    
    ////////////666666666666666666666666666666666666666666666666666666
   else if (indexPath.section == 6 && indexPath.row== 0 ) {
       [self webviewtext:@"http://202.194.188.19/ckgg.jsp?type=-1"];

   }
   else if (indexPath.section == 6 && indexPath.row== 1 ) {
       [self webviewtext:@"http://202.194.188.19/jcglAction.do?actionType=1&oper=xs"];

   }
   else if (indexPath.section == 6 && indexPath.row== 2 ) {
       [self webviewtext:@"http://202.194.188.19/jcxxAction.do?actionType=3&oper=xs"];

   }
   else if (indexPath.section == 6 && indexPath.row== 3 ) {
       [self webviewtext:@"http://202.194.188.19/jcxxAction.do?actionType=4&oper=xs"];
       
   }
   else if (indexPath.section == 6 && indexPath.row== 4 ) {
       [self webviewtext:@"http://202.194.188.19/sfCxAction.do?oper=current"];
       
   }
   else if (indexPath.section == 6 && indexPath.row== 5 ) {
       [self webviewtext:@"http://202.194.188.19/scTxQueryAction.do?oper=CurrentScTxQuery"];
       
   }
   else if (indexPath.section == 6 && indexPath.row== 6 ) {
       [self webviewtext:@"http://202.194.188.19/scJlQueryAction.do?oper=CurrentScJlQuery"];
       
   }
    
    
    
}

#pragma mark - Header Open Or Close

- (void)mTableView:(TQMultistageTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [mTableView headerViewForSection:section];
    header.backgroundView.backgroundColor = [UIColor lightGrayColor];
    NSLog(@"Open Header ----%ld",section);
}

- (void)mTableView:(TQMultistageTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [mTableView headerViewForSection:section];
    header.backgroundView.backgroundColor = [UIColor colorWithRed:218/255.0 green:249/255.0 blue:255/255.0 alpha:1];
    NSLog(@"Close Header ---%ld",section);
}

#pragma mark - Row Open Or Close

- (void)mTableView:(TQMultistageTableView *)mTableView willOpenRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Open Row ----%ld",indexPath.row);
}

- (void)mTableView:(TQMultistageTableView *)mTableView willCloseRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Close Row ----%ld",indexPath.row);
}




-(void)loadGIF
{   UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-50, SCREEN_H-50, 50, 50)];
    // 1.加载所有的图片
    NSMutableArray *standImages = [NSMutableArray array];
    for (int i=0; i<11; i++) {
        // 1.获取图片的名称
        NSString *imageName = [NSString stringWithFormat:@"fengche%d.jpg", i+1];
        // 2.创建图片对象
        UIImage *image = [UIImage imageNamed:imageName];
        // 3.把图片加入数组
        [standImages addObject:image];
    }
    // 2.设置动画图片
    imageView.animationImages = standImages;
    
    // 3.设置动画的播放次数
    imageView.animationRepeatCount = 0;
    
    // 4.设置播放时长
   imageView.animationDuration = 0.5;
    
    // 5.开始动画
    [imageView startAnimating];
    
    [self.view addSubview:imageView];
    
}




-(void)feedback{

    QFNUBackController* back = [[QFNUBackController alloc]init];
    [self.navigationController pushViewController:back animated:YES];

}
- (void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"link_success" object:nil];
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

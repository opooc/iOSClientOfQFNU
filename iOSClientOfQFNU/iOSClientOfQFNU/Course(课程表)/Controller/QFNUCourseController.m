//
//  QFNUCourseController.m
//  QFNU for opooc
//
//  Created by doushuyao on 17/6/5.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "QFNUCourseController.h"
#import "GWPCourseListView.h"
#import "CourseModel.h"
#import "NSData+CRC32.h"
#import "MBProgressHUD+NHAdd.h"
#import "AFNetworking.h"



@interface QFNUCourseController ()<GWPCourseListViewDataSource, GWPCourseListViewDelegate>
@property (nonatomic, strong) NSMutableArray<CourseModel*> *courseArr;
@property(nonatomic,strong)GWPCourseListView* courseListView;
@property(nonatomic,assign)BOOL alive;


@end

@implementation QFNUCourseController
int selectss=1;
int selects[770];


- (NSMutableArray<CourseModel *> *)courseArr{
    if (!_courseArr) {
        
    }
    return _courseArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCourse];
    [self addCourse];
    NSLog(@"%@",[[QFInfo sharedInstance]getToken]);
    [self setRefresh];
    
    
}

-(void)setCourse{
    
    _courseListView = [[GWPCourseListView alloc]init];
    _courseListView.dataSource = self;
    _courseListView.delegate = self;
    _courseListView.courseListWidth = 66;
    _courseListView.frame =CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_H-64) ;
    
    [self.view addSubview: _courseListView];
    
}
-(void)settitle:(int)nowweek{
    NSString *nowweek_string=@"第";
    NSString *now2=[NSString stringWithFormat:@"%d",nowweek];
    nowweek_string=[nowweek_string stringByAppendingString:now2];
    nowweek_string=[nowweek_string stringByAppendingString:@"周"];
    /** 标题栏样式 */
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    //标题结束//
    self.navigationItem.title                    = nowweek_string;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
}

-(int)endClass :(NSArray*)arr num:(int)j classId:(NSString* )classId{
    int end =1;
    if (j == 0||j==4) {
        if ([arr[j+1] count] != 0 && [[[arr[j+1] firstObject]objectForKey:@"class_id"] isEqualToString:classId]) {
            end++;
            
            if ([arr[j+2] count] != 0 && [[[arr[j+2] firstObject]objectForKey:@"class_id"] isEqualToString:classId]) {
                end++;
                if ([arr[j+3] count] != 0 && [[[arr[j+3] firstObject]objectForKey:@"class_id"] isEqualToString:classId]) {
                    end++;
                    return end;
                }
                return end;
            }
            return end;
        }
        return end;
    }
    
    else if (j == 1|| j ==5){
        if ([arr[j+1] count] != 0 && [[[arr[j+1] firstObject]objectForKey:@"class_id"] isEqualToString:classId]) {
            end++;
            if ([arr[j+2] count] != 0 && [[[arr[j+2] firstObject]objectForKey:@"class_id"] isEqualToString:classId]) {
                end++;
                return end;
            }
            return end;
        }
        return end;
    }
    
    
    
    else if (j == 2|| j == 6){
        if ([arr[j+1] count] != 0 && [[[arr[j+1] firstObject]objectForKey:@"class_id"] isEqualToString:classId]) {
            end++;
            return end;
        }
        return end;
    }
    else if (j == 8){
        if ([arr[j+1] count] != 0 && [[[arr[j+1] firstObject]objectForKey:@"class_id"] isEqualToString:classId]) {
            end++;
            if ([arr[j+2] count] != 0 && [[[arr[j+1] firstObject]objectForKey:@"class_id"] isEqualToString:classId]) {
                end++;
                return end;
            }
            return end;
        }
        return end;
    }
    else if(j == 9){
        if ([arr[j+1] count] != 0 && [[[arr[j+1] firstObject]objectForKey:@"class_id"] isEqualToString:classId]) {
            end++;
            return end;
        }
        return end;
    }
    return end;
}
- (void)addCourse{
    
    
    
    
    QFInfo* share= [QFInfo sharedInstance];;
    
    CourseModel *a1  = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a2  = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a3  = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a4  = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a5  = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a6  = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a7  = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a8  = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a9  = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a10 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a11 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a12 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a13 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a14 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a15 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a16 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a17 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a18 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a19 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a20 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a21 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a22 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a23 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a24 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a25 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a26 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a27 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a28 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a29 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a30 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a31 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a32 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a33 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a34 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a35 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    
    CourseModel *a36 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a37 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a38 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a39 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a40 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a41 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a42 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a43 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a44 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    
    CourseModel *a45 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a46 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a47 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a48 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a49 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a50 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a51 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a52 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a53 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a54 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a55= [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    
    CourseModel *a56 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a57 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a58 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a59 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a60 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a61 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a62 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a63 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a64 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a65 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a66 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    
    
    CourseModel *a67 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a68 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a69 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a70 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a71 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a72 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a73 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a74 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a75 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a76 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    CourseModel *a77 = [CourseModel courseWithName:@"NULL" dayIndex:0 startCourseIndex:3 endCourseIndex:3];
    
    
    if ([share getCourse] != NULL) {
        NSArray* lessonsArr = [[share getCourse] objectForKey:@"lessons"];
        int  nowweek = [[[share getCourse] objectForKey:@"week"]intValue];
        
        //设置大标题
        [self settitle:nowweek];
        
        //开始光速循环
        for (int i= 0; i<=(lessonsArr.count-1); i++) {
            
            NSArray *dayArr      = lessonsArr[i];
            for (int j = 0; j<= dayArr.count-1 ; ) {
                NSArray* dayCourseInfoArr = dayArr[j];
                if (dayCourseInfoArr.count == 0 ) {
                    j=j+1;
                }
                else{
                    NSDictionary* dayCourseInfodic = [dayCourseInfoArr firstObject];
                    
                    NSString* name1      =[dayCourseInfodic objectForKey:@"name"];//姓名
                    NSLog(@"%@",name1);
                    NSString* teacher   =[dayCourseInfodic objectForKey:@"teacher"];//教师
                    NSString* range     =[dayCourseInfodic objectForKey:@"range"];//课周
                    NSString* building  =[dayCourseInfodic objectForKey:@"building"];//教学楼
                    NSString* classroom =[dayCourseInfodic objectForKey:@"classroom"];//教室
                    NSString* type      =[dayCourseInfodic objectForKey:@"type"];//选、必修
                    NSString* source    =[dayCourseInfodic objectForKey:@"source"];//学分
                    NSString* class_id  =[dayCourseInfodic objectForKey:@"class_id"];//课程id
                    NSArray* week       =[dayCourseInfodic objectForKey:@"week"];//哪周上。
                    int dsz_num;
                    int StartWeek_num;
                    int EndWeek_num;
                    
                    int StartClass_num;
                    int EndClass_num;
                    int EndClass_num1;
                    
                    NSString *name = [NSString stringWithFormat:@"%@@%@%@",name1,building,classroom];
                    dsz_num =[self dsz:week];//0:all 1:dan 2:shuang
                    StartWeek_num = [[range substringToIndex:1]intValue];
                    
                    EndWeek_num = [[range substringFromIndex:2]intValue];
                    StartClass_num = j+1;
                    //结束的那一天
                    EndClass_num1 = [self endClass:dayArr num:j classId:class_id];
                    EndClass_num = EndClass_num1 + StartClass_num-1;
                    NSLog(@"%d--%d--%d",i+1,StartClass_num,EndClass_num);
                    
                    
                    
                    //判读课的结束
                    BOOL dqz = [self IfWeeks:nowweek dsz:dsz_num qsz:StartWeek_num jsz:EndWeek_num];
                    
                    if (dqz){
                        
#pragma mark 1
                        if (i == 0) {
                            
                            switch (j) {
                                    
                                case 0:
                                    a1  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 1:
                                    a2  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 2:
                                    a3  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    
                                    break;
                                case 3:
                                    
                                    a4  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 4:
                                    
                                    a5  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 5:
                                    
                                    a6  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 6:
                                    
                                    a7  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 7:
                                    
                                    a8  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 8:
                                    
                                    a9  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 9:
                                    
                                    a10  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 10:
                                    
                                    a11  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                    
                                default:
                                    break;
                            }//switch over
                        }
#pragma mark 2
                        if (i == 1) {
                            
                            switch (j) {
                                    
                                case 0:
                                    a12  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 1:
                                    a13  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 2:
                                    a14  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    
                                    break;
                                case 3:
                                    
                                    a15  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 4:
                                    
                                    a16  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 5:
                                    
                                    a17  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 6:
                                    
                                    a18  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 7:
                                    
                                    a19  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 8:
                                    
                                    a20  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 9:
                                    
                                    a21  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 10:
                                    
                                    a22  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                    
                                default:
                                    break;
                            }//switch over
                        }
#pragma mark 3
                        if (i == 2) {
                            
                            switch (j) {
                                    
                                case 0:
                                    a23  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 1:
                                    a24  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 2:
                                    a25  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    
                                    break;
                                case 3:
                                    
                                    a26  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 4:
                                    
                                    a27  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 5:
                                    
                                    a28  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 6:
                                    
                                    a29  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 7:
                                    
                                    a30  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 8:
                                    
                                    a31  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 9:
                                    
                                    a32  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 10:
                                    
                                    a33  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                    
                                default:
                                    break;
                            }//switch over
                        }
#pragma mark 4
                        if (i == 3) {
                            
                            switch (j) {
                                    
                                case 0:
                                    a34  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 1:
                                    a35  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 2:
                                    a36  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    
                                    break;
                                case 3:
                                    
                                    a37  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 4:
                                    
                                    a38  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 5:
                                    
                                    a39  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 6:
                                    
                                    a40  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 7:
                                    
                                    a41  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 8:
                                    
                                    a42  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 9:
                                    
                                    a43  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 10:
                                    
                                    a44  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                    
                                default:
                                    break;
                            }//switch over
                        }
#pragma mark 5
                        if (i == 4) {
                            
                            switch (j) {
                                    
                                case 0:
                                    a45  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 1:
                                    a46  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 2:
                                    a47  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    
                                    break;
                                case 3:
                                    
                                    a48 = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 4:
                                    
                                    a49  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 5:
                                    
                                    a50  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 6:
                                    
                                    a51  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 7:
                                    
                                    a52  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 8:
                                    
                                    a53  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 9:
                                    
                                    a54  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 10:
                                    
                                    a55  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                    
                                default:
                                    break;
                            }//switch over
                        }
                        
                        
#pragma mark 6
                        if (i == 5) {
                            
                            switch (j) {
                                    
                                case 0:
                                    a56  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 1:
                                    a57  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 2:
                                    a58  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    
                                    break;
                                case 3:
                                    
                                    a59  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 4:
                                    
                                    a60  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 5:
                                    
                                    a61  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 6:
                                    
                                    a62  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 7:
                                    
                                    a63  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 8:
                                    
                                    a64  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 9:
                                    
                                    a65  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 10:
                                    
                                    a66  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                    
                                default:
                                    break;
                            }//switch over
                        }
#pragma mark 7
                        if (i == 6) {
                            
                            switch (j) {
                                    
                                case 0:
                                    a67  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 1:
                                    a68  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    break;
                                case 2:
                                    a69  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    
                                    
                                    break;
                                case 3:
                                    
                                    a70  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 4:
                                    
                                    a71  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 5:
                                    
                                    a72  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 6:
                                    
                                    a73  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 7:
                                    
                                    a74  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 8:
                                    
                                    a75  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 9:
                                    
                                    a76  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                case 10:
                                    
                                    a77  = [CourseModel courseWithName:name dayIndex:(short)(i+1) startCourseIndex:(short)StartClass_num endCourseIndex:(short)EndClass_num];
                                    j = j+EndClass_num;
                                    break;
                                    
                                default:
                                    break;
                            }//switch over
                            
                        }//day if over
                        
                    }//dsz if end
                    else{
                        j = j+1;
                    }
                    
                }
            }//大else结束
        }
        
    }
    
    _courseArr = [NSMutableArray arrayWithArray:@[a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42,a43,a44,a45,a46,a47,a48,a49,a50,a51,a52,a53,a54,a55,a56,a57,a58,a59,a60,a61,a62,a63,a64,a65,a66,a67,a68,a69,a70,a71,a72,a73,a74,a75,a76,a77]];
    [self.courseListView reloadData];
    
    
}

//根据当前周返回全上，单双周。opooc
-(int)dsz:(NSArray*) week{
    
    int a = 0;
    int b = 0;
    for (id c in week) {
        if ([c intValue]%2 == 0) {
            a++;
        }
        if ([c intValue]%2 == 1) {
            b++;
        }
        
    }
    
    if (a == 0 && b == week.count) {
        return 2;
    }
    else if (a == week.count && b == 0) {
        return 1;
    }
    return 0;
}




//判断是否本周上课
-(BOOL)IfWeeks:(int)nowweek  dsz:(int)dsz  qsz:(int)qsz jsz:(int)jsz {
    /** nowweek 为的周数，整数
     
     dsz 为课程是单周上，还是双周上，1为单周，2为双周，0为每周都要上，整数
     qsz 为课程开始的周数，整数
     jsz 为课程结束的周数，整数 **/
    
    if (nowweek > jsz)
        return 0;
    if (nowweek < qsz)
        return 0;
    if (dsz == 0)
        return 1;
    return ((nowweek + dsz) % 2 == 0);
}



-(int) CountDays:(int)year m:(int)month d:(int)day{
    //返回当前是本年的第几天，year,month,day 表示现在的年月日，整数。
    int a[12]                                 = {31,0,31,30,31,30,31,31,30,31,30,31};
    int s                                     = 0;
    for(int i           = 0; i < month-1; i++) {s   += a[i];
    }
    if(month > 2) {
        if(year % (year % 100 ? 4 : 400 ) ? 0 : 1)s                                         += 29;
        else
            s                                         += 28;
    }
    return (s + day);
}


//返回的是本周中周几
-(int) getWeekDay:(int)y m:(int)m d:(int)d{
    if(m==1||m==2) {
        m+=12;
        y--;
    }
    int iWeek=(d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7+1;
    return iWeek;
}
-(int)getWeekDay{
    NSDate *now                                  = [NSDate date];
    NSCalendar *calendar                         = [NSCalendar currentCalendar];
    NSUInteger unitFlags                         = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent              = [calendar components:unitFlags fromDate:now];
    int y                                     = (short)[dateComponent year];//年
    int m                                    = (short)[dateComponent month];//月
    int d                                      = (short)[dateComponent day];//日
    return [self getWeekDay:y m:m d:d];
}



/**返回当前是本学期第几周 */
-(int) getWeek{
    NSDate *now                                  = [NSDate date];
    NSCalendar *calendar                         = [NSCalendar currentCalendar];
    NSUInteger unitFlags                         = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent              = [calendar components:unitFlags fromDate:now];
    int y                                     = (short)[dateComponent year];//年
    int m                                    = (short)[dateComponent month];//月
    int d                                      = (short)[dateComponent day];//日
    return [self getWeek:y m:m d:d];
}
-(int) getWeek:(int)nowyear m:(int)nowmonth d:(int)nowday {
    
    int ans                                   = 0;
    if (nowyear == 2017) {
        ans     = [self CountDays:nowyear m:nowmonth d:nowday] - [self CountDays:2017 m:2 d:20] + 1;
    } else {
        ans         = [self CountDays:nowyear m:nowmonth d:nowday] - [self CountDays:nowyear m:1 d:1] + 1;
        ans        += [self CountDays:2017 m:12 d:31] - [self CountDays:2017 m:2 d:20]+1;
    }
    return (ans + 6) / 7;
}

-(void)setRefresh{
    UIBarButtonItem* refreshBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction)];
    self.navigationItem.rightBarButtonItem= refreshBtn;
}

- (void)refreshAction{  //课表界面
    UIWindow *keywind=[[UIApplication sharedApplication]keyWindow];
    [MBProgressHUD showLoadToView:keywind.rootViewController.view title:@"正在刷新ing"];
    if([[QFInfo sharedInstance]getCourse]!=nil){
        /** 请求课表*/
        [self GET:@"https://zsqy.illidan.cn/urp/curriculum" parameters:nil success:^(id responseObject) {
            NSString *msg=[responseObject objectForKey:@"message"];
            if ([msg isEqualToString:@"获取成功"]) {
                [[QFInfo sharedInstance]savaCourse:nil];
                
                NSDictionary *dicCourse = [responseObject objectForKey:@"data"];
                
                NSLog(@"%@",dicCourse);
                
                [[QFInfo sharedInstance]savaCourse:dicCourse];
                [self.courseListView reloadData];
                
                [MBProgressHUD showError:@"刷新成功!" toView:self.view];
                
                [MBProgressHUD hideHUDForView:keywind.rootViewController.view animated:YES];
                
                
                
            }else if([msg isEqualToString:@"无权访问"]){
                [MBProgressHUD showError:@"登录过期,请重新登录" toView:self.view];
                [MBProgressHUD hideHUDForView:keywind.rootViewController.view animated:YES];
            }
            else{
                [MBProgressHUD showError:@"网络超时，平时课表查询失败,可点击左侧服务器接口重连尝试" toView:self.view];
                [MBProgressHUD hideHUDForView:keywind.rootViewController.view animated:YES];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(NSError *error) {
            NSString *errstr =[[NSString alloc]initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",errstr);
            // [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"网络超时，平时课表查询失败,可点击左侧服务器接口重连尝试" toView:self.view];
            [MBProgressHUD hideHUDForView:keywind.rootViewController.view animated:YES];
        }];
        
        
    }else{
        UIAlertView* alt = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"课表无课" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
        [alt show];
        [MBProgressHUD hideHUDForView:keywind.rootViewController.view animated:YES];
        // NSLog(@"%@",[[QFInfo sharedInstance]getCourse]);
    }
} //课程表
- (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self GET:URLString parameters:parameters timeout:6.f success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
- (void)GET:(NSString *)URLString parameters:(id)parameters timeout:(double)time success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSLog(@"请求地址:%@",URLString);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = time;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    NSString* token = [[QFInfo sharedInstance]getToken];
    
    
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager GET:URLString parameters:parameters progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if (success) {
                 success(responseObject);
                 
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (failure) {
                 failure(error);
             }
         }];
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GWPCourseListViewDataSource
- (NSArray<id<Course>> *)courseForCourseListView:(GWPCourseListView *)courseListView{
    return self.courseArr;
}
/** 课程单元背景色自定义 */
- (UIColor *)courseListView:(GWPCourseListView *)courseListView courseTitleBackgroundColorForCourse:(id<Course>)course{
    NSLog(@"%@",course.courseName);
    NSArray *lightColorArr = @[
                               RGB(39, 201, 155, 1),
                               RGB(250, 194, 97, 1),
                               RGB(50, 218,210, 1),
                               RGB(163, 232,102, 1),
                               RGB(78, 221, 166, 1),
                               RGB(247, 125, 138, 1),
                               RGB(120, 192, 246, 1),
                               RGB(254, 141, 65, 1),
                               RGB(2, 179, 237, 1),
                               RGB(110, 159, 245, 1),
                               RGB(17, 202, 154, 1),
                               RGB(228, 119, 195, 1),
                               RGB(147, 299, 3, 1),
                               ];
    
    if (course.courseName) {
        NSRange range=[course.courseName rangeOfString:@"@"];
        NSData *sendData = [[course.courseName substringToIndex:range.location] dataUsingEncoding:NSUTF8StringEncoding];
        int checksum =abs([sendData crc32])%256;
        
        
        if (selectss+1>lightColorArr.count) {//超过配色数量，随机颜色
            return nil;
        }
        if (selects[checksum]==0) {//第一次配色，设置颜色
            selects[checksum]=selectss++;
            return lightColorArr[selects[checksum]];
        }else{//第二次配色，取之前颜色
            return lightColorArr[selects[checksum]];
        }
    }
    return nil;
}
/** 设置选项卡的title的文字属性，如果实现该方法，该方法返回的attribute将会是attributeString的属性 */
- (NSDictionary*)courseListView:(GWPCourseListView *)courseListView titleAttributesInTopbarAtIndex:(NSInteger)index{
    if (index==[self getWeekDay]-1) {
        NSLog(@"%ld",(long)index);
        UIColor *newblueColor                        = [UIColor colorWithRed:0/255.0 green:206/255.0 blue:216/255.0 alpha:1];
        return @{NSForegroundColorAttributeName:newblueColor, NSFontAttributeName:[UIFont systemFontOfSize:18]};
    }
    
    return nil;
}
/** 设置选项卡的title的背景颜色，默认白色 */
- (UIColor*)courseListView:(GWPCourseListView *)courseListView titleBackgroundColorInTopbarAtIndex:(NSInteger)index{
    if (index==[self getWeekDay]-1) {
        UIColor *greyColor                        = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        return greyColor;
    }
    
    return nil;
}


#pragma mark - GWPCourseListViewDelegate
/** 选中(点击)某一个课程单元之后的回调 */
- (void)courseListView:(GWPCourseListView *)courseListView didSelectedCourse:(id<Course>)course{
    
    NSLog(@"%@",course.courseName);
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

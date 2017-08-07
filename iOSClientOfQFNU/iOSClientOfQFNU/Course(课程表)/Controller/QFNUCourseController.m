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
#import "QFInfo.h"


@interface QFNUCourseController ()<GWPCourseListViewDataSource, GWPCourseListViewDelegate>
@property (nonatomic, strong) NSMutableArray<CourseModel*> *courseArr;

@property(nonatomic,strong)GWPCourseListView* courseListView;

@end

@implementation QFNUCourseController
- (NSMutableArray<CourseModel *> *)courseArr{
    if (!_courseArr) {
        CourseModel *a = [CourseModel courseWithName:@"PHP" nameAttribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:40], NSForegroundColorAttributeName : [UIColor redColor]} dayIndex:1 startCourseIndex:1 endCourseIndex:2];
        CourseModel *b = [CourseModel courseWithName:@"Java333333333333333333333333" dayIndex:1 startCourseIndex:3 endCourseIndex:3];
        CourseModel *c = [CourseModel courseWithName:@"C++" dayIndex:1 startCourseIndex:4 endCourseIndex:6];
        CourseModel *d = [CourseModel courseWithName:@"C#" dayIndex:2 startCourseIndex:4 endCourseIndex:4];
        CourseModel *e = [CourseModel courseWithName:@"javascript" dayIndex:7 startCourseIndex:5 endCourseIndex:6];
        _courseArr = [NSMutableArray arrayWithArray:@[a,b,c,d,e]];
    }
    return _courseArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _courseListView = [[GWPCourseListView alloc]init];
    _courseListView.dataSource = self;
    _courseListView.delegate = self;
    
    UIButton* addBtn =[UIButton buttonWithType:UIButtonTypeContactAdd];
    
    addBtn.frame = CGRectMake(100, 100, 100, 100);
    CGRect bounds = self.view.bounds;
    _courseListView.frame =CGRectMake(0, 64, bounds.size.width, bounds.size.height-64) ;
    
   addBtn.userInteractionEnabled = YES;
    addBtn.layer.cornerRadius = 50;
    addBtn.clipsToBounds = YES;
    
    [addBtn addTarget:self action:@selector(addCourse) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
   
    [self.view addSubview: _courseListView];
    
    NSLog(@"-------%@",[QFInfo sharedInstance].token);
}

- (void)addCourse{
    CourseModel *a = [CourseModel courseWithName:@"Golang" dayIndex:3 startCourseIndex:1 endCourseIndex:2];
    [self.courseArr addObject:a];
    [self.courseListView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - GWPCourseListViewDataSource
- (NSArray<id<Course>> *)courseForCourseListView:(GWPCourseListView *)courseListView{
    return self.courseArr;
}/** 课程单元背景色自定义 */
- (UIColor *)courseListView:(GWPCourseListView *)courseListView courseTitleBackgroundColorForCourse:(id<Course>)course{
    
    if ([course isEqual:[self.courseArr firstObject]]) {    // 第一个，返回自定义颜色
        return [UIColor blueColor];
    }
    
    // 其他返回默认的随机色
    return nil;
}

/** 设置选项卡的title的文字属性，如果实现该方法，该方法返回的attribute将会是attributeString的属性 */
- (NSDictionary*)courseListView:(GWPCourseListView *)courseListView titleAttributesInTopbarAtIndex:(NSInteger)index{
    if (index==0) {
        return @{NSForegroundColorAttributeName:[UIColor greenColor], NSFontAttributeName:[UIFont systemFontOfSize:18]};
    }
    
    return nil;
}
/** 设置选项卡的title的背景颜色，默认白色 */
- (UIColor*)courseListView:(GWPCourseListView *)courseListView titleBackgroundColorInTopbarAtIndex:(NSInteger)index{
    if (index==1) {
        return [UIColor purpleColor];
    }
    
    return nil;
}

#pragma mark - GWPCourseListViewDelegate
/** 选中(点击)某一个课程单元之后的回调 */
- (void)courseListView:(GWPCourseListView *)courseListView didSelectedCourse:(id<Course>)course{
    
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

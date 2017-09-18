//
//  QFNUBackController.m
//  QFNU for opooc
//
//  Created by doushuyao on 17/6/5.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "QFNUBackController.h"

@interface QFNUBackController ()<UITextViewDelegate>

@property(nonatomic,strong)UITextView* textView;

@end
#define maxcount 100
@implementation QFNUBackController
{
    UILabel * tip;
    UILabel* rightCount;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈意见";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    
}
-(void)setupView{

    UIScrollView* bgScroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
    bgScroll.scrollEnabled = YES;
    bgScroll.alwaysBounceVertical = YES;
    [self.view addSubview:bgScroll];

    _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 150)];

    _textView.layer.borderWidth = 1;
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _textView.font =  [UIFont systemFontOfSize:15];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.textColor = [UIColor lightGrayColor];
    _textView.delegate = self;
    [bgScroll addSubview:_textView];
    
    if (tip == nil) {
        tip = [[UILabel alloc]initWithFrame:CGRectMake(5,5,_textView.frame.size.width -10, 20)];
        
        tip.textColor = [UIColor lightGrayColor];
        tip.text = @"请输入反馈内容，并留下联系方式";
        tip.font = [UIFont systemFontOfSize:15];
        [_textView addSubview:tip];}
        
    if (rightCount == nil) {
            rightCount = [[UILabel alloc]initWithFrame:CGRectMake(_textView.frame.size.width -50, CGRectGetMaxY(_textView.frame)-30, 50, 20)];
            rightCount.textColor = [UIColor lightGrayColor];
            rightCount.font = [UIFont systemFontOfSize:12];
            rightCount.textAlignment = NSTextAlignmentCenter;
            [self setCount:maxcount];
            [_textView addSubview:rightCount];

        }
        UIButton* sub = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_textView.frame)+50, SCREEN_WIDTH-30, 40)];
        [sub setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sub setTitle:@"提 交" forState:UIControlStateNormal];
        [sub setBackgroundColor:[UIColor colorWithRed:244.0/255.0 green:158.0/255.0 blue:17.0/255.0 alpha:1.0]];
        sub.titleLabel.font = [UIFont systemFontOfSize:20];
        sub.layer.cornerRadius = 5;
        sub.layer.masksToBounds = YES;
        [sub addTarget:self action:@selector(subToServer) forControlEvents:UIControlEventTouchUpInside];
        [bgScroll addSubview:sub];
    
}
-(void)subToServer{

    
    UIAlertView* tishi = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功！" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
    [tishi show];
    


}

-(void)setCount:(NSInteger) count{

    rightCount.text = [NSString stringWithFormat:@"%ld",(long)count];

}

-(void)textViewDidChange:(UITextView *)textView{

    NSString*txt = [_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    tip.hidden = txt.length>0;
    
    if (txt.length>maxcount) {
        _textView.text = [txt substringToIndex:maxcount];
    }

    [self setCount:(maxcount - txt.length)];
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



















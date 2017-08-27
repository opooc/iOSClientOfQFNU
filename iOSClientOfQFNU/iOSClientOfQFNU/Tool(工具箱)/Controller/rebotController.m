//
//  rebotController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/8/27.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "rebotController.h"

@interface rebotController ()<UITextViewDelegate>

@property(nonatomic,strong)UITextView* textView;

@property(nonatomic,strong)UITextView* anwser;
@end
#define maxcount 100

@implementation rebotController
{
    UILabel * tip;
    UILabel* rightCount;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"智能问答";
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
//next----------------
    CGFloat y=CGRectGetMaxY(_textView.frame)+100;
    _anwser = [[UITextView alloc]initWithFrame:CGRectMake(15, y-20, SCREEN_WIDTH-30, SCREEN_H-y-100)];
    
    _anwser.layer.borderWidth = 1;
    _anwser.layer.cornerRadius = 5;
    _anwser.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _anwser.font =  [UIFont systemFontOfSize:15];
    _anwser.backgroundColor = [UIColor whiteColor];
    _anwser.textColor = [UIColor lightGrayColor];
    [bgScroll addSubview:_anwser];
    
    if (tip == nil) {
        tip = [[UILabel alloc]initWithFrame:CGRectMake(5,5,_textView.frame.size.width -10, 20)];
        
        tip.textColor = [UIColor lightGrayColor];
        tip.text = @"请写下你想问的东西、";
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
    UIButton* sub = [[UIButton alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(_textView.frame)+20, SCREEN_WIDTH-120, 40)];
    [sub setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sub setTitle:@"查一查" forState:UIControlStateNormal];
    [sub setBackgroundColor:[UIColor colorWithRed:153.0/255.0 green:182.0/255.0 blue:134.0/255.0 alpha:1.0]];
    sub.titleLabel.font = [UIFont systemFontOfSize:20];
    sub.layer.cornerRadius = 5;
    sub.layer.masksToBounds = YES;
    [sub addTarget:self action:@selector(subToServer) forControlEvents:UIControlEventTouchUpInside];
    [bgScroll addSubview:sub];
    
}
-(void)subToServer{
    NSString *appcode = @"da658159a4d9483d8fb26fc7f0ed0d7d";
    NSString *host = @"http://jisuznwd.market.alicloudapi.com";
    NSString *path = @"/iqa/query";
    NSString *method = @"GET";
 //   NSString *querys = @"?question=%E6%9D%AD%E5%B7%9E%E5%A4%A9%E6%B0%94";
    
    NSString *question = _textView.text;
    NSString * questionb = [question stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *querys = [NSString stringWithFormat:@"?question=%@",questionb];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
  //  NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       NSLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       
                                                       //打印应答中的body
                                                       NSLog(@"Response body: %@" , bodyString);
                                                       
                                                        NSDictionary* dict1 = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableContainers error:nil];
                                                        NSDictionary* dict2 = [dict1 objectForKey:@"result"];
                                                       NSString* content = [dict2 objectForKey:@"content"];
                                                       
                                                       if ([NSThread isMainThread])
                                                       {
                                                           _anwser.text = content;
                                                           
                                                           [_anwser  setNeedsDisplay];
                                                       }
                                                       else
                                                       {
                                                           dispatch_sync(dispatch_get_main_queue(), ^{
                                                               //Update UI in UI thread here
                                                               _anwser.text = content;
                                                               
                                                               [_anwser  setNeedsDisplay];
                                                              
                                                           });
                                                       }
                                                   }];
    
    [task resume];
    
    
    
    
    
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









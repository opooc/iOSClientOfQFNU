//
//  QFNUBackController.m
//  QFNU for opooc
//
//  Created by doushuyao on 17/6/5.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "QFNUBackController.h"
#import "MBProgressHUD+NHAdd.h"
#import "AFNetworking.h"

@interface QFNUBackController ()<UITextViewDelegate>

@property(nonatomic,strong)UITextView* textView;
@property (nonatomic,strong)UITextView* waytextView;
@property (nonatomic,strong)UITextView* nametextView;
@end
#define maxcount 150
@implementation QFNUBackController
{
    UILabel * tip;
    UILabel* rightCount;
    
    UILabel * waytip;
    UILabel * nametip;
    
    MBProgressHUD *hud;
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
   // _textView.keyboardType = UIKeyboardTypeDefault;
    [bgScroll addSubview:_textView];
    
    
    _waytextView = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_textView.frame)+10, SCREEN_WIDTH-30, 40)];
    _waytextView.layer.borderWidth = 1;
    _waytextView.layer.cornerRadius = 5;
    _waytextView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _waytextView.font = [UIFont systemFontOfSize:15];
    _waytextView.backgroundColor = [UIColor whiteColor];
    _waytextView.textColor = [UIColor lightGrayColor];
    _waytextView.delegate = self;
    [bgScroll addSubview:_waytextView];
    
    
    _nametextView = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_waytextView.frame)+10, SCREEN_WIDTH-30, 40)];
    _nametextView.layer.borderWidth = 1;
    _nametextView.layer.cornerRadius = 5;
    _nametextView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _nametextView.font = [UIFont systemFontOfSize:15];
    _nametextView.backgroundColor = [UIColor whiteColor];
    _nametextView.textColor = [UIColor lightGrayColor];
    _nametextView.delegate = self;
    [bgScroll addSubview:_nametextView];
    
    if (nametip == nil) {
        nametip = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _nametextView.frame.size.width, 20)];
        nametip.textColor = [UIColor lightGrayColor];
        nametip.text = @"大佬，请输入您的尊姓大名or昵称";
        nametip.font =[UIFont systemFontOfSize:15];
        [_nametextView addSubview:nametip];
    }
         
    
    if (tip == nil) {
        tip = [[UILabel alloc]initWithFrame:CGRectMake(5,5,_textView.frame.size.width -10, 20)];
        
        tip.textColor = [UIColor lightGrayColor];
        tip.text = @"请输入反馈内容，并留下联系方式";
        tip.font = [UIFont systemFontOfSize:15];
        [_textView addSubview:tip];}
    
    if (waytip == nil) {
        waytip = [[UILabel alloc]initWithFrame:CGRectMake(5,5,_waytextView.frame.size.width -10, 20)];
        
        waytip.textColor = [UIColor lightGrayColor];
        waytip.text = @"请输入联系方式QQ/微信";
        waytip.font = [UIFont systemFontOfSize:16];
        [_waytextView addSubview:waytip];}
    
    
    if (rightCount == nil) {
            rightCount = [[UILabel alloc]initWithFrame:CGRectMake(_textView.frame.size.width -50, CGRectGetMaxY(_textView.frame)-30, 50, 20)];
            rightCount.textColor = [UIColor lightGrayColor];
            rightCount.font = [UIFont systemFontOfSize:12];
            rightCount.textAlignment = NSTextAlignmentCenter;
            [self setCount:maxcount];
            [_textView addSubview:rightCount];

        }
        UIButton* sub = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_nametextView.frame)+50, SCREEN_WIDTH-30, 40)];
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
    
    NSString* time = [self gettime];
    NSString* name = _nametextView.text;
    NSString* way = _waytextView.text;
    NSString* note = _textView.text;
    NSLog(@"%@",time);
    if([name isEqualToString:@""]){
        name =@"蒙面侠";
    }
    if ([way isEqualToString:@""]) {
        way = @"做好事不留名";
    }
    if ([note isEqualToString:@""]) {
        UIAlertView* tishi = [[UIAlertView alloc]initWithTitle:@"提示" message:@"老铁，反馈栏为空！！" delegate:self cancelButtonTitle:@"重新来过" otherButtonTitles:nil];
        [tishi show];
    }else{
    NSLog(@"%@--,--%@--,%@--,%@",time,name,way,note);
    AFHTTPSessionManager* manager =[AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString* postUrl =@"http://qfnu.vlove.me/opooc/public/index.php/api/v1/insert";
    NSDictionary* dic =@{
//                         @"name":name,
//                         @"time":time,
//                         @"way":way,
//                         @"note":note
                         @"name": name,
                         @"time": time,
                         @"way": way,
                         @"note": note
                         };
    
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    hud.label.text = NSLocalizedString(@"正在提交中...", @"Please wait a little!");
    
    
    [manager POST:postUrl  parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hideAnimated:YES];

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString* msg  = [dic objectForKey:@"msg"];
        NSLog(@"%@",msg);
        if ([msg isEqualToString:@"sucess"]) {
            UIAlertView* tishi = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功！" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [tishi show];
        }else{
            
            UIAlertView* tishi = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交失败，请重新提交！" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [tishi show];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [MBProgressHUD showError:@"网络超时，提交失败" toView:self.view];
            
        });
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSLog(@"%@",error);
    }];
    
    
    
    
    }
    
    


}
//获取时间，用于提交
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
        NSString*str =[NSString stringWithFormat:@"%d/%d/%d",y,mou,day];
        return str;
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
    
    NSString* waytxt = [_waytextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    waytip.hidden = waytxt.length>0;
    
    
    NSString* nametxt = [_nametextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    nametip.hidden = nametxt.length>0;
    
    
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



















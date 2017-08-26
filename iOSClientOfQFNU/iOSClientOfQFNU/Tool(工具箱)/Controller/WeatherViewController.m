//
//  weatherViewController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 2017/8/23.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "WeatherViewController.h"
#import "STPickerView.h"
#import "STPickerArea.h"
#import "MJExtension.h"


@interface WeatherViewController ()<UITextFieldDelegate, STPickerAreaDelegate>

@end

@implementation WeatherViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _area = [[UITextField alloc]init];
    _area.frame = CGRectMake(SCREEN_W*0.5 - 80,80,SCREEN_W,80);
    _area.placeholder = @"请点击文字选择地区";
    [_area setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _area.font = [UIFont systemFontOfSize:20];
    _area.delegate = self;
    [self.view addSubview:_area];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   
        [self.area resignFirstResponder];
  
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setSaveHistory:YES];
        [pickerArea setContentMode:STPickerContentModeCenter];
        [pickerArea show];

}
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    self.area.text = text;
    [self show:area];
}

-(void)show:(NSString*)body{
    NSString *appcode = @"da658159a4d9483d8fb26fc7f0ed0d7d";
    NSString *host = @"http://jisutianqi.market.alicloudapi.com";
    NSString *path = @"/weather/query";
    NSString *method = @"GET";
    
    NSString * bodyString = [body stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *querys = [NSString stringWithFormat: @"?city=%@&citycode=citycode&cityid=cityid&ip=ip&location=location",bodyString];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    
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
                                                       
                                                   }];
    [task resume];
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

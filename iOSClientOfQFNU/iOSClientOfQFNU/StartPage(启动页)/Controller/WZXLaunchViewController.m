//
//  WZXLaunchViewController.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "WZXLaunchViewController.h"
#import "WZXLaunchAd.h"

@interface WZXLaunchViewController ()
@property (nonatomic, strong)  WZXLaunchAd *Launch;
@end

@implementation WZXLaunchViewController


-(void)viewWillAppear:(BOOL)animated
{
    if(self.Launch.timer&&self.Launch.TimeInteger>0&&self.Launch.isClick)
    {
        dispatch_resume(self.Launch.timer);
    }
    self.Launch.isClick = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    if(self.Launch.timer&&self.Launch.TimeInteger>0&&self.Launch.isClick)
    {
        dispatch_suspend(self.Launch.timer);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
}


///**
// *  WZXLaunchViewController
// *
// *  @param imageFrame            广告图片的位置
// *  @param ImageURL         加载广告的URL 可以是图片 也可以是GIF
// *  @param timeSecond       广告的时长
// *  @param hideSkip         是否隐藏“跳过按钮” YES隐藏  NO显示
// *  @param imageLoadGood 广告图片加载完成 回调
// *  @param clickImage       点击广告 回调
// *  @param theAdEnds         广告播放结束 回调
// *
// *  @return WZXLaunchViewController
// */
//+(void)showWithFrame:(CGRect)imageFrame ImageURL:(NSString *)ImageURL advertisingURL:(NSString *)advertisingURL timeSecond:(NSInteger)timeSecond hideSkip:(BOOL)hideSkip imageLoadGood:(ImageLoadingGood)imageLoadGood clickImage:(ClickImage)clickImage theAdEnds:(TheAdEnds)theAdEnds{
//
//    
//    WZXLaunchViewController *WZXlaunchVC = [[WZXLaunchViewController alloc]init];
//    
//    
//    WZXlaunchVC.Launch = [WZXLaunchAd initImageWithframe:imageFrame imageURL:ImageURL timeSecond:timeSecond hideSkip:hideSkip LaunchAdCallback:^(UIImage *image, NSString *ImageURL) {
//        
//       
//        
//        if(imageLoadGood){
//            
//            imageLoadGood(image,ImageURL);
//        }
//        
//    } ImageClick:^{
//        
//       
//        
//        if(clickImage){
//            
//            clickImage(WZXlaunchVC);
//        }
//    
//        
//        
//    } endPlays:^{
//        
//       
//        
//        if(theAdEnds){
//            theAdEnds();
//        }
//        
//    }];
//    
//    [WZXlaunchVC.view addSubview:WZXlaunchVC.Launch];
//    
//    [[UIApplication sharedApplication].delegate window].rootViewController = WZXlaunchVC;
//    
//    
//    
//}


@end

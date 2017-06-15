//
//  WZXLaunchAd.m
//  MyHome
//
//  Created by DHSoft on 16/10/11.
//  Copyright © 2016年 DHSoft. All rights reserved.
//

#import "WZXLaunchAd.h"
#import "UIImageView+WebCache.h"

NSString *const TimerSender = @"5";

@interface WZXLaunchAd ()
/// 背景图
@property (nonatomic,strong) UIImageView *LaunchImage;
/// 跳过按钮
@property (nonatomic,strong) UIButton *skipBtn;





@end

@implementation WZXLaunchAd

- (instancetype)initWithFrame:(CGRect)frame TimeInteger:(NSInteger)TimeInteger{
    
    if(self = [super initWithFrame:frame]){
        self.adImageFrame = frame;
        self.TimeInteger = TimeInteger;
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.LaunchImage];
        [self addSubview:self.adImageView];
//        [self addSubview:self.skipBtn];
        [self startNoDataDispath_tiemr];
    }
    return self;
}
- (UIImageView *)LaunchImage{
    
    if(_LaunchImage == nil){
        
        _LaunchImage = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _LaunchImage.image = [self getLaunchImage];
     
    }
    return _LaunchImage;

}
- (UIImageView *)adImageView{

    if(_adImageView == nil){
        _adImageView = [[UIImageView alloc]initWithFrame:self.adImageFrame];
        _adImageView.userInteractionEnabled = YES;
//        _adImageView.alpha = 0.2;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_adImageView addGestureRecognizer:tap];
        
    }
    return _adImageView;
    
}

- (UIButton *)skipBtn{

    if(_skipBtn == nil){
        
        _skipBtn = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-70, 30, 60, 30)];
        [_skipBtn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
        _skipBtn.layer.cornerRadius = 15;
        _skipBtn.layer.masksToBounds = YES;
        NSInteger duration = [TimerSender integerValue];
        if(self.TimeInteger) duration = self.TimeInteger;
        [_skipBtn setTitle:[NSString stringWithFormat:@"%ld 跳过",duration] forState:UIControlStateNormal];
        _skipBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
        [_skipBtn addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _skipBtn;
    
}
-(UIImage *)getLaunchImage
{
    UIImage *imageP = [self launchImageWithType:@"Portrait"];
    if(imageP) return imageP;
    UIImage *imageL = [self launchImageWithType:@"Landscape"];
    if(imageL) return imageL;
    NSLog(@"获取LaunchImage失败!请检查是否添加启动图,或者规格是否有误.");
    return nil;
}
-(UIImage *)launchImageWithType:(NSString *)type
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = type;
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if([viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            if([dict[@"UILaunchImageOrientation"] isEqualToString:@"Landscape"])
            {
                imageSize = CGSizeMake(imageSize.height, imageSize.width);
            }
            if(CGSizeEqualToSize(imageSize, viewSize))
            {
                launchImageName = dict[@"UILaunchImageName"];
                UIImage *image = [UIImage imageNamed:launchImageName];
                return image;
            }
        }
    }
    return nil;
}


- (void)startNoDataDispath_tiemr{

    NSTimeInterval period = 1.0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _noDataTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_noDataTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    
    __block NSInteger duration = 3;
    dispatch_source_set_event_handler(_noDataTimer, ^{
       
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if(duration == 0){
                dispatch_source_cancel(_noDataTimer);
                [self removeView];
            }
            duration--;
            
      
        });
    });
    dispatch_resume(_noDataTimer);
}


- (void)dispath_tiemr{

    if(_noDataTimer) dispatch_source_cancel(_noDataTimer);
    
    NSTimeInterval period = 1.0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
   
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    
    
    __block NSInteger duration = [TimerSender integerValue];
    if(self.TimeInteger) duration = self.TimeInteger;
    dispatch_source_set_event_handler(_timer, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_skipBtn setTitle:[NSString stringWithFormat:@"%ld 跳过",duration] forState:UIControlStateNormal];
            if(duration==0)
            {
                dispatch_source_cancel(_timer);
                
                [self removeView];
            }
            duration--;
            
        });
    });
    dispatch_resume(_timer);
    
}

- (void)animateEnd{

    CGFloat duration = [TimerSender floatValue];
    if(_TimeInteger)duration = self.TimeInteger;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeView];
    });
}
- (void)skipAction{
    
    self.isClick = NO;
    if (_timer) dispatch_source_cancel(_timer);
    [self removeView];
    

}
- (void)removeView{

     if(self.endPlays){
         if(self.ClickAds == NO){
             
             self.endPlays();
         }
         
     }
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
       
    }];
    
}
+ (instancetype)initImageWithframe:(CGRect )frame imageURL:(NSString *)imageURL timeSecond:(NSInteger )timeSecond hideSkip:(BOOL)hideSkip LaunchAdCallback:(LaunchAdCallback)LaunchAdCallback ImageClick:(LaunchAdClick)ImageClick endPlays:(EndPlays)endPlays{

    WZXLaunchAd *launchAd = [[WZXLaunchAd alloc]initWithFrame:frame TimeInteger:timeSecond];

    launchAd.hideSkip = hideSkip;
     launchAd.ClickAds = NO;
    [launchAd.adImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if(imageURL){
        
            if(LaunchAdCallback){
              LaunchAdCallback(image,[NSString stringWithFormat:@"%@",imageURL]);
            }
           
            
            
            [launchAd addSubview:launchAd.skipBtn];
            [launchAd dispath_tiemr];
        }
        
    }];
    __weak typeof(launchAd) weakLaunch = launchAd;
    launchAd.ImageClick = ^(){
        
        if(ImageClick){
            ImageClick();
            weakLaunch.ClickAds = YES;
        }
      
    };
    launchAd.endPlays =^(){
        if(endPlays){
            endPlays();
        }
    };
    return launchAd;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if(self.ImageClick){
        
        self.isClick = YES;
        self.ImageClick();
    }
}



-(void)setHideSkip:(BOOL)hideSkip{

    _hideSkip = hideSkip;
    
    if(!_hideSkip){
        [self.skipBtn removeFromSuperview];
    }
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

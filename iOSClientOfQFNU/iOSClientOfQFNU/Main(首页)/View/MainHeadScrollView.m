//
//  MainHeadScrollView.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import "MainHeadScrollView.h"

#define ScrollView self.scrollView.bounds.size.width

@interface MainHeadScrollView ()<UIScrollViewDelegate>
@property (nonatomic,assign) NSInteger ImageCount;
@end

@implementation MainHeadScrollView

-(instancetype) initWithFrame:(CGRect)frame ImagesCount:(NSInteger)ImageCount{
    
    if (self = [super initWithFrame:frame]) {
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((frame.size.width - 100)/2, frame.size.height - 20, 100, 20)];
        [self addSubview:self.pageControl];
        self.ImageCount = ImageCount;
        
        CGFloat imageViewW = self.scrollView.bounds.size.width;
        CGFloat imageViewH = self.scrollView.bounds.size.height;
        CGFloat imageViewY = 0;
        
        for (NSInteger i = 0; i < ImageCount; i++) {
            self.imageView = [[UIImageView alloc] init];
            UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
            self.imageView.userInteractionEnabled = YES;
            
            self.imageView.tag = 100+i;
            [self.imageView addGestureRecognizer:TapGesture];
            
            CGFloat imageViewX = imageViewW * i;
            self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);

            // 3.设置图片
            // 拼接图片的名称
            NSString *imageName = [NSString stringWithFormat:@"qf%ld", (i + 1)];
            self.imageView.image = [UIImage imageNamed:imageName];
            [self.scrollView addSubview:self.imageView];
            
        }
     
        self.scrollView.contentSize = CGSizeMake(imageViewW * ImageCount, 0);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.pageControl.numberOfPages = ImageCount;
        self.pageControl.currentPage = 0;
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.scrollView.delegate = self;
        self.scrollView.bounces = NO;
        
        [self timer];
        
        
    }
    return self;
    
}

-(void)imageViewTap:(UITapGestureRecognizer *)tap{
    
    NSLog(@"点击图片  %zd",tap.view.tag);
    __weak typeof(self)WeakSelf = self;
    
    if (WeakSelf.tapImageBlock) {
        
        WeakSelf.tapImageBlock(tap.view.tag);
    }
    
}

-(void)tapImageViewBlock:(TapImageViewBlock)tapImageBlock{
    
    self.tapImageBlock = tapImageBlock;
    
}
#pragma mark - scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollViewW = scrollView.bounds.size.width;
    NSInteger page = (scrollView.contentOffset.x + scrollViewW * 0.5) / scrollViewW;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self timer];
}


#pragma mark - 懒加载来创建定时器
- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)nextPage {
    
    NSInteger page = self.pageControl.currentPage;
    if (page == (self.ImageCount - 1)){
        page = 0;
    } else {
        page++;
    }
    CGPoint offset = CGPointMake(ScrollView * page, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}


@end

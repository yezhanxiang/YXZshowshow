//
//  AdMenuCell.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/25.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "AdMenuCell.h"

#define SCROLL_W ([UIScreen mainScreen].bounds.size.width)
#define SCROLL_H 80

@interface AdMenuCell ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation AdMenuCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initScrollView];
    [self initPageControl];
}

//初始化ScrollView
-(void)initScrollView
{
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCROLL_W, SCROLL_H)];
    scrollV.delegate = self;
    //设置滚动方向
    scrollV.showsHorizontalScrollIndicator = YES;
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.pagingEnabled = YES;
    scrollV.scrollEnabled = YES;
    
    //设置滚动范围
    scrollV.contentSize = CGSizeMake(SCROLL_W * 2, SCROLL_H);
    NSLog(@"%f",scrollV.contentSize.width);
    //设置图片
    for (int i = 0; i < 2; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCROLL_W * i, 0, SCROLL_W, SCROLL_H)];
        imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"ad_0%d",i+1]];
        [scrollV addSubview:imageview];
    }
    [self addSubview:scrollV];
    self.scrollView = scrollV;
}

//初始化分页pageControl
-(void)initPageControl
{
    self.pageControl.numberOfPages = 2;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    
    //定时器
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(updateScrollViewImage:) userInfo:nil repeats:YES];
}

//定时刷新广告
-(void)updateScrollViewImage:(NSTimer *)timer
{
    CGPoint startPoint = self.scrollView.contentOffset;
    CGPoint endPoint = startPoint;
    int index = startPoint.x / SCROLL_W;
    if(0 == index)
        endPoint.x = SCROLL_W;
    else if(1 == index)
        endPoint.x = 0;
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = endPoint;
    } completion:^(BOOL finished) {
        int currentPage = endPoint.x / SCROLL_W;
        self.pageControl.currentPage = currentPage;
    }];
}

#pragma mark - 滚动视图代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算
    int index = scrollView.contentOffset.x / SCROLL_W;
    //更新页码
    self.pageControl.currentPage = index;
}

@end

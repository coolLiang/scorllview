//
//  ADScrollView.m
//  scorllview
//
//  Created by FLY_AY on 15/12/3.
//  Copyright © 2015年 com.TYToO. All rights reserved.
//

#import "ADScrollView.h"

@implementation ADScrollView

-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)layoutSubviews
{
    [self dosomething];
}

-(void)dosomething
{
    //没有图片数据时不做操作
    if (!self.imageArray.count) {
        
        return;
    }
    //已初始化过改视图时不做操作
    if (self.subviews.count) {
        
        return;
    }
    if (self.imageArray.count > 1) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(pageChange) userInfo:nil repeats:YES];
    }
    //获取当前图片数组中的个数
    int imageNum = (int)self.imageArray.count;
    //换种方式实现图片轮播
    int pageNum = imageNum + 2;
    
    self.scrollView  = [UIScrollView new];
    self.scrollView.frame = self.bounds;
    
    self.scrollView.delegate = self;
    
    
    //初始化timer的方法。实现自动滚动
    // scroll的分页设置
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * pageNum, 0);
    
    
    for (int i =0; i<pageNum; i++) {
        
        UIImageView * image = [[UIImageView alloc]init];
        image.frame = CGRectMake(self.bounds.size.width*i, 0, self.bounds.size.width, self.bounds.size.height);
        
        //第一个视图添加的是最后一张图片
        
        if (i == 0) {
            
            image.image = [UIImage imageNamed:[self.imageArray lastObject]];
            
        }
        //最后一个视图添加的是第一张图片
        else if (i == pageNum - 1)
        {
            image.image = [UIImage imageNamed:[self.imageArray firstObject]];
        }
        //此外，第2个视图用第一张图。以此类推。~
        else
        {
            image.image = [UIImage imageNamed:self.imageArray[i-1]];
        }
        
        [self.scrollView addSubview:image];
    }
    //初始位置在 第2张图上。
    self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    
    [self addSubview:self.scrollView];
    
    
    //创建pagecontrol对象
    
    self.pageControl = [UIPageControl new];
    self.pageControl.frame = CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30);
    self.pageControl.numberOfPages = self.imageArray.count;
    
    self.pageControl.currentPage = 0;
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    [self addSubview:self.pageControl];
    
    //增加个点击滚动视图的手势。
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScrollViewAction)];
    [self addGestureRecognizer:tap];
    

}
-(void)pageChange
{
    //共有几页
    int i  = self.scrollView.contentSize.width / self.bounds.size.width ;
    
    //当前是第几页
    currentPage = self.scrollView.contentOffset.x / self.bounds.size.width;
    
    //如果已经到了最后一页时
    if (currentPage == i - 1) {
        
        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
        [self updateSelf];
        
    }
    //如果到了第一页
    if (currentPage == 0) {
        
        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * self.imageArray.count, 0)];
        [self updateSelf];
    }
    
    //不是最后一页时，直接进入下一页。
    else
    {
        [self updateSelf];
  
    }

}

-(void)updateSelf
{
    
    //当前是第几页
    currentPage = self.scrollView.contentOffset.x / self.bounds.size.width;
    
    [self.scrollView setContentOffset:CGPointMake(currentPage * self.bounds.size.width + self.bounds.size.width, 0) animated:YES];
    
    
}

-(void)scrollViewScrolledUpdate
{
    //共有几页
    int i  = self.scrollView.contentSize.width / self.bounds.size.width ;
    
    //当前是第几页
    currentPage = self.scrollView.contentOffset.x / self.bounds.size.width;
    //如果已经到了最后一页时
    if (currentPage == i - 1) {
        
        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
        
        
    }
    //如果到了第一页
    if (currentPage == 0) {
        
        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * self.imageArray.count, 0)];
    }
    
}

//滚动视图的代理方法
//开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    [self.timer setFireDate:[NSDate distantFuture]];
}
//完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
}

//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    
    int contentX = self.scrollView.contentOffset.x;
    int width = self.scrollView.bounds.size.width;
    
    int result = contentX % width;
    
    if (result == 0) {
        
        self.pageControl.currentPage = contentX/width - 1;
        
        [self scrollViewScrolledUpdate];
    }
}

//点击手势
-(void)tapScrollViewAction
{
    NSLog(@"%ld",self.pageControl.currentPage);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onImageViewClick:)]) {
        
        [self.delegate onImageViewClick:self.pageControl.currentPage];
        
        
    }
}


@end

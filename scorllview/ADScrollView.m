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
    
    
    
    //初始化timer的方法。实现自动滚动
    // scroll的分页设置
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.contentSize = CGSizeMake(self.bounds.size.width * pageNum, 0);
    
    
    
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
        
        [self addSubview:image];
    }
    //初始位置在 第2张图上。
    self.contentOffset = CGPointMake(self.bounds.size.width, 0);

}
-(void)pageChange
{
    //共有几页
    int i  = self.contentSize.width / self.bounds.size.width ;
    
    //当前是第几页
    currentPage = self.contentOffset.x / self.bounds.size.width;
    
    //如果已经到了最后一页时
    if (currentPage == i - 1) {
        
        [self setContentOffset:CGPointMake(self.bounds.size.width, 0)];
        [self updateSelf];
        
    }
    //如果到了第一页
    if (currentPage == 0) {
        
        [self setContentOffset:CGPointMake(self.bounds.size.width * self.imageArray.count, 0)];
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
    currentPage = self.contentOffset.x / self.bounds.size.width;
    
    [self setContentOffset:CGPointMake(currentPage * self.bounds.size.width + self.bounds.size.width, 0) animated:YES];
}

-(void)scrollViewScrolledUpdate
{
    //共有几页
    int i  = self.contentSize.width / self.bounds.size.width ;
    
    //当前是第几页
    currentPage = self.contentOffset.x / self.bounds.size.width;
    //如果已经到了最后一页时
    if (currentPage == i - 1) {
        
        [self setContentOffset:CGPointMake(self.bounds.size.width, 0)];
        
        
    }
    //如果到了第一页
    if (currentPage == 0) {
        
        [self setContentOffset:CGPointMake(self.bounds.size.width * self.imageArray.count, 0)];
    }
    
}



@end

//
//  ADScrollView.h
//  scorllview
//
//  Created by FLY_AY on 15/12/3.
//  Copyright © 2015年 com.TYToO. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ADScrollViewDelegate

//点击图片时。将点击的图片在图片数组中的索引值传出去。
-(void)onImageViewClick:(NSInteger)index;

@end

@interface ADScrollView : UIView<UIScrollViewDelegate>
{
    int currentPage; //当前页数
}

@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,strong)NSArray * imageArray;

@property(nonatomic,weak)id delegate;

-(instancetype)init;

@end

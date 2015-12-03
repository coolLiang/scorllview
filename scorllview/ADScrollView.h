//
//  ADScrollView.h
//  scorllview
//
//  Created by FLY_AY on 15/12/3.
//  Copyright © 2015年 com.TYToO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADScrollView : UIScrollView
{
    int currentPage; //当前页数
}

@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,strong)NSArray * imageArray;

-(instancetype)init;


//手动滑动时 触发方法。
-(void)scrollViewScrolledUpdate;


@end

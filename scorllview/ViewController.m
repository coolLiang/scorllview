//
//  ViewController.m
//  scorllview
//
//  Created by FLY_AY on 15/12/3.
//  Copyright © 2015年 com.TYToO. All rights reserved.
//

#import "ViewController.h"

#import "ADScrollView.h"

@interface ViewController ()

@property(nonatomic,strong)ADScrollView * adScrollView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.adScrollView = [ADScrollView new];
    self.adScrollView.delegate = self;
    
    self.adScrollView.frame = CGRectMake(0, 20,self.view.frame.size.width,200);
    
    [self.view addSubview:self.adScrollView];
    
    [self dosomething];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)dosomething
{
    self.adScrollView.imageArray = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    [self.adScrollView layoutSubviews];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
    [self.adScrollView.timer invalidate];
    self.adScrollView.timer = nil;
    [self.adScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}

//开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    [self.adScrollView.timer setFireDate:[NSDate distantFuture]];
}
//完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    [self.adScrollView.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
}

//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    //    NSLog(@" scrollViewDidScroll");
    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    
    int contentX = self.adScrollView.contentOffset.x;
    int width = self.adScrollView.bounds.size.width;
    
    int result = contentX % width;
    
    if (result == 0) {
        
        NSLog(@"21");
        [self.adScrollView scrollViewScrolledUpdate];
    }

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"clear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

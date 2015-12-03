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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"clear");
}

//广告视图的代理方法
-(void)onImageViewClick:(NSInteger)index
{
    
    NSLog(@"%ld",index);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

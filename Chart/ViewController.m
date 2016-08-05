//
//  ViewController.m
//  test
//
//  Created by mgfjx on 16/8/3.
//  Copyright © 2016年 XXL. All rights reserved.
//

#import "ViewController.h"
#import "LineChartView.h"
#import "UIColor+Hex.h"

@interface ViewController ()<LineChartViewDelegate>{
    LineChartView *lineChart;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    LineChartView *view = [[LineChartView alloc] initWithFrame:CGRectMake(8, 0, 600, self.view.bounds.size.width)];
    view.backgroundColor = [UIColor whiteColor];
    view.delegate = self;
    [self.view addSubview:view];
    lineChart = view;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 20, 60, 40);
    [btn addTarget:self action:@selector(btnCLicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor randomColor];
    [self.view addSubview:btn];
    
    
    
}

- (void)btnCLicked:(id)sender{
    [lineChart draw];
}

- (NSInteger)numberOfLines{
    return 3;
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index{
    return [UIColor randomColor];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index{
    NSArray *points = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                        [NSValue valueWithCGPoint:CGPointMake(1, 14)],
                        [NSValue valueWithCGPoint:CGPointMake(5, 54)],
                        [NSValue valueWithCGPoint:CGPointMake(10, 60)]];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < random()%10 + 5; i++) {
        [array addObject:@(random()%80)];
    }
    
    return [array copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

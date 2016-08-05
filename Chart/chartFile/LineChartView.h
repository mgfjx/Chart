//
//  LineChartView.h
//  test
//
//  Created by mgfjx on 16/8/5.
//  Copyright © 2016年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LineChartViewDelegate <NSObject>

- (NSInteger)numberOfLines;
- (UIColor *)colorForLineAtIndex:(NSInteger)index;
- (NSArray *)valuesForLineAtIndex:(NSInteger)index;

@end

@interface LineChartView : UIView

@property (nonatomic, weak) id<LineChartViewDelegate> delegate;

- (void)draw;

@end

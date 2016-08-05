//
//  LineChartView.m
//  test
//
//  Created by mgfjx on 16/8/5.
//  Copyright © 2016年 XXL. All rights reserved.
//

#import "LineChartView.h"
#import "UIColor+Hex.h"

@interface LineChartView (){
    CGPoint oPoint;
    CGFloat x_UnitLength;
    CGFloat y_UnitLength;
    BOOL isDrawing;
    NSMutableArray *shapeLayers;
}

@end

@implementation LineChartView

- (instancetype)init{
    self = [super init];
    if (self) {
        shapeLayers = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        shapeLayers = [NSMutableArray array];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    NSArray *numbers = @[@"60",@"40",@"20",@"0"];
    
    NSDictionary *attributeDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0x8f8f8f"],};
    
    CGSize size = CGSizeZero;
    
    for (NSString *num in numbers) {
        
        CGSize currentSize = [num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:attributeDic context:nil].size;
        if (currentSize.width > size.width) {
            size = currentSize;
        }
        
    }
    
    CGPoint origin = CGPointZero;
    
    for (int i = 0; i < numbers.count; i++) {
        
        NSString *number = numbers[i];
        
        CGRect numberRect = CGRectMake(0, height*(i + 1)/4 - size.height, size.width, size.height);
        [number drawInRect:numberRect withAttributes:attributeDic];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        origin = CGPointMake(numberRect.origin.x + numberRect.size.width + 6, numberRect.origin.y + numberRect.size.height/2);
        [path moveToPoint:origin];
        [path addLineToPoint:CGPointMake(width, numberRect.origin.y + numberRect.size.height/2)];
        [[UIColor colorWithHexString:@"dcdcdc"] setStroke];
        [path stroke];
        
    }
    
    NSInteger xCount = floor(width/12);
    x_UnitLength = 12;
    y_UnitLength = height/80;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:origin];
    oPoint = origin;
    for (int i = 0; i < xCount; i++) {
        
        if (i % 5 == 0) {
            
            [path addLineToPoint:CGPointMake(origin.x, origin.y + 3)];
            [path moveToPoint:origin];
            [path addLineToPoint:CGPointMake(origin.x, origin.y - 3)];
            origin = CGPointMake(origin.x + 12, origin.y);
            [path closePath];
            
        }else{
            [path addLineToPoint:CGPointMake(origin.x, origin.y + 3)];
            origin = CGPointMake(origin.x + 12, origin.y);
            [path closePath];
        }
        
        [path moveToPoint:origin];
        
    }
    [[UIColor colorWithHexString:@"dcdcdc"] setStroke];
    path.lineWidth = 2.5;
    [path stroke];
    if (isDrawing) {
        NSInteger lines = [self.delegate numberOfLines];
        for (int i = 0; i < lines; i++) {
            NSArray *values = [self.delegate valuesForLineAtIndex:i];
            UIColor *lineColor = [self.delegate colorForLineAtIndex:i];
            [self drawLines:values lineColor:lineColor];
        }
        
    }
}

- (void)draw{
    isDrawing = YES;
    if (shapeLayers) {
        for (CAShapeLayer *layer in shapeLayers) {
            [layer removeFromSuperlayer];
        }
    }
    [self setNeedsDisplay];
}

- (void)drawLines:(NSArray *)points lineColor:(UIColor *)lineColor{
    
    if(points == nil || points.count == 0) return;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = lineColor.CGColor;
    layer.fillColor = nil;
    layer.lineWidth = 3;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:layer];
    [shapeLayers addObject:layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    
    for (int i = 0; i < points.count; i++) {
        
//        CGPoint point = [points[i] CGPointValue];
        CGFloat y = [points[i] floatValue];
        CGPoint point = CGPointMake(oPoint.x + (i)*5*x_UnitLength, oPoint.y - y*y_UnitLength);
        
        if (i == 0) {
            [path moveToPoint:point];
        }else{
            [path addLineToPoint:point];
        }
    }
    
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = 0.25 * points.count;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [layer addAnimation:animation forKey:nil];
}

@end














//
//  ProgressView.m
//  Video_Audio
//
//  Created by 朱来飞 on 2018/3/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ProgressView.h"
#import "UIView+Layout.h"
#define RGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation ProgressView

- (instancetype)init{
    
    if (self = [super init]) {
        _max = 1.0 ;
        _min = 0.0 ;
        _currentValue = 0.0 ;
        
        _currentPercent = 0.0 ;
        _cachePercent = 0.0 ;
        
        _lineWidth = 2.0 ;
        _lineColor = [UIColor whiteColor];
        _progessLineColor = RGBColor(254, 64, 22, 1);
        _cacheLineColor = [UIColor grayColor];
        _circleRadius = 8 ;
        _circleColor = RGBColor(254, 64, 22, 1);

        self.backgroundColor = [UIColor clearColor];
        
    }
    return self ;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    
    self.currentPercent = touchPoint.x / self.width;
    _currentValue = _min + _currentPercent * (_max - _min);
    [self sendActionsForControlEvents:UIControlEventValueChanged];

}
- (void)setCurrentPercent:(CGFloat)currentPercent{
    
    if (_currentPercent != currentPercent) {
         _currentPercent = currentPercent;
        [self setNeedsDisplay];
    }
}
//外部设置
- (void)setCachePercent:(CGFloat)cachePercent{
    if (_cachePercent != cachePercent) {
        _cachePercent = cachePercent ;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx  = UIGraphicsGetCurrentContext() ;
    CGFloat x = 0 ;
    CGFloat y = (self.height - _lineWidth) /2 ;
    //line
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddLineToPoint(ctx, self.width, y);
    CGContextSetStrokeColorWithColor(ctx, _lineColor.CGColor);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
    //cache line
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddLineToPoint(ctx, self.width * (isnan(_cachePercent)?0.0:_cachePercent), y);
    CGContextSetStrokeColorWithColor(ctx, _cacheLineColor.CGColor);//画笔颜色
    CGContextSetLineWidth(ctx, _lineWidth);//线的宽度
    CGContextSetStrokeColorWithColor(ctx, _cacheLineColor.CGColor);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
    //progress line
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddLineToPoint(ctx, self.width * (isnan(_currentPercent)?0.0:_currentPercent), y);
    CGContextSetStrokeColorWithColor(ctx, _progessLineColor.CGColor);//画笔颜色
    CGContextSetLineWidth(ctx, _lineWidth);//线的宽度
    CGContextSetStrokeColorWithColor(ctx, _progessLineColor.CGColor);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
    //指示圆圈
    CGFloat circleWidth = 1.f;
    CGContextSetStrokeColorWithColor(ctx, _circleColor.CGColor);//画笔颜色
    CGContextSetLineWidth(ctx, circleWidth);//线的宽度
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);//填充颜色
    CGContextSetShadow(ctx, CGSizeMake(1, 1), 1.f);//阴影
    CGContextAddArc(ctx, self.width * (isnan(_currentPercent)?0.0:_currentPercent), self.height/2, _circleRadius, 0, 2 * M_PI, 0); //添加一个圆
    CGContextDrawPath(ctx, kCGPathFillStroke); //绘制路径加填充
    //内层圆
    CGContextSetStrokeColorWithColor(ctx, nil);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetFillColorWithColor(ctx, _circleColor.CGColor);
    CGContextAddArc(ctx, self.width * (isnan(_currentPercent)?0.0:_currentPercent), self.height/2, _circleRadius / 2, 0, 2 * M_PI, 0);
    CGContextDrawPath(ctx, kCGPathFillStroke);

}
@end

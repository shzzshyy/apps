//
//  FYWaveView.m
//  FYAgent
//
//  Created by 曹运 on 16/8/29.
//  Copyright © 2016年 Foryou. All rights reserved.
//

#import "FYWaveView.h"

@interface FYWaveView ()
@property (assign, nonatomic) CGFloat offsetX;
@property (strong, nonatomic) CADisplayLink *waveDisplayLink;
@property (strong, nonatomic) NSMutableArray *shapeLayerArray;


@end

@implementation FYWaveView
- (NSMutableArray *)shapeLayerArray
{
    if (!_shapeLayerArray) {
        _shapeLayerArray = [NSMutableArray array];
        for (int i = 0; i<self.waveNumber; i++) {
            CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
            [_shapeLayerArray addObject:shapeLayer];
        }
        
    }
    return _shapeLayerArray;
}
+ (instancetype)addToView:(UIView *)view withFrame:(CGRect)frame bottomMargin:(CGFloat)bottomMargin waveNumber:(NSInteger)waveNumber;
{
    FYWaveView *waveView = [[self alloc] initWithFrame:frame];
    waveView.bottomMargin = bottomMargin;
    waveView.waveNumber = waveNumber;
    [view addSubview:waveView];
    return waveView;
}
+ (instancetype)addToView:(UIView *)view withFrame:(CGRect)frame topMargin:(CGFloat)topMargin waveNumber:(NSInteger)waveNumber
{
    FYWaveView *waveView = [[self alloc] initWithFrame:frame];
    waveView.topMargin = topMargin;
    waveView.waveNumber = waveNumber;
    [view addSubview:waveView];
    return waveView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self basicSetup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self basicSetup];
    }
    return self;
}

- (void)basicSetup
{
    _angularSpeed = 1.f;
    _waveSpeed = 1.f;
    _waveColor = [UIColor colorWithWhite:1 alpha:0.3];
    _waveShaDowColor = [UIColor colorWithWhite:1 alpha:0.1];
    
}
- (BOOL)wave
{
    //如果已经浪起来了则返回~
    if ([self.shapeLayerArray[0] path]) {
        return NO;
    }
    [self setupShapeLayer];
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(currentWave)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    if (self.waveTime > 0.f) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.waveTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stop];
        });
    }
    
    return YES;
}
- (void)currentWave
{
    self.offsetX -= self.waveSpeed;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    for (int i = 0; i < self.shapeLayerArray.count; i++) {
        
        CAShapeLayer *layer = self.shapeLayerArray[i];
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(0, height/2)];
        CGFloat y = 0.f;
        for (CGFloat x = 0.f; x <= width; x++) {
            CGFloat interval = self.waveNumber==2?M_PI:M_PI_2;
            if (self.isToLeft) {
                y = (height/2) *sin(0.0167*(self.angularSpeed * x - self.offsetX) + i* interval);
            }else{
                y = (height/2) *sin(0.0167*(self.angularSpeed * x + self.offsetX) + i* interval);
            }
            if(x == width/2) {
                !self.centerTopBlock?:self.centerTopBlock(self.bounds.size.height/2 - y + self.bottomMargin);
            }
            
            [bezierPath addLineToPoint:CGPointMake(x, y - self.bottomMargin)];
        }
        if (self.topMargin>0) {
            [bezierPath addLineToPoint:CGPointMake(width, 0-self.topMargin)];
            [bezierPath addLineToPoint:CGPointMake(0, 0-self.topMargin)];
        }else{
            [bezierPath addLineToPoint:CGPointMake(width, height)];
            [bezierPath addLineToPoint:CGPointMake(0, height)];
        }
        

        layer.path = bezierPath.CGPath;
    }
}
- (void)stop
{
    [UIView animateWithDuration:1.f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.waveDisplayLink invalidate];
        self.waveDisplayLink = nil;
        for (CAShapeLayer *layer in self.shapeLayerArray) {
            layer.path = nil;
        }
        self.alpha = 1.f;
    }];
}
- (void)setupShapeLayer
{
    for (int i=0; i<self.shapeLayerArray.count; i++) {
        CAShapeLayer *shapeLayer = self.shapeLayerArray[i];
        shapeLayer.strokeColor = self.waveColors.count==0 ? self.waveColor.CGColor : [self.waveColors[i] CGColor];
        shapeLayer.fillColor =  self.waveShaDowColors.count==0 ? self.waveShaDowColor.CGColor : [self.waveShaDowColors[i] CGColor];
        shapeLayer.lineWidth = 0.5;
        [self.layer addSublayer:shapeLayer];
    }
}
@end

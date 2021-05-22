//
//  ViewController.m
//  CircleMenu
//
//  Created by YLY on 16/12/24.
//  Copyright © 2016年 YLY. All rights reserved.
//

#import "ViewController.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define DIST(pointA,pointB) sqrtf((pointA.x-pointB.x)*(pointA.x-pointB.x)+(pointA.y-pointB.y)*(pointA.y-pointB.y))
#define MENURADIUS 0.5 * SCREENWIDTH
#define PROPORTION 0.45          //中心圆直径与菜单变长的比例

@interface ViewController ()

@property (nonatomic, strong) UIView *content;
@property (nonatomic, strong) NSMutableArray <UIView *> *viewArray;
@property (nonatomic, strong) UIImageView *circleView;

@end

CGPoint beginPoint;
CGPoint orgin;
CGFloat a;
CGFloat b;
CGFloat c;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray <NSString *> *imageNameArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    NSArray <NSString *> *imageTitleArray = @[@"呵呵",@"嘿嘿",@"哈哈",@"＝。＝",@"111",@"333",@"GoodGame",@"TSMTSM"];
    
//    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    bgImage.image = [UIImage imageNamed:@"main"];
//    [self.view addSubview:bgImage];
    
    _content = [[UIView alloc] initWithFrame:CGRectMake(0, 0.17 * SCREENHEIGHT, SCREENWIDTH, SCREENWIDTH)];
    _content.backgroundColor = [UIColor lightGrayColor];
//    UIImage *cir = [UIImage imageNamed:@"circle"];
//    _circleView = [[UIImageView alloc] initWithFrame:CGRectMake(0.5 * (1 - PROPORTION) * CGRectGetWidth(_content.frame) + 10, 0.5 * (1 - PROPORTION) * CGRectGetWidth(_content.frame) + 10, CGRectGetWidth(_content.frame) * PROPORTION - 20, CGRectGetWidth(_content.frame) * PROPORTION - 20)];
//    _circleView.image = cir;
 //   [_content addSubview:_circleView];
    [self.view addSubview:_content];
    [self rotationCircleCenter:CGPointMake(MENURADIUS, MENURADIUS) ContentRadius:MENURADIUS ImageNameArray:imageNameArray ImageTitleArray:imageTitleArray];

}

- (void)rotationCircleCenter:(CGPoint)contentOrgin ContentRadius:(CGFloat)contentRadius ImageNameArray:(NSArray <NSString *>*)imageNameArray ImageTitleArray:(NSArray <NSString *>*)imageTitleArray{
    _viewArray = [NSMutableArray array];
    for (int i = 0; i < imageNameArray.count; i++) {
        CGFloat x = contentRadius*sin(M_PI*2/imageNameArray.count*i);
        CGFloat y = contentRadius*cos(M_PI*2/imageNameArray.count*i);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(contentRadius + 0.5 * (1 + PROPORTION) * x - 0.5 * (1 - PROPORTION) * contentRadius, contentRadius - 0.5 * (1 + PROPORTION) * y - 0.5 * (1 - PROPORTION) * contentRadius, (1 - PROPORTION) * contentRadius, (1 - PROPORTION) * contentRadius)];
            
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame =CGRectMake(10, 0, CGRectGetWidth(view.frame) - 20, CGRectGetWidth(view.frame) - 20);
        btn.titleLabel.text = imageTitleArray[i];
        btn.titleLabel.textColor = [UIColor redColor];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick)];
        [btn addGestureRecognizer:tap];
        [btn setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateNormal];
        
        UIPanGestureRecognizer* longpress = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [btn addGestureRecognizer:longpress];

       
        [view addSubview:btn];
        [_content addSubview:view];
        [_viewArray addObject:view];
    }
}

- (void)btnClick{
    NSLog(@"123123123");
}

- (void)longPress:(UIPanGestureRecognizer*)press{
     NSLog(@"666666");
    orgin = CGPointMake(0.5 * SCREENWIDTH, MENURADIUS + 0.17 * SCREENHEIGHT);
       CGPoint currentPoint = [press locationInView:self.view];
       if ([self touchPointInsideCircle:orgin radius:MENURADIUS targetPoint:currentPoint]) {
           b = DIST(beginPoint, orgin);
           c = DIST(currentPoint, orgin);
           a = DIST(beginPoint, currentPoint);
           CGFloat angleBegin = atan2(beginPoint.y-orgin.y, beginPoint.x-orgin.x);
           CGFloat angleAfter = atan2(currentPoint.y-orgin.y, currentPoint.x-orgin.x);
           CGFloat angle = angleAfter-angleBegin;
           _content.transform = CGAffineTransformRotate(_content.transform, angle);
           _circleView.transform = CGAffineTransformRotate(_circleView.transform, -angle);
           for (int i = 0; i < _viewArray.count; i++) {
               _viewArray[i].transform = CGAffineTransformRotate(_viewArray[i].transform, -angle);
           }
           beginPoint = currentPoint;
       }
    
}

- (BOOL)touchPointInsideCircle:(CGPoint)center radius:(CGFloat)radius targetPoint:(CGPoint)point {
    CGFloat dist = DIST(point, center);
    return (dist <= radius);
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    beginPoint = [[touches anyObject] locationInView:self.view];
//}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    orgin = CGPointMake(0.5 * SCREENWIDTH, MENURADIUS + 0.17 * SCREENHEIGHT);
    CGPoint currentPoint = [[touches anyObject] locationInView:self.view];
    if ([self touchPointInsideCircle:orgin radius:MENURADIUS targetPoint:currentPoint]) {
        b = DIST(beginPoint, orgin);
        c = DIST(currentPoint, orgin);
        a = DIST(beginPoint, currentPoint);
        CGFloat angleBegin = atan2(beginPoint.y-orgin.y, beginPoint.x-orgin.x);
        CGFloat angleAfter = atan2(currentPoint.y-orgin.y, currentPoint.x-orgin.x);
        CGFloat angle = angleAfter-angleBegin;
        _content.transform = CGAffineTransformRotate(_content.transform, angle);
        _circleView.transform = CGAffineTransformRotate(_circleView.transform, -angle);
        for (int i = 0; i < _viewArray.count; i++) {
            _viewArray[i].transform = CGAffineTransformRotate(_viewArray[i].transform, -angle);
        }
        beginPoint = currentPoint;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

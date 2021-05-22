# FYWaveView
使用CAshapeLayer绘制的波浪曲线动画。

使用方法：
调用类方法  
/**
*  @param frame的高度就是波浪的高度 不包括底部距下边界距离
*  @param bottomMargin 波浪底部距下边界距离
*/
+ (instancetype)addToView:(UIView *)view withFrame:(CGRect)frame bottomMargin:(CGFloat)bottomMargin waveNumber:(NSInteger)waveNumber;
或者
/**
*  @param frame的高度就是波浪的高度 不包括底部距下边界距离
*  @param topMargin 波浪底部距上边界距离
*/
+ (instancetype)addToView:(UIView *)view withFrame:(CGRect)frame topMargin:(CGFloat)topMargin waveNumber:(NSInteger)waveNumber;

创建出waveView,然后调用 - (BOOL)wave方法即可开始动画；
相关参数：
@property (assign, nonatomic) CGFloat angularSpeed;//角度变化速度 /秒 控制一个正弦曲线的宽度

@property (assign, nonatomic) CGFloat waveSpeed; //波浪前进速度 /秒  变化的是 sin(waveSpeed) 就是上下浮动更快了

@property (assign, nonatomic) NSInteger waveNumber;//波浪数（正弦曲线数）

@property (assign, nonatomic) NSTimeInterval waveTime; //波浪翻滚时间 默认0 永动

@property (strong, nonatomic) UIColor *waveColor; //波浪线条颜色 默认白色 透明度0.3

@property (strong, nonatomic) UIColor *waveShaDowColor;//波浪下部阴影颜色 默认白色 透明度0.1

附波浪进度动画和仿淘宝顶部波浪动画demo。

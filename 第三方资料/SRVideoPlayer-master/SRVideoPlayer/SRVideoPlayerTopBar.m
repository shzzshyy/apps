//
//  SRVideoTopBar.m
//  SRVideoPlayer
//
//  Created by https://github.com/guowilling on 17/1/6.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "SRVideoPlayerTopBar.h"
#import "Masonry.h"

static const CGFloat kItemWH = 60;

#define SRVideoPlayerImageName(fileName) [@"SRVideoPlayer.bundle" stringByAppendingPathComponent:fileName]

@interface SRVideoPlayerTopBar ()

@property (nonatomic, strong) UIView *gradientView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIButton *downloadBtn;

@end

@implementation SRVideoPlayerTopBar

- (UIView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[UIView alloc] init];
        _gradientView.backgroundColor = [UIColor clearColor];
    }
    return _gradientView;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
        _gradientLayer.startPoint = CGPointMake(0.5, 1);
        _gradientLayer.endPoint = CGPointMake(0.5, 0);
    } else {
        [_gradientLayer removeFromSuperlayer];
    }
    _gradientLayer.frame = _gradientView.bounds;
    return _gradientLayer;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.showsTouchWhenHighlighted = YES;
        [_closeBtn setImage:[UIImage imageNamed:SRVideoPlayerImageName(@"close")] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}

- (UIButton *)downloadBtn {
    if (!_downloadBtn) {
        _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _downloadBtn.showsTouchWhenHighlighted = YES;
        [_downloadBtn setImage:[UIImage imageNamed:SRVideoPlayerImageName(@"download")] forState:UIControlStateNormal];
        [_downloadBtn addTarget:self action:@selector(downloadBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadBtn;
}

+ (instancetype)videoTopBar {
    return [[SRVideoPlayerTopBar alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        __weak typeof(self) weakSelf = self;
        
        [self addSubview:self.gradientView];
        [_gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(0);
        }];

        [self addSubview:self.closeBtn];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.width.height.mas_equalTo(kItemWH);
        }];
        
        [self addSubview:self.downloadBtn];
        [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(0);
            make.width.height.mas_equalTo(kItemWH);
        }];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.closeBtn.mas_right);
            make.right.mas_equalTo(weakSelf.downloadBtn.mas_left);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.gradientView.layer addSublayer:self.gradientLayer];
}

- (void)closeBtnAction {
    if ([_delegate respondsToSelector:@selector(videoPlayerTopBarDidClickCloseBtn)]) {
        [_delegate videoPlayerTopBarDidClickCloseBtn];
    }
}

- (void)downloadBtnAction {
    self.downloadBtn.userInteractionEnabled = NO;
    if ([_delegate respondsToSelector:@selector(videoPlayerTopBarDidClickDownloadBtn)]) {
        [_delegate videoPlayerTopBarDidClickDownloadBtn];
    }
}

- (void)setTitle:(NSString *)text {
    self.titleLabel.text = text;
}

@end

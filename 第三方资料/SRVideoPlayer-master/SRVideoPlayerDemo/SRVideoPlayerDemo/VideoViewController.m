//
//  VideoViewController.m
//  SRVideoPlayerDemo
//
//  Created by Willing Guo on 17/1/5.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "VideoViewController.h"
#import "SRVideoPlayer.h"
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface VideoViewController ()

@property (nonatomic, strong) SRVideoPlayer *videoPlayer;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong)UIImage *bgImage;
@property (nonatomic, strong)MPMoviePlayerController *mvPlayer;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showVideoPlayer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_videoPlayer destroy];
}

- (void)showVideoPlayer {

   UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    view.center = self.view.center;
    [self.view addSubview:view];
    _videoPlayer = [SRVideoPlayer playerWithVideoURL:_videoURL playerView:view playerSuperView:view.superview];
    _videoPlayer.videoName = @"Here Is The Video Name";
    //    _videoPlayer.playerEndAction = SRVideoPlayerEndActionLoop;
    [_videoPlayer play];
    
//    AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:_videoURL options:nil];
//
//    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:urlAsset];
//
//    imageGenerator.appliesPreferredTrackTransform = YES;    // 截图的时候调整到正确的方向
//
//    CMTime time = CMTimeMakeWithSeconds(1.0, 30);  // 1.0为截取视频1.0秒处的图片，30为每秒30帧
//
//    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:time actualTime:nil error:nil];
//
//    UIImage *image = [UIImage imageWithCGImage:cgImage];
//    NSLog(@"123");
//    [self.view addSubview:self.topImgView];
//    self.topImgView.image = image;

    
//    self.mvPlayer = [[MPMoviePlayerController alloc] initWithContentURL: _videoURL];
//    UIImage  *thumbnail = [self.mvPlayer thumbnailImageAtTime:0.1 timeOption:MPMovieTimeOptionNearestKeyFrame];//截取视频第一帧图片
//    self.topImgView.image = thumbnail;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
}

- (UIImageView *)topImgView{
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _topImgView.contentMode = UIViewContentModeScaleToFill;
        _topImgView.hidden = NO;
        _topImgView.opaque = YES;
    }
    return  _topImgView;
}

@end

//
//  FYWaveProgressController.m
//  FYWaveViewDemo
//
//  Created by 曹运 on 2016/11/20.
//  Copyright © 2016年 曹运. All rights reserved.
//

#import "FYWaveProgressController.h"
#import "FYWaveView.h"
#import "UIView+Addition.h"
@interface FYWaveProgressController ()
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (strong,nonatomic) FYWaveView *waveView;
@property (strong,nonatomic) UILabel *proNumLabel;
@property (strong,nonatomic) NSTimer *timer;
@end

@implementation FYWaveProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.progressView.layer.cornerRadius = 100;
    self.progressView.layer.masksToBounds = YES;
    self.progressView.layer.borderColor = [UIColor redColor].CGColor;
    self.progressView.layer.borderWidth = 2;
    FYWaveView *waveView = [FYWaveView addToView:self.progressView withFrame:CGRectMake(0, self.progressView.height, self.progressView.width, 20) bottomMargin:0 waveNumber:1];
    self.waveView = waveView;
    waveView.waveShaDowColor = [UIColor greenColor];
    waveView.waveSpeed = 3;
    [waveView wave];
    UILabel *proNumLabel = [[UILabel alloc] init];
    proNumLabel.textColor = [UIColor blackColor];
    proNumLabel.frame = self.progressView.bounds;
    proNumLabel.textAlignment = NSTextAlignmentCenter;
    proNumLabel.text = @"0%";
    self.proNumLabel = proNumLabel;
    [self.progressView addSubview:proNumLabel];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addProgress) userInfo:nil repeats:YES];
}
- (void)addProgress
{
    self.waveView.bottomMargin++;
    if (self.waveView.bottomMargin==self.progressView.height) {
        self.waveView.bottomMargin = 0;
    }
    self.proNumLabel.text = [NSString stringWithFormat:@"%.2f%%",(self.waveView.bottomMargin/self.progressView.height)*100];
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.waveView removeFromSuperview];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  FYTopViewController.m
//  FYWaveViewDemo
//
//  Created by 曹运 on 2016/11/20.
//  Copyright © 2016年 曹运. All rights reserved.
//

#import "FYTopViewController.h"
#import "FYWaveView.h"
#import "UIView+Addition.h"
@interface FYTopViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong,nonatomic) FYWaveView *waveView;
@property (strong,nonatomic) NSTimer *timer;
@end

@implementation FYTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.width = [UIScreen mainScreen].bounds.size.width;
    [self.view layoutIfNeeded];
    // Do any additional setup after loading the view from its nib.
    self.waveView = [FYWaveView addToView:self.topView withFrame:CGRectMake(0, 20, self.view.width, 15) topMargin:30 waveNumber:2];
    self.waveView.waveSpeed = 1.5;
    self.waveView.angularSpeed = 1.2;
    self.waveView.isToLeft = YES;
    [self.waveView wave];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(changeHeight) userInfo:nil repeats:YES];
}
- (void)changeHeight
{
    if (self.waveView.height<30) {
        self.waveView.height++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self changeHeight];
        });
    }else{
        [self minusHeight];
    }
}
- (void)minusHeight {
    if (self.waveView.height==20) {
        return;
    }else{
        self.waveView.height--;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self minusHeight];
        });
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
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

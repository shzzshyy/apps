//
//  FYUserPhotoController.m
//  FYWaveViewDemo
//
//  Created by 曹运 on 2017/2/26.
//  Copyright © 2017年 曹运. All rights reserved.
//

#import "FYUserPhotoController.h"
#import "UIView+Addition.h"
#import "FYWaveView.h"
@interface FYUserPhotoController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoBottom;
@property (strong,nonatomic) FYWaveView *waveView;
@end

@implementation FYUserPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.width = [UIScreen mainScreen].bounds.size.width;
    [self.view layoutIfNeeded];
    [self.photoView setCornerRadius:self.photoView.height/2];
    self.waveView = [FYWaveView addToView:self.topView withFrame:CGRectMake(0, self.topView.height-10, self.view.width, 20) bottomMargin:0 waveNumber:1];
    self.waveView.waveShaDowColor = [UIColor whiteColor];
    self.waveView.isToLeft = YES;
    __weak __typeof(self) weakSelf = self;
    [self.waveView setCenterTopBlock:^(CGFloat top) {
      //  NSLog(@"%f",top);
        weakSelf.photoBottom.constant = top;
        [weakSelf.photoView layoutIfNeeded];
    }];
    [self.waveView wave];
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.view removeAllSubviews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

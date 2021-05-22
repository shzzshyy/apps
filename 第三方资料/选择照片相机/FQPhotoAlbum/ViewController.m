//
//  ViewController.m
//  FQPhotoAlbum
//
//  Created by liuliu on 2017/8/30.
//  Copyright © 2017年 liuliu. All rights reserved.
//

#import "ViewController.h"
#import "FQPhotoAlbum.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (nonatomic, strong) FQPhotoAlbum      *photoAlbum;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)doChooseButton:(id)sender {
    if (!_photoAlbum) {
        _photoAlbum = [[FQPhotoAlbum alloc] init];
    }
    // 调用getPhotoAlbumOrTakeAPhotoWithController方法
    [_photoAlbum getPhotoAlbumOrTakeAPhotoWithController:self andWithBlock:^(UIImage *image) {
        self.iv.image = image;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

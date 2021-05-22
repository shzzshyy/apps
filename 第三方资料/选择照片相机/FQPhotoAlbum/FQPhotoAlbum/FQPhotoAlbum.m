//
//  FQPhotoAlbum.m
//  FQPhotoAlbum
//
//  Created by liuliu on 2017/8/30.
//  Copyright © 2017年 liuliu. All rights reserved.
//

#import "FQPhotoAlbum.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define ScreenF [UIScreen mainScreen].bounds
#define ScreenW ScreenF.size.width
#define ScreenH ScreenF.size.height
#define IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
@interface FQPhotoAlbum ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, copy) PhotoBlock photoBlock;
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) UIViewController        *viewController;
@property (nonatomic, strong) PHALModel * kvoModel;
@property (nonatomic,assign)  NSInteger sourceType;
@end
@implementation FQPhotoAlbum
- (instancetype)init {
    self = [super init];
    if (self) {
        _picker = [[UIImagePickerController alloc]init];
        _kvoModel = [[PHALModel alloc]init];
        [self.kvoModel addObserver:self forKeyPath:@"isGranted" options:
         NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                       change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    // 判断是否为kvoModel的属性“isGranted”:
    if([keyPath isEqualToString:@"isGranted"] && object == self.kvoModel) {
        NSLog(@"%@",[NSString stringWithFormat:@"当前的isGranted值为：%@",
                     [change valueForKey:@"new"]]);
        if (![[change valueForKey:@"new"] boolValue]) {
            if (IOS8) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相机未授权" message:@"请到设置-隐私-相机中修改" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *comfirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    return;
                }];
                [alertController addAction:comfirmAction];
                [self.viewController presentViewController:alertController animated:YES completion:nil];
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机未授权" message:@"请到设置-隐私-相机中修改" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            
        }else{
            [self startChoose:_sourceType];
        }
        
    }
    
}

- (void)getPhotoAlbumOrTakeAPhotoWithController:(UIViewController *)viewController andWithBlock:(PhotoBlock)photoBlock {
    self.photoBlock = photoBlock;
    self.viewController = viewController;
    if (IOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"图片" message:@"选择" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *photoAlbumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self getAlertActionType:1];
        }];
        UIAlertAction *cemeraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self getAlertActionType:2];
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self getAlertActionType:0];
        }];
        [alertController addAction:photoAlbumAction];
        [alertController addAction:cancleAction];
        if ([self imagePickerControlerIsAvailabelToCamera]) {
            [alertController addAction:cemeraAction];
        }
        [self.viewController presentViewController:alertController animated:YES completion:nil];
    } else {
        UIActionSheet *actionSheet;
        if([self imagePickerControlerIsAvailabelToCamera]){
            actionSheet  = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
        }else{
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
        }
        [actionSheet showInView:self.viewController.view];
    }
    
    
}

- (void)getAlertActionType:(NSInteger)type {
    NSInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    switch (type) {
        case 1:
        {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
            break;
        case 2:
        {
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }
            break;
        case 0:
        {
            return;
        }
            break;
            
        default:
            break;
    }
    [self creatUIImagePickerControllerWithAlertActionType:sourceType];
    
}


#pragma mark - ActionSheet Delegte
- (void)actionSheet:(UIActionSheet *)actionSheetn clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if([self imagePickerControlerIsAvailabelToCamera]){
        switch (buttonIndex){
            case 0:
            {
                sourceType = UIImagePickerControllerSourceTypeCamera;
            }
                break;
            case 1:
            {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
            }
                break;
            case 2:
                return;
        }
    } else {
        switch (buttonIndex) {
            case 0:
            {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
                break;
                
            default:
                break;
        }
    }
    [self creatUIImagePickerControllerWithAlertActionType:sourceType];
}


#pragma mark -  创建ImagePickerController
- (void)creatUIImagePickerControllerWithAlertActionType:(NSInteger)type {
    _sourceType = type;
    NSInteger sourceType = type;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        [self AVAuthorizationStatusIsGranted];
    }else{
        [self startChoose:_sourceType];
    }
}

-(void)startChoose:(NSInteger)type{
    NSInteger sourceType = type;
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
    self.picker.sourceType = sourceType;
    [self.viewController presentViewController:self.picker animated:YES completion:nil];
}

// 判断硬件是否支持拍照
- (BOOL)imagePickerControlerIsAvailabelToCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 照机授权判断
- (void)AVAuthorizationStatusIsGranted  {
    __block BOOL isGranted = NO;
    //判断是否授权相机
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    switch (authStatus) {
        case 0: { //第一次使用，则会弹出是否打开权限
            [AVCaptureDevice requestAccessForMediaType : AVMediaTypeVideo completionHandler:^(BOOL granted) {
                //授权成功
                if (granted) {
                    isGranted = YES;
                    self.kvoModel.isGranted = YES;
                }
                else{
                    isGranted = NO;
                    self.kvoModel.isGranted = NO;
                    
                }
            }];
        }
            break;
        case 1:{
            //还未授权
            isGranted = NO;
            self.kvoModel.isGranted = NO;
            
        }
            break;
        case 2:{
            //主动拒绝授权
            isGranted = NO;
            self.kvoModel.isGranted = NO;
            
        }
            break;
        case 3: {
            //已授权
            isGranted = YES;
            self.kvoModel.isGranted = YES;
            
        }
            break;
            
        default:
            break;
    }
    //    return isGranted;
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //获取编辑后的图片
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    NSLog(@"DELEGATE %@",image);
    if (self.photoBlock) {
        self.photoBlock(image);
    }
    [_picker dismissViewControllerAnimated:YES completion:nil];
}

// 取消选择照片:
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"取消图片选择");
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)dealloc{
    
    [self removeObserver:self forKeyPath:@"isGranted" context:nil];
}

@end
@implementation PHALModel
@synthesize isGranted;
@end

//
//  FQPhotoAlbum.h
//  FQPhotoAlbum
//
//  Created by liuliu on 2017/8/30.
//  Copyright © 2017年 liuliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^PhotoBlock)(UIImage *image);
@interface FQPhotoAlbum : NSObject
- (void)getPhotoAlbumOrTakeAPhotoWithController:(UIViewController *)Controller
                                   andWithBlock:(PhotoBlock)photoBlock;

@end
@interface PHALModel : NSObject

@property(nonatomic,assign)BOOL isGranted;

@end

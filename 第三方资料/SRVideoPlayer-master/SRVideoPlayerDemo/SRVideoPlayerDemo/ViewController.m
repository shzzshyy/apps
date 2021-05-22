//
//  ViewController.m
//  SRVideoPlayerDemo
//
//  Created by Willing Guo on 17/1/5.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import "VideoViewController.h"
#import<SystemConfiguration/CaptiveNetwork.h>
@interface ViewController ()

@end

@implementation ViewController

+ (NSString *)getWifiName{
    
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        
        return @"未知";
        
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
            
        }
        
    }
    
    CFRelease(wifiInterfaces);
    
    return wifiName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SRVideoPlayer";
}

- (IBAction)localBtnAction {
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"rrr" withExtension:@"mp3"];
    videoVC.videoURL = fileURL;
    [self.navigationController pushViewController:videoVC animated:YES];
}

- (IBAction)networkBtnAction {
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    NSString *videoURLString = @"http://yxfile.idealsee.com/9f6f64aca98f90b91d260555d3b41b97_mp4.mp4";
    videoVC.videoURL = [NSURL URLWithString:videoURLString];
    [self.navigationController pushViewController:videoVC animated:YES];
}

@end

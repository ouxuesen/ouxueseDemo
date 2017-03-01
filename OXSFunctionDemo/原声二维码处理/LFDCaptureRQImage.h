//
//  LFDCaptureRQImage.h
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/5.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
typedef void(^ MyBlockCompletion)(NSString * strValue);
typedef void(^ MyBlockFailure )(NSString * message);

@interface LFDCaptureRQImage : NSObject
@property(nonatomic,strong)AVCaptureVideoPreviewLayer * videoPreviewLayer;
-(void)scanningBegianWithMyBlockCompletion:(MyBlockCompletion)blockCompletion myBlockFailure:(MyBlockFailure)blockFailure;
-(void)scanningBegian;
- (void)systemLightSwitch:(BOOL)open;
//设置扫描区域
-(void)setCaptureArea:(CGRect)rectInterest;
- (void)closeQRCodeScan;
+ (BOOL)canAccessCamera;
@end

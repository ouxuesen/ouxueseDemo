//
//  LFDCaotureRQView.h
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/5.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFDCaptureRQImage.h"
@interface LFDCaptureRQView : UIView
-(void)scanningBegianWithMyBlockCompletion:(MyBlockCompletion)blockCompletion myBlockFailure:(MyBlockFailure)blockFailure;
-(void)systemLightSwitch:(BOOL)open;
@end

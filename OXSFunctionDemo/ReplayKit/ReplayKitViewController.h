//
//  ReplayKitViewController.h
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/4/20.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReplayKit/ReplayKit.h>
static NSString *StartRecord = @"开始";
static NSString *StopRecord = @"结束";

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

#define AnimationDuration (0.3)


@interface ReplayKitViewController : UIViewController <RPPreviewViewControllerDelegate>
{
    
}
@property (nonatomic, strong)UIButton *btnStart;
@property (nonatomic, strong)UIButton *btnStop;
@property (nonatomic, strong)NSTimer *progressTimer;
@property (nonatomic, strong)UIProgressView *progressView;
@property (nonatomic, strong)UIActivityIndicatorView *activity;
@property (nonatomic, strong)UIView *tipView;
@property (nonatomic, strong)UILabel *lbTip;
@property (nonatomic, strong)UILabel *lbTime;
@end

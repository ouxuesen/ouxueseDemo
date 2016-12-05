//
//  LFDCaotureRQView.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/5.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "LFDCaptureRQView.h"

@interface LFDCaptureRQView ()

{
    LFDCaptureRQImage * RQImageManager;
}
@property(nonatomic,copy)MyBlockCompletion blockCompletion;
@property(nonatomic,copy)MyBlockFailure blockFailure;
@end

@implementation LFDCaptureRQView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];

    
}
-(void)systemLightSwitch:(BOOL)open
{
    [RQImageManager systemLightSwitch:open];
}

-(void)scanningBegianWithMyBlockCompletion:(MyBlockCompletion)blockCompletion myBlockFailure:(MyBlockFailure)blockFailure
{
    _blockCompletion = blockCompletion;
    _blockFailure = blockFailure;
    [self begainScan];
}
-(void)begainScan
{
    if (![LFDCaptureRQImage canAccessCamera]) {
        NSLog( @"Access Denied. To access iPhone's Photos/Camera ,please authorize in Settings. ");
        _blockFailure?_blockFailure(@"Access Denied. To access iPhone's Photos/Camera ,please authorize in Settings."):nil;
        return;
    }
    RQImageManager = [[LFDCaptureRQImage alloc]init];
    [self.layer insertSublayer:RQImageManager.videoPreviewLayer atIndex:0];
    RQImageManager.videoPreviewLayer.frame = self.frame;

    [RQImageManager scanningBegianWithMyBlockCompletion:_blockCompletion myBlockFailure:nil];
}
@end

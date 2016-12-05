//
//  LFDCaotureRQView.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/5.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "LFDCaotureRQView.h"
#import "LFDCaptureRQImage.h"

@interface LFDCaotureRQView ()
{
    LFDCaptureRQImage * RQImageManager;
}
@end

@implementation LFDCaotureRQView

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
    if (![LFDCaptureRQImage canAccessCamera]) {
        NSLog( @"Access Denied. To access iPhone's Photos/Camera ,please authorize in Settings. ");
        return;
    }
    RQImageManager = [[LFDCaptureRQImage alloc]init];
    [self.layer insertSublayer:RQImageManager.videoPreviewLayer atIndex:0];
    RQImageManager.videoPreviewLayer.frame = self.frame;
    __weak typeof(RQImageManager) weekRQImageManager = RQImageManager;
    [RQImageManager scanningBegianWithMyBlockCompletion:^(NSString *strValue) {
        NSLog(@"strValue = %@",strValue);
        [weekRQImageManager closeQRCodeScan];
    } myBlockFailure:nil];
    
}
-(void)systemLightSwitch:(BOOL)open
{
    [RQImageManager systemLightSwitch:open];
}



@end

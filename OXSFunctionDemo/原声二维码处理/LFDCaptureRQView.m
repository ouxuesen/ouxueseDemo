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
    UIImageView * imageView =[[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"ZR_ScanFrame"];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:imageView];
    NSLayoutConstraint* centre_x = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint* centre_y = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:centre_x];
    [self addConstraint:centre_y];
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
    RQImageManager.videoPreviewLayer.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT);
    CGFloat width = 508/2;
    CGFloat height = 509/2;
    CGRect  rect = CGRectMake((WINDOW_WIDTH -width)/2, (WINDOW_HEIGHT -height)/2, height, width);
    UIView * blackView = [UIView new];
    blackView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
    blackView.frame = rect;
    [self addSubview:blackView];
    
    [RQImageManager setCaptureArea:rect];
    [RQImageManager scanningBegianWithMyBlockCompletion:_blockCompletion myBlockFailure:nil];
}
-(void)dealloc
{
    
}
@end

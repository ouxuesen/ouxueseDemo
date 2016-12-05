//
//  LFDCaptureRQImage.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/5.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "LFDCaptureRQImage.h"

@interface LFDCaptureRQImage ()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)AVCaptureMetadataOutput * output;
@property(nonatomic,copy)MyBlockCompletion blockCompletion;
@property(nonatomic,copy)MyBlockFailure blockFailure;
@end

@implementation LFDCaptureRQImage
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self configDevice];
    }
    return  self;
}
-(void)scanningBegianWithMyBlockCompletion:(MyBlockCompletion)blockCompletion myBlockFailure:(MyBlockFailure)blockFailure
{
    if (![self.session isRunning]) {
        [self.session startRunning];
    }
    _blockCompletion = blockCompletion;
    _blockFailure = blockFailure;
}
-(void)scanningBegian
{
    if (![self.session isRunning]) {
        [self.session startRunning];
    }
}
- (void)configDevice
{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if(device){
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        _output = [[AVCaptureMetadataOutput alloc]init];
        //Set delegate on running the main thread
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        self.session = [[AVCaptureSession alloc]init];
        //Adopted rate in High Capture Quality
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
        
        [self.session addInput:input];
        [self.session addOutput:_output];
        
        //Setup QR code encoding format
        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                       AVMetadataObjectTypeEAN13Code,
                                       AVMetadataObjectTypeEAN8Code,
                                       AVMetadataObjectTypeCode128Code];
        _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _videoPreviewLayer.videoGravity = AVLayerVideoGravityResize;
//        _videoPreviewLayer.frame = self.layer.bounds;
//        [self.layer insertSublayer:layer atIndex:0];
        
        //Capture Area
//        CGRect rect = self.frame;
//        int width = rect.size.width * 0.65;
//        rect.origin.x = (rect.size.width - width) / 2;
//        rect.origin.y = (rect.size.height - width) / 2;
//        rect.size.height = width;
//        rect.size.width = width;
//        self.captureRectArea = rect;
        
        //Specific scanning size area
        //        CGFloat screenHeight = self.view.frame.size.height;
        //        CGFloat screenWidth = self.view.frame.size.width;
        //        CGRect rectInterest = CGRectMake(rect.origin.x / screenWidth, rect.origin.y / screenHeight, rect.size.width / screenWidth, rect.size.height / screenHeight);
        //        [output setRectOfInterest:rectInterest];
        
        //Starting Capture
    }
}
-(void)setCaptureArea:(CGRect)rectInterest
{
   [_output setRectOfInterest:rectInterest];
}

- (void)closeQRCodeScan
{
    [self.session stopRunning];
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate event
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        NSString *svalue = metadataObject.stringValue;
        _blockCompletion?_blockCompletion(svalue):nil;
    }
    
}
- (void)systemLightSwitch:(BOOL)open
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (open) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}
+ (BOOL)canAccessCamera
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return NO;
    }
    return YES;
}

@end

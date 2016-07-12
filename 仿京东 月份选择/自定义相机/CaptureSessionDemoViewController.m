//
//  CaptureSessionDemoViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/5/17.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "CaptureSessionDemoViewController.h"
#import <AVFoundation/AVFoundation.h>  

@interface CaptureSessionDemoViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong)       AVCaptureSession            * session;

//AVCaptureSession对象来执行输入设备和输出设备之间的数据传递

@property (nonatomic, strong)       AVCaptureDeviceInput        * videoInput;
//AVCaptureDeviceInput对象是输入流
@property (nonatomic, strong)       AVCaptureStillImageOutput   * stillImageOutput;
//照片输出流对象，当然我的照相机只有拍照功能，所以只需要这个对象就够了
@property (nonatomic, strong)       AVCaptureVideoPreviewLayer  * previewLayer;
//预览图层，来显示照相机拍摄到的画面
@property (nonatomic, strong)       UIBarButtonItem             * toggleButton;
//切换前后镜头的按钮
@property (nonatomic, strong)       UIButton                    * shutterButton;
//拍照按钮
@property (nonatomic, strong)       UIView                      * cameraShowView;
@end

@implementation CaptureSessionDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initialSession];
    [self setUpCameraLayer];
    [self cameraView];
}
-(void)cameraView
{
    CGSize  size = [UIScreen mainScreen].bounds.size;
    if (self.cameraShowView == nil) {
        self.cameraShowView = [[UIView alloc]initWithFrame:CGRectMake(0, 40,size.width, 30)];
        self.cameraShowView.backgroundColor =[UIColor redColor];
        NSArray * titleS = @[@"闪光",@"翻转",@"保存"];
        CGFloat width = (size.width - 20 )/3;
        NSInteger index = 0;
        for (NSString*title in titleS) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = index;
            button.backgroundColor = [UIColor blueColor];
            [button setTitle:title forState:UIControlStateNormal];
            button.frame =CGRectMake((width +10)*index , 0, width, 30);
            index++;
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.cameraShowView addSubview:button];
        }
        [self.view addSubview:self.cameraShowView];
    }
}
-(void)btnClick:(UIButton*)btn
{
    switch (btn.tag) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            [self toggleCamera];
        }
            break;
        case 2:
        {
            [self shutterCamera];
        }
            break;
        default:
            break;
    }
}
- (void) initialSession
{
    //这个方法的执行我放在init方法里了
    self.session = [[AVCaptureSession alloc] init];
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:nil];
    //[self fronCamera]方法会返回一个AVCaptureDevice对象，因为我初始化时是采用前摄像头，所以这么写，具体的实现方法后面会介绍
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    //这是输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    [self.stillImageOutput setOutputSettings:outputSettings];
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];

    }
   
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }

    }

    return nil;

}

- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}
- (void) setUpCameraLayer
{
//    if (_cameraAvaible == NO) return;
    if (self.previewLayer == nil) {
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        [self.previewLayer setFrame:self.view.bounds];
        self.previewLayer.backgroundColor = [UIColor redColor].CGColor;
        [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
        [self.view.layer addSublayer:self.previewLayer];
    }
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.session) {
        [self.session startRunning];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear: animated];
    if (self.session) {
        [self.session stopRunning];
    }
    self.navigationController.navigationBarHidden = NO;
}
- (void)toggleCamera {
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = [[_videoInput device] position];
        if (position == AVCaptureDevicePositionBack)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
        else if (position == AVCaptureDevicePositionFront)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
        else
            return;
        if (newVideoInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.videoInput];
            if ([self.session canAddInput:newVideoInput]) {
                [self.session addInput:newVideoInput];
                [self setVideoInput:newVideoInput];
            } else {
                [self.session addInput:self.videoInput];
            }
            [self.session commitConfiguration];
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}
- (void)shutterCamera
{
    AVCaptureConnection * videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage * image = [UIImage imageWithData:imageData];
        NSLog(@"image size = %@",NSStringFromCGSize(image.size));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

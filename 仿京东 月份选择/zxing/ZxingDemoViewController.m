//
//  ZxingDemoViewController.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/2.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "ZxingDemoViewController.h"
#import <ZXMultiFormatWriter.h>
#import <ZXImage.h>


#import <ZXCGImageLuminanceSource.h>
#import "ZXLuminanceSource.h"
#import <ZXDecodeHints.h>
#import <ZXBinaryBitmap.h>
#import <ZXHybridBinarizer.h>
#import <ZXMultiFormatReader.h>
#import <ZXResult.h>
#import <ZXBarcodeFormat.h>

@interface ZxingDemoViewController ()

@end

@implementation ZxingDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGImageRef imageToDecode = nil;
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:@"https://github.com/TheLevelUp/ZXingObjC"
                                  format:kBarcodeFormatQRCode
                                   width:500
                                  height:500
                                   error:&error];
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        UIImage * iamge = [UIImage imageWithCGImage:image];
        imageView.image = iamge;
        [self.view addSubview:imageView];
        CGImageRef imageToDecode = image;
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        NSString *errorMessage = [error localizedDescription];
        NSLog(@"errorMessage = %@",errorMessage);
    }
    //接二维码
//    CGImageRef imageToDecode;  // Given a CGImage in which we are looking for barcodes
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode] ;
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    

    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *resultTemp = [reader decode:bitmap error:&error];
   
    if (resultTemp) {
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString *contents = resultTemp.text;
        
        // The barcode format, such as a QR code or UPC-A
        ZXBarcodeFormat format = resultTemp.barcodeFormat;
    } else {
        // Use error to determine why we didn't get a result, such as a barcode
        // not being found, an invalid checksum, or a format inconsistency.
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

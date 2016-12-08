//
//  ScanCaptureQRViewController.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/5.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "ScanCaptureQRViewController.h"
#import "LFDCaptureRQView.h"
#import "MCAlertController.h"
#import "LFDRQDealManger.h"

@interface ScanCaptureQRViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL OFFOn;
}
@property (weak, nonatomic) IBOutlet LFDCaptureRQView *scanView;
@end

@implementation ScanCaptureQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"闪光灯" style:UIBarButtonItemStylePlain target:self action:@selector(btnCLik:)];
       UIBarButtonItem * bbi_1 = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photoAlbum:)];
    self.navigationItem.rightBarButtonItems = @[bbi,bbi_1];
    OFFOn = YES;
    [_scanView scanningBegianWithMyBlockCompletion:^(NSString *strValue) {
        MCAlertView * alertview = [MCAlertView initWithTitle:@"二维码结果" message:strValue cancelButtonTitle:@"确定"];
        [alertview showWithCompletionBlock:nil];
    } myBlockFailure:^(NSString *message) {
        [MCAlertView showWithMessage:message];
    }];
}
-(void)btnCLik:(UIBarButtonItem*)bbi
{
    [_scanView systemLightSwitch:OFFOn];
    OFFOn = !OFFOn;
}
-(void)photoAlbum:(UIButton*)btn
{
    UIImagePickerController * imagePoikerVC = [[UIImagePickerController alloc]init];
    imagePoikerVC.view.backgroundColor = [UIColor orangeColor];
    UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePoikerVC.sourceType = sourcheType;
    imagePoikerVC.delegate = self;
    imagePoikerVC.allowsEditing = YES;
    [self presentViewController:imagePoikerVC animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate event
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    NSLog(@"rq = %@", [LFDRQDealManger identifyRQImage:image]);
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

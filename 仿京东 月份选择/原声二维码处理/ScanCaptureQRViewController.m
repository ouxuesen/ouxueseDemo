//
//  ScanCaptureQRViewController.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/5.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "ScanCaptureQRViewController.h"
#import "LFDCaotureRQView.h"
@interface ScanCaptureQRViewController ()
{
    BOOL OFFOn;
}
@property (weak, nonatomic) IBOutlet LFDCaotureRQView *scanView;
@end

@implementation ScanCaptureQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"闪光灯" style:UIBarButtonItemStylePlain target:self action:@selector(btnCLik:)];
    self.navigationItem.rightBarButtonItem = bbi;
    OFFOn = YES;
}
-(void)btnCLik:(UIBarButtonItem*)bbi
{
    [_scanView systemLightSwitch:OFFOn];
    OFFOn = !OFFOn;
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

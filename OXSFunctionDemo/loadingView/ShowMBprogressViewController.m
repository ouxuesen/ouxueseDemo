//
//  ShowMBprogressViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/4/12.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "ShowMBprogressViewController.h"
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"
@interface ShowMBprogressViewController ()

@end

@implementation ShowMBprogressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    switch (_type) {
        case 0:
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//                // Do something...
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [MBProgressHUD hideHUDForView:self.view animated:YES];
//                });
//            });
        }
            break;
        case 1:
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.labelText = @"Loading";
            hud.progress = 0.5;
//            [self doSomethingInBackgroundWithProgressCallback:^(float progress) {
//                hud.progress = progress;
//            } completionCallback:^{
//                [hud hide:YES];
//            }];
        }
            break;
        case 2:
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC);
//            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                // Do something...
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//            });
        }
            break;
        case 3:
        {
            [SVProgressHUD setBackgroundLayerColor:[UIColor redColor]];
            [SVProgressHUD setForegroundColor:[UIColor redColor]];
            [SVProgressHUD setCornerRadius:2];
            [SVProgressHUD setInfoImage:nil];
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD setFadeInAnimationDuration:0.5];
            [SVProgressHUD setFadeOutAnimationDuration:0.5];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
//            backgroundColorForStyle
//            ]
            [SVProgressHUD setMinimumSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100, 0)];
        
            [SVProgressHUD showInfoWithStatus:@"武器和废弃物分期；防火墙而未返回去发缺乏而且花费合情合法而且花费会全额返还请回复请回复请回复区"];
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0. * NSEC_PER_SEC);
//            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                // Do something...
//                [SVProgressHUD dismissWithDelay:15];
//            });
        }
            break;
        case 4:
        {
            [SVProgressHUD show];
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                // time-consuming task
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                });
//            });
        }
            break;
        default:
            break;
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

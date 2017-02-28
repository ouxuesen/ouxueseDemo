//
//  JumpAppstoreViewController.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2017/2/8.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "JumpAppstoreViewController.h"
#import <StoreKit/StoreKit.h>

@interface JumpAppstoreViewController ()<SKStoreProductViewControllerDelegate>
- (IBAction)buttonClick:(id)sender;

@end

@implementation JumpAppstoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)buttonClick:(id)sender {
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    storeProductViewContorller.delegate = self;
    //        ViewController *viewc = [[ViewController alloc]init];
    //        __weak typeof(viewc) weakViewController = viewc;
    
    //加载一个新的视图展示
    [storeProductViewContorller loadProductWithParameters:
     @{SKStoreProductParameterITunesItemIdentifier:@"1049660516"} completionBlock:^(BOOL result, NSError *error) {
         //回调
         if(error){
             NSLog(@"错误%@",error);
         }else{
             //AS应用界面
             [self.navigationController presentViewController:storeProductViewContorller animated:YES completion:nil];
         }
     }];
}
//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

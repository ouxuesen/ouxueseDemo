//
//  PresentVCViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/6/6.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "PresentVCViewController.h"
#import "PresentSubViewController.h"

@interface PresentVCViewController ()

- (IBAction)nextBtn:(id)sender;
@end

@implementation PresentVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor redColor];
    
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

- (IBAction)nextBtn:(id)sender {
    PresentSubViewController * pushVCs = [[PresentSubViewController alloc]initWithNibName:@"PresentSubViewController" bundle:nil];
    __weak PresentVCViewController * weekSelf = self;
    pushVCs.btnClick = ^(){
        [weekSelf.navigationController.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    };
    [self.navigationController presentViewController:pushVCs animated:YES completion:nil];
}
@end

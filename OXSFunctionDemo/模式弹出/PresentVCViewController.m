//
//  PresentVCViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/6/6.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "PresentVCViewController.h"
#import "LFDWTransitionContainerViewController.h"
#import "LFDWFirstTransitionView.h"

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
    
    LFDWFirstTransitionView * fistView = [[NSBundle mainBundle]loadNibNamed:@"LFDWFirstTransitionView" owner:self options:nil][0];
    fistView.edgeInset = UIEdgeInsetsMake(300, 0, 0, 0);
    LFDWTransitionContainerViewController * pushVCs = [[LFDWTransitionContainerViewController alloc]initWithNibName:@"LFDWTransitionContainerViewController" bundle:nil];
    pushVCs.defailtView = fistView;
     UINavigationController * naviVC = [[UINavigationController alloc]initWithRootViewController:pushVCs];
    naviVC.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    naviVC.modalPresentationStyle = UIModalPresentationCustom;
    naviVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;

    [self.navigationController presentViewController:naviVC animated:YES completion:nil];
    
}
@end

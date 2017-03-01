//
//  SystemQRViewController.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/2.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "SystemQRViewController.h"
#import "LFDRQDealManger.h"

@interface SystemQRViewController ()

@end

@implementation SystemQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 64, 100, 100)];
    UIImage * iamge = [LFDRQDealManger generateIamgeWithString:@"http://www.jianshu.com/p/e8f7a257b612" size:imageView.bounds.size icon:nil iconSize:CGSizeMake(60/2, 60/2)];
    imageView.image = iamge;
    [self.view addSubview:imageView];
   
    NSLog(@"http = %@",[LFDRQDealManger identifyRQImage:iamge]);
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

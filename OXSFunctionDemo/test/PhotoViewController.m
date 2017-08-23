//
//  PhotoViewController.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/14.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "PhotoViewController.h"
#import "MCGetImageAndVideoData.h"

@interface PhotoViewController ()
{
    MCGetImageAndVideoData * data;
}
@end

@implementation PhotoViewController
- (IBAction)buttonClick:(id)sender {
    if (!data) {
        data = [[MCGetImageAndVideoData alloc]init];

    }
    [data selectMediaType:MediaType_MOREPHOTOALBUM presentVC:self comleteBlock:^(id data) {
        
    }];
}

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

@end

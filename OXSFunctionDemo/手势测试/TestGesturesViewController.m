//
//  TestGesturesViewController.m
//  OXSFunctionDemo
//
//  Created by 欧学森 on 2018/6/15.
//  Copyright © 2018年 ouxuesen. All rights reserved.
//

#import "TestGesturesViewController.h"
#import "FristView.h"
#import "SecondView.h"

@interface TestGesturesViewController ()
@property (weak, nonatomic) IBOutlet FristView *firstView;
@property (weak, nonatomic) IBOutlet SecondView *secondView;

@end

@implementation TestGesturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_firstView setResponseView:_secondView];
        
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

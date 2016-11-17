//
//  AutolayoutViewController.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/11/17.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "AutolayoutViewController.h"

@interface AutolayoutViewController ()

@end

@implementation AutolayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *continerView = [[UIView alloc]init];
    continerView.backgroundColor = [UIColor redColor];
    continerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:continerView];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:continerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:200];
    NSLayoutConstraint * leftConstraint  =[NSLayoutConstraint constraintWithItem:continerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
     NSLayoutConstraint * rightConstraint  =[NSLayoutConstraint constraintWithItem:continerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:continerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:60];
    [self.view addConstraint:topConstraint];
    [self.view addConstraint:leftConstraint];
    [self.view addConstraint:rightConstraint];
    [continerView addConstraint:heightConstraint];
    NSMutableArray * tempArray = [NSMutableArray new];
    for (int i =0; i<4; i++) {
        UILabel * lable  = [[UILabel alloc]init];
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        [continerView addSubview:lable];
        lable.textAlignment  = NSTextAlignmentCenter;
        lable.text = @(i).stringValue;
        lable.backgroundColor= [UIColor whiteColor];
        [tempArray addObject:lable];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:lable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:continerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:lable attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:continerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [continerView addConstraint:topConstraint];
        [continerView addConstraint:bottomConstraint];
    }
    UILabel * lable_1 =tempArray[0];
    UILabel * lable_2 =tempArray[1];
    UILabel * lable_3 =tempArray[2];
    UILabel * lable_4 =tempArray[3];
    NSLayoutConstraint * left_1 = [NSLayoutConstraint constraintWithItem:lable_1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:continerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    [continerView addConstraint:left_1];
    NSLayoutConstraint * right_1 = [NSLayoutConstraint constraintWithItem:lable_1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:continerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    [continerView addConstraint:left_1];
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

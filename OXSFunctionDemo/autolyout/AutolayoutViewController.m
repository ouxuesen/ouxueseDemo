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
    NSLayoutConstraint * left_2 = [NSLayoutConstraint constraintWithItem:lable_2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lable_1 attribute:NSLayoutAttributeRight multiplier:1 constant:5];
    [lable_2 addConstraint:left_2];
    NSLayoutConstraint * left_3 = [NSLayoutConstraint constraintWithItem:lable_3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lable_2 attribute:NSLayoutAttributeRight multiplier:1 constant:5];
    [lable_3 addConstraint:left_3];
    NSLayoutConstraint * left_4 = [NSLayoutConstraint constraintWithItem:lable_4 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lable_3 attribute:NSLayoutAttributeRight multiplier:1 constant:5];
    [lable_4 addConstraint:left_4];
    NSLayoutConstraint * right_1 = [NSLayoutConstraint constraintWithItem:lable_4 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:lable_3 attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [continerView addConstraint:right_1];
    
    NSLayoutConstraint * width_1 = [NSLayoutConstraint constraintWithItem:lable_2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:lable_1 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [lable_2 addConstraint:width_1];
    NSLayoutConstraint * width_2 = [NSLayoutConstraint constraintWithItem:lable_3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:lable_1 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [lable_3 addConstraint:width_2];
    NSLayoutConstraint * width_3 = [NSLayoutConstraint constraintWithItem:lable_4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:lable_1 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [lable_4 addConstraint:width_3];
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

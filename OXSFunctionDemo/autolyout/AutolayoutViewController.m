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
        lable.backgroundColor = [UIColor orangeColor];
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
    [continerView addConstraint:left_2];
    NSLayoutConstraint * left_3 = [NSLayoutConstraint constraintWithItem:lable_3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lable_2 attribute:NSLayoutAttributeRight multiplier:1 constant:5];
    [continerView addConstraint:left_3];
    NSLayoutConstraint * left_4 = [NSLayoutConstraint constraintWithItem:lable_4 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lable_3 attribute:NSLayoutAttributeRight multiplier:1 constant:5];
    [continerView addConstraint:left_4];
    
    NSLayoutConstraint * right_1 = [NSLayoutConstraint constraintWithItem:lable_4 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:continerView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [continerView addConstraint:right_1];
    
    NSLayoutConstraint * width_1 = [NSLayoutConstraint constraintWithItem:lable_2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:lable_1 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [continerView addConstraint:width_1];
    NSLayoutConstraint * width_2 = [NSLayoutConstraint constraintWithItem:lable_3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:lable_1 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [continerView addConstraint:width_2];
    NSLayoutConstraint * width_3 = [NSLayoutConstraint constraintWithItem:lable_4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:lable_1 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [continerView addConstraint:width_3];
   
    //1.添加两个控件
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    
    //2.添加约束
    //2.1水平方向的约束
    NSString *hVFL = @"H:|-30-[blueView]-30-[redView(==blueView)]-30-|";
    NSArray *hCons = [NSLayoutConstraint constraintsWithVisualFormat:hVFL options:NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop metrics:nil views:@{@"blueView":blueView, @"redView":redView}];
    [self.view addConstraints:hCons];
    
    //2.2垂直方向的约束
    NSString *vVFL = @"V:[blueView(50)]-30-|";
    NSArray *vCons = [NSLayoutConstraint constraintsWithVisualFormat:vVFL options:0 metrics:nil views:@{@"blueView":blueView}];
    [self.view addConstraints:vCons];
    
    NSMutableDictionary * tempDict = [NSMutableDictionary new];
    UILabel * lableTEmp = nil;
    for (int i =0; i<4; i++) {
        UILabel * lable  = [[UILabel alloc]init];
        if (i== 0) {
            lableTEmp = lable;
        }
        lable.backgroundColor = [UIColor orangeColor];
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        [continerView addSubview:lable];
        lable.textAlignment  = NSTextAlignmentCenter;
        lable.text = @(i).stringValue;
        [tempDict setValue:lable forKey:[NSString stringWithFormat:@"lable_%d",i+1]];
        [self.view addSubview:lable];
    }
    NSArray*constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[lable_1]-5-[lable_2(==lable_1)]-5-[lable_3(==lable_2)]-5-[lable_4(==lable_3)]-5-|" options:NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop metrics:nil views:tempDict];
    [self.view addConstraints:constraints];
    NSArray*constraints_1= [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lable_1]-100-|" options:0 metrics:nil views:@{@"lable_1":lableTEmp}];
    
    [self.view addConstraints:constraints_1];
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

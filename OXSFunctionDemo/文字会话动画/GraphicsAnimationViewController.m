//
//  GraphicsAnimationViewController.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/7/3.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "GraphicsAnimationViewController.h"
#import "GraphicsAnimationLable.h"
@interface GraphicsAnimationViewController ()
@property (weak, nonatomic) IBOutlet GraphicsAnimationLable *animationLable;
- (IBAction)test:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *fondText;

@end

@implementation GraphicsAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _fondText.font = [UIFont fontWithName:@"Helvetica-Bold" size:60];
    _fondText.text =  @"我们都是好孩子";
                                                
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)test:(id)sender {
    [_animationLable startAnimation];
}
@end

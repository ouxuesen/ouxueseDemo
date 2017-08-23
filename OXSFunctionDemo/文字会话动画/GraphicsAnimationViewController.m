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

@end

@implementation GraphicsAnimationViewController

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

- (IBAction)test:(id)sender {
    [_animationLable startAnimation];
}
@end

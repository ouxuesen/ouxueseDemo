//
//  ViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/3/30.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "NSObject_Ouxuesen.h"
@interface ViewController ()
{

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MenuViewController * mainVc = [[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:mainVc];
    [self.view addSubview:navigation.view];
    [self addChildViewController:navigation];
    [ navigation.view setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin ];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"update" ofType:@"json"];
    NSError * error = nil;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jsonPath] options:kNilOptions error:&error];
    NSLog(@"dic = %@",dic);
}

-(void)creatView
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

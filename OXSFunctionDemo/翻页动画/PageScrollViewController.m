//
//  PageScrollViewController.m
//  OXSFunctionDemo
//
//  Created by 欧学森 on 2017/10/23.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "PageScrollViewController.h"
#import "BookLayout.h"
#import "BookView.h"

#import "LEDBookView.h"

@interface PageScrollViewController ()

@end

@implementation PageScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    BookLayout *layout = [[BookLayout alloc] init];
    BookView *book = [[BookView alloc] initWithFrame:CGRectMake(10, 100, 600, 270) collectionViewLayout:layout];
    [self.view addSubview:book];
    
    LEDBookView *bookView= [[LEDBookView alloc]initWithFrame:CGRectMake(10, 140, 120, 60)];
    [self.view addSubview:bookView];
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

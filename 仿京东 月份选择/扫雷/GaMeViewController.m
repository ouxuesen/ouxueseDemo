//
//  GaMeViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/6/3.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "GaMeViewController.h"
#import "GameConrierView.h"
@interface GaMeViewController ()
{
    GameConrierView * continerView;
    UILabel * stateLable;
}
@end

@implementation GaMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGSize windownSize = [[UIScreen mainScreen]bounds].size;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(restsetGame:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"重新开始" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
   
    button.frame = CGRectMake((windownSize.width -80)/2, 64, 80, 40);
     continerView = [[GameConrierView alloc]initWithFrame:CGRectMake((windownSize.width -300)/2, 114, 300, 300)];
    [continerView cretaRowCount:16 lowCount:16 booNumeber:40];
    stateLable = [[UILabel alloc]initWithFrame:CGRectMake((windownSize.width -300)/2, 114, 300, 300)];
    stateLable.backgroundColor = [UIColor clearColor];
    stateLable.userInteractionEnabled = YES;
    stateLable.textAlignment = NSTextAlignmentCenter;
    stateLable.font = [UIFont systemFontOfSize:20];
    stateLable.textColor = [UIColor redColor];
    stateLable.hidden = YES;
    __block UILabel * weekLable =stateLable;
    continerView.gameOver = ^(BOOL win){
        if (win) {
            weekLable.text = @"恭喜您赢了！";
        }else{
              weekLable.text = @"Game Over！";
        }
        weekLable.hidden = NO;
    };
    [self.view addSubview:continerView];
    [self.view addSubview:stateLable];
}
-(void)restsetGame:(UIButton*)btn
{
    [continerView restsetGame];
    stateLable.hidden = YES;
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

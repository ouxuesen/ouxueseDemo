//
//  DreawLineViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/5/27.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "DreawLineViewController.h"

@implementation LineView
- (instancetype)init
{
    self = [super init];
    if (self) {
        _shortLine = _shortBalkLine = 0.5;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    NSInteger souceIndex = floor(rect.size.width / (_shortBalkLine + _shortLine));
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0f;
    [path moveToPoint:CGPointMake(0, 0)];
    for (int i = 0; i< souceIndex; i++) {
        [path addLineToPoint:CGPointMake((_shortLine+_shortBalkLine)*i, 0)];
        [path moveToPoint:CGPointMake((_shortLine+_shortBalkLine)*i+_shortBalkLine, 0)];
    }
    [[UIColor redColor] set];
    [path stroke];
}

@end
@interface DreawLineViewController ()

@end

@implementation DreawLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    LineView * line = [[LineView alloc]init];
    line.frame = CGRectMake(10, 100, 200, 2);
    [self.view addSubview:line];
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

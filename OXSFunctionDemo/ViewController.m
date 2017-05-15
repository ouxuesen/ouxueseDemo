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
#import "RecordDateManager.h"
@interface ViewController ()
{

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [RecordDateManager sharRecordDateManager];
    [super viewDidLoad];
    NSString *bananas = @"123.321abc137d efg hij kl";
    
    NSString *separatorString = @"fg";
    
    BOOL result;
    
    
    
    NSScanner *aScanner = [NSScanner scannerWithString:bananas];
    
    
    
    //扫描字符串
    
    //扫描到指定字符串时停止，返回结果为指定字符串之前的字符串
    
    NSLog(@"扫描仪所在的位置：%lu", aScanner.scanLocation);
    
    NSString *container = nil;

    result = [aScanner scanUpToString:separatorString intoString:&container];
    
    [aScanner scanString:separatorString intoString:&container];
    NSLog(@"扫描成功：%@", result?@"YES":@"NO");
    
    NSLog(@"扫描的返回结果：%@", container);
    
    NSLog(@"扫描仪所在的位置：%lu", aScanner.scanLocation);
    
    
    
    //扫描整数
    
    //将会接着上一次扫描结束的位置继续扫描
    
    NSLog(@"-------------------------------------1");
    
    NSLog(@"扫描仪所在的位置：%lu", aScanner.scanLocation);
    
    NSInteger anInteger;
    
    result = [aScanner scanInteger:&anInteger];
    
    NSLog(@"扫描成功：%@", result?@"YES":@"NO");
    
    NSLog(@"扫描的返回结果：%ld", anInteger);
    
    NSLog(@"扫描仪所在的位置：%lu", aScanner.scanLocation);
    
    
    
    //扫描整数
    
    //将扫描仪的位置置为首位置
    
    //扫描仪默认会接着上一次扫描结束的位置开始扫描，而不是重新从首位置开始
    
    //当扫描到一个不是整数的字符时将会停止扫描（如果开始扫描的位置不为整数，则会直接停止扫描）
    
    NSLog(@"-------------------------------------2");
    
    aScanner.scanLocation = 0;      //将扫描仪的位置置为首位置
    
    NSLog(@"扫描仪所在的位置：%lu", aScanner.scanLocation);
    
    NSInteger anInteger2;
    
    result = [aScanner scanInteger:&anInteger2];
    
    NSLog(@"扫描成功：%@", result?@"YES":@"NO");
    
    NSLog(@"扫描的返回结果：%ld", anInteger2);
    
    NSLog(@"扫描仪所在的位置：%lu", aScanner.scanLocation);
    
    
    
    //扫描浮点数
    
    //当扫描到一个不是整数的字符时将会停止扫描（如果开始扫描的位置不为整数，则会直接停止扫描）
    
    NSLog(@"-------------------------------------3");
    
    aScanner.scanLocation = 0;      //将扫描仪的位置置为首位置
    
    NSLog(@"扫描仪所在的位置：%lu", aScanner.scanLocation);
    
    float aFloat;
    
    result = [aScanner scanFloat:&aFloat];
    
    NSLog(@"扫描成功：%@", result?@"YES":@"NO");
    
    NSLog(@"扫描的返回结果：%f", aFloat);
    
    NSLog(@"扫描仪所在的位置：%lu", aScanner.scanLocation);
    
    
    
    NSLog(@"-------------------------------------4");
    
    NSLog(@"所扫描的字符串：%@", aScanner.string);
    
    NSLog(@"扫描仪所在的位置：%lu", aScanner.scanLocation);
    
    NSLog(@"是否扫描到末尾：%@", aScanner.isAtEnd?@"YES":@"NO");
    
    MenuViewController * mainVc = [[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:mainVc];
    [self.view addSubview:navigation.view];
    [self addChildViewController:navigation];
    [ navigation.view setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin ];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"update" ofType:@"json"];
    NSError * error = nil;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jsonPath] options:kNilOptions error:&error];
    NSLog(@"dic = %@",dic);
    [self creatView];
}

-(void)creatView
{
    NSLog(@"中奖概率--%d",33*32*31*30*29*28/2/3/4/5/6*16);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

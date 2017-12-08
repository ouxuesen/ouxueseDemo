//
//  SystemFontViewController.m
//  OXSFunctionDemo
//
//  Created by 欧学森 on 2017/11/6.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "SystemFontViewController.h"
#import "UIView+AutoLayout.h"
#import "NSString+Common.h"

@interface SystemFontViewController ()
@property(nonatomic,strong)UIWebView* webView;
@end

@implementation SystemFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   NSArray* familyArray= [UIFont familyNames];
    CGFloat width = 200 ;
    CGFloat height = 40 ;
    NSInteger count = 0;
    for (NSString*fonyStr in familyArray) {
        NSInteger row = count/5;
        NSInteger inxex = count%5;
        UILabel*lable = [[UILabel alloc]initWithFrame:CGRectMake(inxex*(width+5), row*(height+10)+100, width, height)];
        lable.backgroundColor = [UIColor lightGrayColor];
        lable.text = @"绘本阅读";
        lable.font = [UIFont fontWithName:@"Bradley Hand" size:30];
        count++;
        [self.view addSubview:lable];
    }
    [self.view addSubview:self.webView];
    [self.webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
//    NSURL * urlStr = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"videoplay.html" ofType:nil]];
    NSURL *urlMp3 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] pathForResource:@"videoplay.html" ofType:nil]]];

    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:urlMp3];
    
  
    [self.webView loadRequest:request];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitle:@"播放视频" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [button autoSetDimension:ALDimensionHeight toSize:50];

}
-(void)buttonClick
{
    NSString*javaStr = [NSString stringWithFormat:@"window.start(%@)",[@{@"type":@"video",@"url":[[NSBundle mainBundle] pathForResource:@"vedioPath.mp4" ofType:nil]}json]];
    
    NSString* result = [_webView stringByEvaluatingJavaScriptFromString:javaStr];
    
    
    NSLog(@"result = %@",result);
    if (result.boolValue) {
        
    }else{
        
    }
}
-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initForAutoLayout];
    }
    return _webView;
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

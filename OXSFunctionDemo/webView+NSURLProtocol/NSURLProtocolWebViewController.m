//
//  NSURLProtocolWebViewController.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/6/19.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "NSURLProtocolWebViewController.h"

@interface NSURLProtocolWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation NSURLProtocolWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableURLRequest * requeset = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://news.baidu.com"]];
    [_webView loadRequest:requeset];
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

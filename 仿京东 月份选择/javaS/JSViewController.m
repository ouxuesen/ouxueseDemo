//
//  ViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/4/14.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "JSViewController.h"
#import "WebViewJavascriptBridge.h"
@interface JSViewController ()<UIWebViewDelegate>
@property(nonatomic,strong) WebViewJavascriptBridge*bridge;

@end

@implementation JSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"html/question" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES ;
    [_webView loadRequest:[NSMutableURLRequest requestWithURL:url]];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView ];
    [self.bridge registerHandler:@"ObjC Echo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        responseCallback(data);
    }];
    [self.bridge callHandler:@"JS Echo" data:@"我们都是好孩子" responseCallback:^(id responseData) {
        NSLog(@"ObjC received response: %@", responseData);
    }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
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

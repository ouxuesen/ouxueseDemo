//
//  WebViewController.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 13/02/2017.
//  Copyright © 2017 ouxuesen. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //webView
    NSString* url = @"http://baidu.com";
    NSMutableURLRequest * requeset = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableDictionary *dictSSO_TK = [NSMutableDictionary dictionary];
    [dictSSO_TK setValue:@"token" forKey:NSHTTPCookieName];
    [dictSSO_TK setValue:@"12232323" forKey:NSHTTPCookieValue];
 
    [dictSSO_TK setValue:@"baidu.com" forKey:NSHTTPCookieDomain];
    [dictSSO_TK setValue:@"/" forKey:NSHTTPCookiePath];
    NSHTTPCookie *cookieSSO_TK = [NSHTTPCookie cookieWithProperties:dictSSO_TK];

    [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookie:cookieSSO_TK];
 
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

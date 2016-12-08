//
//  SchemesViewController.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/7.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "SchemesViewController.h"

@interface SchemesViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webVIew;

@end

@implementation SchemesViewController
- (IBAction)click:(id)sender {
    NSString* urlStr = @"https://open.weixin.qq.com/sns/explorer_broker?appid=wx2f5d8f9715c59d10&redirect_uri=https%3A%2F%2Fplogin.m.jd.com%2Fcgi-bin%2Fm%2Fwxcallback%3Flsid%3Dnqsgomesu3h56zhg1oiabvc3ul6cojrb&response_type=code&scope=snsapi_userinfo&state=mvvaqvf9&connect_redirect=1";
    
//    urlStr = @"lefinance://";
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
    [_webVIew loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://plogin.m.jd.com/user/login.action?appid=100&returnurl=http%3A%2F%2Fm.jd.com%3Findexloc%3D1%26sid%3Df4e02fa955741f01c08602f7b65376aa"]];
    [_webVIew loadRequest:request];
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

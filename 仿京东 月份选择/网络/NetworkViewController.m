//
//  NetworkViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/4/13.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "NetworkViewController.h"
#import "AFNetworking.h"
@interface NetworkViewController ()

@end

@implementation NetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self sendPostRequest:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//post请求
-(void)sendPostRequest:(NSDictionary*)parameter
{
    
    NSString *url = @"http://rest.jr.letv.com/app/projectsPage/v1/528b8dc6d4252dce753117b391b7e7a11740b4ade1b51c76bbd22b16fc1346a07f2a1c660291a759c5f196a5f4bf910fecd5b7f342e14a16acfe710e2d3c80b1/0/10";
    
    
    /*!
     *
     每次请求必须的数据 随机数（token）、加密后数据（signature）
     */
    
    /*-----------------------------------------------------------------*/
    
    NSLog(@"temp===%@",url);
    /*-----------------------------------------------------------------*/
    
    //初始化网络请求
    
    
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    ////    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    ////请求时长
    manager.requestSerializer.timeoutInterval = 5;
    //发送请求
    [manager GET:url parameters:@"" success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
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

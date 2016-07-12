//
//  KeyWindowLevelViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/5/12.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "KeyWindowLevelViewController.h"
#import "MCAlertController.h";
@interface KeyWindowLevelViewController ()

@end

@implementation KeyWindowLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITextField *filed = [[UITextField alloc] initWithFrame:CGRectMake(0, 80, 320, 60)];
    filed.placeholder = @"Input something here";
    filed.clearsOnBeginEditing = YES;
    filed.borderStyle = UITextBorderStyleRoundedRect;
    [filed becomeFirstResponder];
    [self.view addSubview:filed];
    self.view.backgroundColor = [UIColor blueColor];
    UIWindow *window1 = [[UIWindow alloc] initWithFrame:CGRectMake(0, 180, 320, 320)];
    window1.backgroundColor = [UIColor redColor];
    window1.windowLevel = UIWindowLevelAlert;
    [window1 makeKeyAndVisible];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.frame = window1.bounds;
    vc.view.backgroundColor = [UIColor redColor];
    window1.rootViewController = vc;
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.frame = window1.bounds;
    vc1.view.backgroundColor = [UIColor redColor];
    
//    [MCAlertView showWithMessage:@"woeqie"];
//    UIAlertController * alerConroller = [UIAlertController alertControllerWithTitle:@"实现" message:@"我们都是好孩子" preferredStyle:UIAlertControllerStyleAlert];
    [vc presentViewController:vc1 animated:NO completion:nil];
  
    
    //首先  10 能买 5瓶酒
//    int bottles = 5;
//    int drinks  = 5;
//    int caps = 5;
//    while (bottles>=2||caps>=4) {
//        int temp = bottles/2;
//        bottles %= 2;
//        drinks += temp;
//        caps += temp;
//        bottles += temp;
//        
//        temp = caps/4;
//        caps %=4;
//        drinks += temp;
//        caps += temp;
//        bottles += temp;
//    }
//    NSLog(@"喝了%d酒 剩余%d空瓶 剩余%d瓶盖",drinks,bottles,caps);
    
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

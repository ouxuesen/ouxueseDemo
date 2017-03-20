//
//  RunLoopViewController.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 09/03/2017.
//  Copyright © 2017 ouxuesen. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)getRunloop
{
    //全局的Dictionary，key 是 pthread_t， value 是 CFRunLoopRef
    static CGMutablePathRef loopsDic;
//    static CFSpinLock_t loopsLock;

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

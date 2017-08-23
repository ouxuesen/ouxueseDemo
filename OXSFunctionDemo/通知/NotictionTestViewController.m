//
//  NotictionTestViewController.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/6/30.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "NotictionTestViewController.h"
#define NotificationTEST @"NotificationTest"
@interface NotictionTestViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titlelable;
- (IBAction)touchButton:(id)sender;

@end

@implementation NotictionTestViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resiveNotfication:) name:NotificationTEST object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)resiveNotfication:(NSNotification*)not
{
    
    NSLog(@"接受通知 -- %@",[NSThread currentThread]);
//    self.titlelable.text = @"1234";
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

- (IBAction)touchButton:(UIButton*)sender {
    if (sender.tag == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTEST object:nil];
         NSLog(@"发送通知……%@",[NSThread currentThread]);
    }else if (sender.tag == 1){
        
        NSOperationQueue * queue = [[NSOperationQueue alloc]init];
        NSBlockOperation *opreation = [NSBlockOperation blockOperationWithBlock:^{
         [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTEST object:nil];
             NSLog(@"发送通知……%@",[NSThread currentThread]);
        }];
        [queue addOperations:@[opreation] waitUntilFinished:NO];
       
    }else{
        dispatch_queue_t myQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(myQueue, ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTEST object:nil];
            NSLog(@"发送通知……%@",[NSThread currentThread]);
        });
    }
}
@end

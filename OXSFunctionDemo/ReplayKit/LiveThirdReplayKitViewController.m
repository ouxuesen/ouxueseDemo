//
//  LiveThirdReplayKitViewController.m
//  OXSFunctionDemo
//
//  Created by 欧学森 on 2017/7/21.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "LiveThirdReplayKitViewController.h"
#import "BaibanView.h"
#import <ReplayKit/ReplayKit.h>

@interface LiveThirdReplayKitViewController ()<RPBroadcastControllerDelegate,RPBroadcastActivityViewControllerDelegate>
@property (nonatomic,strong) BaibanView  *baibanV;
@property (nonatomic, weak) RPBroadcastController *broadcastController;
@end

@implementation LiveThirdReplayKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"打开第三方直播软件";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加画板功能
    [self.view addSubview:self.baibanV];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithTitle:@"打开" style:UIBarButtonItemStylePlain target:self action:@selector(openThired:)];

    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self setupBroadcastUI];
}
-(void)openThired:(UIBarButtonItem*)bar
{
    [self didPressBroadcast];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BaibanView *)baibanV{
    if(_baibanV==nil){
        _baibanV=[[BaibanView alloc] initWithFrame:CGRectMake(0, 64, WINDOW_WIDTH, WINDOW_HEIGHT - 64)];
    }
    return  _baibanV;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Setup ReplayKit Live
- (void)setupBroadcastUI {
    
    //
    // Enable Microphone and Camera
    //
    RPScreenRecorder * recorder = [RPScreenRecorder sharedRecorder];
    
    
    if([recorder respondsToSelector:@selector(setCameraEnabled:)])
    {
        // This test will fail on devices < iOS 9
        
        [RPScreenRecorder sharedRecorder].microphoneEnabled = YES;
        [RPScreenRecorder sharedRecorder].cameraEnabled = YES;
        
        [[AVAudioSession sharedInstance] requestRecordPermission: ^(BOOL granted){
            
        }];
        // Get notified when app is returned to active state or
        // is moved into the foreground
        //
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(resumeBroadcast)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:[UIApplication sharedApplication]];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(resumeBroadcast)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:[UIApplication sharedApplication]];
    }
    
}
- (void)resumeBroadcast
{
    // Tell ReplayKit to Resume broadcasting
    
    if(self.broadcastController.paused)
    {
        [self.broadcastController resumeBroadcast];
    }
}

#pragma mark - Handle Broadcast Button Touch
- (void)didPressBroadcast {
    
    __weak LiveThirdReplayKitViewController* bSelf = self;
    if (![RPScreenRecorder sharedRecorder].isRecording) {
        
        // We aren't currently broadcasting, bring up the share sheet.
        
        [RPBroadcastActivityViewController loadBroadcastActivityViewControllerWithHandler:^(RPBroadcastActivityViewController * _Nullable broadcastActivityViewController, NSError * _Nullable error) {
            
            
            // Here we are going to bring up the Broadcast share sheet where the user will be able to pick
            // a broadcast provider
            
            broadcastActivityViewController.delegate = bSelf;
            broadcastActivityViewController.modalPresentationStyle = UIModalPresentationPopover;
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                broadcastActivityViewController.popoverPresentationController.sourceRect = bSelf.view.frame;
                broadcastActivityViewController.popoverPresentationController.sourceView = bSelf.view;
            }
            
            
            [bSelf presentViewController:broadcastActivityViewController animated:YES completion:nil];
        }];
        
    } else {
        // We are currently broadcasting, disconnect.
        NSLog(@"Disconnecting");
        [self.broadcastController finishBroadcastWithHandler:^(NSError * _Nullable error) {
//            bSelf.chatURL = nil;
//            [bSelf tap:nil];
//            [bSelf.broadcastButton setImage:[UIImage imageNamed:@"broadcast_button"] forState:UIControlStateNormal];
//            [bSelf.cameraPreview removeFromSuperview];
            
        }];
    }
}
#pragma mark - Broadcasting
- (void)broadcastActivityViewController:(RPBroadcastActivityViewController *)broadcastActivityViewController
       didFinishWithBroadcastController:(RPBroadcastController *)broadcastController
                                  error:(NSError *)error
{
    
    NSLog(@"BAC: %@ didFinishWBC: %@, err: %@",
          broadcastActivityViewController,
          broadcastController,
          error);
    
    // User has selected a broadcast service, now we should start streaming.
    
    [broadcastActivityViewController dismissViewControllerAnimated:YES completion:nil];
    
    if([broadcastController.broadcastExtensionBundleID rangeOfString:@"com.mobcrush.Mobcrush"].location != NSNotFound)
    {
        // User has chosen Mobcrush. We can use the broadcast URL to generate the user's chat URL by
        // appending "/chat" to the end of it.
//        self.chatURL = [NSURL URLWithString:[broadcastController.broadcastURL.absoluteString stringByAppendingString:@"/chat"]];
    }
    self.broadcastController = broadcastController;
    
    __weak LiveThirdReplayKitViewController* bSelf = self;
    if(!error)
    {
        [broadcastController startBroadcastWithHandler:^(NSError * _Nullable error) {
            
            NSLog(@"broadcastControllerHandler");
            if (!error) {
                
                // Broadcast has started
                bSelf.broadcastController.delegate = self;
                
//                [bSelf.broadcastButton setImage:[UIImage imageNamed:@"broadcast_button_on"] forState:UIControlStateNormal];
                
                UIView* cameraView = [[RPScreenRecorder sharedRecorder] cameraPreviewView];
//                bSelf.cameraPreview = cameraView;
                
                if(cameraView)
                {
                    // If the camera is enabled, create the camera preview and add it to the game's UIView
                    
                    cameraView.frame = CGRectMake(0, 0, 200, 200);
                    [bSelf.view addSubview:cameraView];
                    {
                        // Add a gesture recognizer so the user can drag the camera around the screen
//                        UIPanGestureRecognizer* gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//                        [gr setMinimumNumberOfTouches:1];
//                        [gr setMaximumNumberOfTouches:1];
//                        [cameraView addGestureRecognizer:gr];
                    }
                    {
//                        UITapGestureRecognizer* gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//                        [cameraView addGestureRecognizer:gr];
                    }
                }
                
            }
            else {
                // Some error has occurred starting the broadcast, surface it to the user.
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                         message:error.localizedDescription
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
                
                [self presentViewController:alertController
                                   animated:YES
                                 completion:nil];
                
            }
        }];
    }
    else
    {
        NSLog(@"Error returning from Broadcast Activity: %@", error);
    }
    
}

// Watch for service info from broadcast service
- (void)broadcastController:(RPBroadcastController *)broadcastController
       didUpdateServiceInfo:(NSDictionary <NSString *, NSObject <NSCoding> *> *)serviceInfo
{
    NSLog(@"didUpdateServiceInfo: %@", serviceInfo);
}

// Broadcast service encountered an error
- (void)broadcastController:(RPBroadcastController *)broadcastController
         didFinishWithError:(NSError *)error
{
    NSLog(@"didFinishWithError: %@", error);
    
}
@end

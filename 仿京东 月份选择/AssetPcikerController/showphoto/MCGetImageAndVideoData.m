//
//  MCGetImageAndVideoData.m
//  MCFriends
//
//  Created by bob on 14-3-24.
//  Copyright (c) 2014年 oxs. All rights reserved.
//

#import "MCGetImageAndVideoData.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@implementation ASKPermissions

+ (BOOL)cameraGranted
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
         [MCAlertView showWithMessage:@"请在设备的\"设置-隐私-相机\"中允许访问相机。"];
        return NO;
    }
    return YES;
    
}

+ (BOOL)photoAlbumGranted
{
    if (ShortSystemVersion >= 8) {
        PHAuthorizationStatus auth = [PHPhotoLibrary authorizationStatus];
        if(auth == PHAuthorizationStatusDenied || auth == PHAuthorizationStatusRestricted){
            [MCAlertView showWithMessage:@"请在设备的\”设置-隐私-照片\“中允许访问相册。"];
            return NO;
        }
    } else {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusDenied || authStatus == ALAuthorizationStatusRestricted) {
            [MCAlertView showWithMessage:@"请在设备的\”设置-隐私-照片\“中允许访问相册。"];
            return NO;
        }
    }
    return YES;
    
}


@end
#define kStrFor(String) [NSString stringWithFormat:@"%d", String]

@interface MCGetImageAndVideoData ()

{
    BOOL isCameraTake;
}

@end

@implementation MCGetImageAndVideoData

- (id)init
{
    if (self = [super init]) {
        _photoNum = 8;
    }
    return self;
}

- (void)selectMediaType:(MediaType)videoType  presentVC:(UIViewController*)presentVC comleteBlock:(completeBlock)comleteblock
{
    _videoType = videoType;
    _presentVC = presentVC;
    _completeblock = comleteblock;
    [self choosePublishType:videoType];
    
}
//发布动态选择图片或视频
- (void)choosePublishType:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
          case 0:
        {
            //照相
            if (![ASKPermissions cameraGranted]) {
                return;
            }
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                
                [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
                [imagePicker setDelegate:self];
//                [imagePicker setAllowsEditing:NO];
                [_presentVC presentViewController:imagePicker animated:YES completion:nil];
            }
        }
            break;
        case 1:
        {
            if (![ASKPermissions cameraGranted]) {
                return;
            }
            
            //拍视频 和照相
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                
                NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
                picker.mediaTypes = temp_MediaTypes;
                picker.delegate = self;
                picker.allowsEditing = NO;
                if (_videoMaximumDuration >0) {
                    picker.videoMaximumDuration = _videoMaximumDuration;
                }
                
                [_presentVC presentViewController:picker animated:YES completion:nil];
            }
        }
            break;
        case 2:
        {
            if (![ASKPermissions cameraGranted]) {
                return;
            }
            //摄像
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
                [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
                imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
                [imagePicker setDelegate:self];
                [imagePicker setAllowsEditing:NO];
                [_presentVC presentViewController:imagePicker animated:YES completion:nil];
            }
        }
            break;
        case 3:
        {
            //本地相册
            if (![ASKPermissions photoAlbumGranted]) {
                return;
            }
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //            imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMPEG, nil];
                [_presentVC presentViewController:imagePicker animated:YES completion:nil];
            }
   
        }
            break;
        case 4:
        {
            if (![ASKPermissions photoAlbumGranted]) {
                return;
            }

            //本地视频
            isCameraTake = NO;
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
           
            [_presentVC presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 5:
        {
            if (![ASKPermissions photoAlbumGranted]) {
                return;
            }
            
            //本地相册 选择多张
            isCameraTake = NO;
            
            PhotoAlbumViewController *imagePicker = [[PhotoAlbumViewController alloc] init];
            UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:imagePicker];
            [imagePicker getSelectAssetsMaximumNumberOfSelection:8 CompleteBlock:^(NSArray *assets) {
                _completeblock?_completeblock(assets):nil;
            }];
            [_presentVC presentViewController:navigation animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage * image = info[UIImagePickerControllerOriginalImage];
       
      _completeblock?_completeblock(image):nil;
        
    } else if ([mediaType isEqualToString:(NSString*)kUTTypeMovie]) {

        //存储拍摄的视频文件路径
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"found a video ====== %@", videoURL);
        AVAsset *avAsset = [AVAsset assetWithURL:videoURL];
        _completeblock?_completeblock(avAsset):nil;
       
    }
     [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc
{
   
    NSLog(@"释放了--%@", NSStringFromClass([self class]));
}

@end

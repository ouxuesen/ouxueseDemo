//
//  MCGetImageAndVideoData.h
//  MCFriends
//
//  Created by bob on 14-3-24.
//  Copyright (c) 2014年 oxs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoAlbumViewController.h"
#import "MCAlertController.h"

@interface ASKPermissions : NSObject

@end


//选中button的类型 调用不同的模式
typedef enum {
    MediaType_CAMERAPHOTO =0,   //拍照
    MediaType_CAMERAANDPHOTO,   // 拍照和摄像
    MediaType_CAMERA,           //拍视频
    MediaType_PHOTOALBUM,       //本地相册
    MediaType_CAMERALBUM,       //本地视频
    MediaType_MOREPHOTOALBUM    //本地相册多张
} MediaType;

typedef void (^completeBlock)(id data); 

@interface MCGetImageAndVideoData : NSObject< UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    completeBlock _completeblock;
}
//相机类型
@property (nonatomic, assign) MediaType videoType;

@property (nonatomic, weak) UIViewController *presentVC;

//录像的最多时长

@property (nonatomic, assign) double videoMaximumDuration;
//可选择图片的数量
@property (nonatomic, assign) NSInteger photoNum;


/*-----------------------------------------------*/
- (void)selectMediaType:(MediaType)videoType  presentVC:(UIViewController*)presentVC comleteBlock:(completeBlock)comleteblock;

@end

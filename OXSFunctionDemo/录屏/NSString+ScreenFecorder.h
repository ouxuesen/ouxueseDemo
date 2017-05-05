//
//  NSString+ScreenFecorder.h
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/4/24.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface NSString (ScreenFecorder)
/**
 *  获取视频的缩略图方法
 *
 *  @param filePath 视频的本地路径
 *
 *  @return 视频截图
 */
+(UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath;
//单个文件的大小
+ (NSString *)fileSizeAtPath:(NSString*) filePath;
//获取/Documents/myVideo/目录下的所有mp4后缀的文件路径并返回数组
+(NSMutableArray *)getAllMp4Name;
//获取/Documents/myVideo/目录下的所有mp4后缀的文件路径并返回数组
+(NSMutableArray *)getAllMp4path;

@end

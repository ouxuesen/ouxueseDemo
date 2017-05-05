//
//  NSString+ScreenFecorder.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/4/24.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "NSString+ScreenFecorder.h"

@implementation NSString (ScreenFecorder)
/**
 *  获取视频的缩略图方法
 *
 *  @param filePath 视频的本地路径
 *
 *  @return 视频截图
 */
+ (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath{
    
    UIImage *shotImage;
    //视频路径URL
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:fileURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    shotImage = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return shotImage;
    
}

//单个文件的大小
+ (NSString *) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* managerFile = [NSFileManager defaultManager];
    
    if ([managerFile fileExistsAtPath:filePath]){
        CGFloat oSize =[[managerFile attributesOfItemAtPath:filePath error:nil] fileSize]/1024.0;
        if (oSize<1024.0) {
            return [NSString stringWithFormat:@"%.2f KB",oSize];
        }else if (oSize<(1024.0*1024.0))
        {
            return [NSString stringWithFormat:@"%.2f M",oSize/1024];
        }else
        {
            return [NSString stringWithFormat:@"%.2f G",oSize/(1024*1024)];
        }
    }
    return @"0";
}

//获取/Documents/myVideo/目录下的所有mp4后缀的文件路径并返回数组
+(NSMutableArray *)getAllMp4Name
{
    NSString *fileWithstudentNumber = [NSHomeDirectory() stringByAppendingString:@"/Documents/myVideo"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator = [fileManager enumeratorAtPath:fileWithstudentNumber];
    NSMutableArray *filePathArray = [[NSMutableArray alloc]init];   //用来存目录名字的数组
    NSString *file;
    while((file=[myDirectoryEnumerator nextObject]))     //遍历当前目录
    {
        if([[file pathExtension] isEqualToString:@"mp4"])  //取得后缀名为.mp4的文件名
        {
            [filePathArray addObject:file];//存到数组
        }
        
    }
    return filePathArray;
    
}

//获取/Documents/myVideo/目录下的所有mp4后缀的文件路径并返回数组
+(NSMutableArray *)getAllMp4path
{
    NSString *fileWithstudentNumber = [NSHomeDirectory() stringByAppendingString:@"/Documents/myVideo"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator = [fileManager enumeratorAtPath:fileWithstudentNumber];
    NSMutableArray *filePathArray = [[NSMutableArray alloc]init];   //用来存目录名字的数组
    NSString *file;
    while((file=[myDirectoryEnumerator nextObject]))     //遍历当前目录
    {
        if([[file pathExtension] isEqualToString:@"mp4"])  //取得后缀名为.mp4的文件名
        {
            [filePathArray addObject:[fileWithstudentNumber stringByAppendingPathComponent:file]];//存到数组
        }
        
    }
    return filePathArray;
    
}


@end

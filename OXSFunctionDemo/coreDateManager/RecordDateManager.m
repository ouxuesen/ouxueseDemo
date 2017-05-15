//
//  RecordDateManager.m
//  LeFinanciaLine
//
//  Created by ouxuesen on 2017/5/8.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "RecordDateManager.h"

@interface RecordDateManager ()

@end
@implementation RecordDateManager

+(instancetype)sharRecordDateManager
{
    static RecordDateManager*dateManager = nil;
    if (!dateManager) {
        dateManager = [[RecordDateManager alloc]init];
    }
    return dateManager;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        NSString *aString = @"f1234abcdwihqfaio;fa;fha";
        NSData *aData = [aString dataUsingEncoding: NSUTF8StringEncoding];
        [self fileWithJson:aData];
    }
    return self;
}



-(void)syncCacheDate
{
    dispatch_queue_t queue = dispatch_queue_create("crateSyccCancheDateQueue", NULL); // 创建
    dispatch_sync(queue, ^{
        
    });

}
-(void)fileWithJson:(NSData*)jsonDate
{
    //将Json存进本地文件夹
    
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *Json_path=[path stringByAppendingPathComponent:@"JsonFile.json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:Json_path]) {
        [fileManager createFileAtPath:Json_path contents:jsonDate attributes:nil];
    }
    //==写入文件
    if ([jsonDate writeToFile:Json_path atomically:YES]) {
        NSLog(@"写入文件成功");
    }
    
//   // 读取Json
//    //==Json文件路径
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path=[paths objectAtIndex:0];
//    NSString *Json_path=[path stringByAppendingPathComponent:@"JsonFile.json"];
//    //==Json数据
//    NSData *data=[NSData dataWithContentsOfFile:Json_path];
//    //==JsonObject
//    
//    id JsonObject=[NSJSONSerialization JSONObjectWithData:data
//                                                  options:NSJSONReadingAllowFragments
//                                                    error:&error]
//    //nslog (@"%@",jsonobject);打印json字典
}

@end

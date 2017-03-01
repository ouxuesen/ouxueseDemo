//
//  LFDRQDealManger.h
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/2.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LFDRQDealManger : NSObject
+(NSString*)identifyRQImage:(UIImage*)QRimage;
+(UIImage*)generateIamgeWithString:(NSString*)QRstring size:(CGSize)size icon:(UIImage*)icon iconSize:(CGSize)iconSize;
@end

//  Created by chen ying on 12-11-6.
//  Copyright (c) 2012年 hoolai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
//#import <UIKit/UIKit.h>


@interface NSObject (Common)
- (NSString *)json;
@end

//产品标
@interface NSString (ProductPropertiesType)

-(BOOL)isStaff;
-(BOOL)isNewUser;
-(BOOL)isTransfer;
- (BOOL)isNewCurrent;
@end

@interface NSString (Common)

// 常用加密方法
- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)sha512;
- (NSString *)encode;
- (NSString *)decode;

- (id)object;
// 验证邮箱
-(BOOL)isValidateEmail;

// 验证身份证号码
- (BOOL)isValidateIDCard;

// 验证手机号码
- (BOOL)isValidateMobileNumber;
//海外手机号
- (BOOL)isOverseasValidateMobileNumber;
// 验证银行卡 (模10“隔位乘2加”校验数算法)，字符串中若包含空格会被自动剔除后计算
//- (BOOL)isValidCardNumber;

// 正则判断手机号码地址格式
- (BOOL)isMobileNumber;

//是否含有系统表情
- (BOOL)isContainEmoji;

// 是否网络资源
- (BOOL)isWebURL;

- (float)stringWidthWithFont:(UIFont *)font height:(float)height;
- (float)stringHeightWithFont:(UIFont *)font width:(float)width;
//星座
-(NSString*)getAstor;


@end

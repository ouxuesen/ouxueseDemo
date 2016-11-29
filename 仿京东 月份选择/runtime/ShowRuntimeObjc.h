//
//  ShowRuntimeObjc.h
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/11/25.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowRuntimeObjc : NSObject<NSCopying>
{
    NSArray * mutableTemp ;
}
@property(nonatomic,copy) NSString* name;
@property(nonatomic,copy) NSString* age;
@property(nonatomic,copy) NSString* old;
-(void)oneMethod;
-(void)twoMethod;
-(instancetype)thirdMethod;

@end

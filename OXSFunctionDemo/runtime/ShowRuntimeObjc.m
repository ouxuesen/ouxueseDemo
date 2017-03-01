//
//  ShowRuntimeObjc.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/11/25.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "ShowRuntimeObjc.h"
#import <objc/runtime.h>
@implementation ShowRuntimeObjc
-(void)oneMethod
{
    
}
-(void)twoMethod
{
    
}
-(instancetype)thirdMethod
{
    return nil ;
}
void runAddMethod(id self, SEL _cmd, NSString *string){
    NSLog(@"add %@ IMP ", string);
}
//实例化方法处理
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    
    //给本类动态添加一个方法
    if ([NSStringFromSelector(sel) isEqualToString:@"resolveAdd:"]) {
        class_addMethod(self, sel, (IMP)[self instanceMethodForSelector:@selector(runAddMethod:)], "v@:*");
    }
    return YES;
}
//类方法处理
+(BOOL)resolveClassMethod:(SEL)sel
{
    //给本类动态添加一个方法
    if ([NSStringFromSelector(sel) isEqualToString:@"resolveAdd:"]) {
        class_addMethod(self, sel, (IMP)[self instanceMethodForSelector:@selector(runAddMethod:)], "v@:*");
    }
    return YES;
}

/*
 class_addMethod(self, sel, (IMP)[self instanceMethodForSelector:@selector(runAddMethod:)], "v@:*")
 Class cls 给哪个类添加方法，本例中是self
 SEL name 添加的方法，本例中是重写的拦截调用传进来的selector。
 IMP imp 方法的实现，C方法的方法实现可以直接获得。如果是OC方法，可以用+ (IMP)instanceMethodForSelector:(SEL)aSelector;获得方法的实现。
 "v@:*"方法的签名，代表有一个参数的方法。
 
 */
-(void)runAddMethod:(NSString*)sting
{
    NSLog(@"add %@ IMP ", sting);
}


@end

//
//  RuntimeDemoViewController.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/11/25.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "RuntimeDemoViewController.h"
#import "ShowRuntimeObjc.h"
#import <objc/runtime.h>
@interface RuntimeDemoViewController ()

@end

@implementation RuntimeDemoViewController

+(void)load
{
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(viewWillAppear:);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel = @selector(swiz_viewWillAppear:);
        //两个方法的Method
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
        
    });
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    unsigned int count;
    objc_property_t * propertyList = class_copyPropertyList([ShowRuntimeObjc class], &count);
    for (unsigned int i = 0; i<count; i++) {
        const char * propertyname = property_getName(propertyList[i]);
        NSLog(@"property-->%@",[NSString stringWithUTF8String:propertyname]);
    }
    //或者方法列表
    Method *metgodList = class_copyMethodList([ShowRuntimeObjc class], &count);
    for (unsigned int i= 0; i<count; i++) {
        Method method = metgodList[i];

        NSLog(@"method --- >%@",NSStringFromSelector(method_getName(method)));
     }
    //获取成员变量
    Ivar * ivarList = class_copyIvarList([ShowRuntimeObjc class], &count);
    for (unsigned int i= 0; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([ShowRuntimeObjc class], &count);
    for (unsigned int i= 0; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
    ShowRuntimeObjc* tempObjc =   [[ShowRuntimeObjc alloc]init];
    [tempObjc performSelector:@selector(resolveAdd:) withObject:@"test"];
    
//    objc_property_t *property_Pro = protocol_copyPropertyList([ShowRuntimeObjc class], &count);
//    
//    for (unsigned int i = 0; i<count; i++) {
//        const char * propertyname = property_getName(property_Pro[i]);
//        NSLog(@"protocol-->%@",[NSString stringWithUTF8String:propertyname]);
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)swiz_viewWillAppear:(BOOL)animated{
//    //这时候调用自己，看起来像是死循环
//    //但是其实自己的实现已经被替换了
//    [self swiz_viewWillAppear:animated];
//    NSLog(@"swizzle");
//}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

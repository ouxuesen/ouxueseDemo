//
//  MenuModel.h
//  OXSFunctionDemo
//
//  Created by ouxuesen on 21/03/2017.
//  Copyright © 2017 ouxuesen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuSecondModel : NSObject
@property(nonatomic,assign)BOOL isopen; // 是否折叠
@property(nonatomic,copy)NSString* secondConteStr;// 目录名字
@property(nonatomic,strong) NSMutableArray<NSString*>* secondListArray;//三级目录名字

@end
@interface MenuModel : NSObject
@property(nonatomic,assign)BOOL isopen; // 是否折叠
@property(nonatomic,copy)NSString* conteStr;// 目录名字
@property(nonatomic,strong) NSMutableArray<MenuSecondModel*>* listArray;
@end

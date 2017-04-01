//
//  MenuModel.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 21/03/2017.
//  Copyright © 2017 ouxuesen. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuSecondModel
-(instancetype)init
{
    self = [super init];
    if (self) {
        _secondListArray = [NSMutableArray new];
    }
    return self;
}
@end
@implementation MenuModel
-(instancetype)init
{
    self = [super init];
    if (self) {
        _listArray = [NSMutableArray new];
    }
    return self;
}
@end

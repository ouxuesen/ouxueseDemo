//
//  LFDWPickSheetView.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/28.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "LFDWPickSheetView.h"

@implementation LFDWPickSheetView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initRestView];
}

-(instancetype)init
{
    self = [super init];
    if (self) {
         [self initRestView];
    }
    return self;
}
-(void)initRestView
{
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
}

@end

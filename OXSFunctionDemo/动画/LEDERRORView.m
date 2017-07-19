//
//  LEDERRORView.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/6/15.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "LEDERRORView.h"

@interface LEDERRORView ()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLable;

@end

@implementation LEDERRORView

-(void)awakeFromNib
{
    [super awakeFromNib];
    _backImageView.image = [[UIImage imageNamed:@"bg_bai"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
}

@end

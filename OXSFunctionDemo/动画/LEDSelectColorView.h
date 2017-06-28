//
//  LEDSelectColorView.h
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/6/15.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectColorBlock)(UIColor*color);

@interface LEDSelectColorView : UIView
@property (nonatomic,copy) SelectColorBlock selectColor;

-(void)showViewWithSupview:(UIView*)supview blowView:(UIView*)blowView selectColor:(SelectColorBlock)selectColor;

@end

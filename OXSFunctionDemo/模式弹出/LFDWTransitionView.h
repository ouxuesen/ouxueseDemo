//
//  LFDWTransitionView.h
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/26.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFDWTransitionMethods.h"


@interface LFDWTransitionView : UIView <LFDWTransitionMethods>
//top 表示高度  right 表示宽度  其他不变
@property (nonatomic,assign) UIEdgeInsets edgeInset;
@property (nonatomic,assign) NSLayoutConstraint *heightConstraint;
@property (nonatomic,assign) NSLayoutConstraint * leftConstraint;
@property (nonatomic,assign) NSLayoutConstraint * widthConstraint;
@property (nonatomic,assign) NSLayoutConstraint * bottomConstraint;

//
@property (nonatomic,strong)UIViewController *transitionContainerVC;
@end

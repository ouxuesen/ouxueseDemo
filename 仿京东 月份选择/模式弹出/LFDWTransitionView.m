//
//  LFDWTransitionView.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/26.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "LFDWTransitionView.h"
#import "LFDWTransitionContainerViewController.h"

@implementation LFDWTransitionView

- (LFDWTransitionContainerViewController *)transitionContainerVC
{
    if (!_transitionContainerVC) {
        for (UIView* next = [self superview]; next; next = next.superview) {
            UIResponder* nextResponder = [next nextResponder];
            if ([nextResponder isKindOfClass:[LFDWTransitionContainerViewController class]]) {
                    _transitionContainerVC = (LFDWTransitionContainerViewController *)nextResponder;
            }
        }
    }
    return(LFDWTransitionContainerViewController*) _transitionContainerVC;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return  self;
}
-(void)viewWillAppear
{
    
}
-(void)viewWillDisappear
{
    
}
-(void)viewDidAppear
{
    
}
-(void)viewDidDisappear
{
    
}


@end

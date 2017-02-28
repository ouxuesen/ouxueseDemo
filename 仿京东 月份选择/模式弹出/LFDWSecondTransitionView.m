//
//  LFDWSecondTransitionView.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/26.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "LFDWSecondTransitionView.h"
#import "LFDWTransitionContainerViewController.h"
@implementation LFDWSecondTransitionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)back:(id)sender {
      [(LFDWTransitionContainerViewController*)self.transitionContainerVC  popViewAnimated:YES];
}

@end

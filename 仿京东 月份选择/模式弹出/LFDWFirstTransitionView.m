//
//  LFDWFirstTransitionView.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 2016/12/26.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "LFDWFirstTransitionView.h"
#import "LFDWSecondTransitionView.h"
#import "LFDWTransitionContainerViewController.h"
@implementation LFDWFirstTransitionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)btnClick:(id)sender {
//   self.transitionContainerVC pushView:<#(id)#>
    LFDWSecondTransitionView * fistView = [[NSBundle mainBundle]loadNibNamed:@"LFDWSecondTransitionView" owner:self options:nil][0];
    fistView.edgeInset = UIEdgeInsetsMake(300, 0, 0, 0);
    [(LFDWTransitionContainerViewController*)self.transitionContainerVC  pushView:fistView];
}

@end

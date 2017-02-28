//
//  LFDWTransitionContainerViewController.h
//  
//
//  Created by ouxuesen on 2016/12/26.
//
//

#import <UIKit/UIKit.h>
#import "LFDWTransitionView.h"

@interface LFDWTransitionContainerViewController : UIViewController
@property(nonatomic,strong) NSMutableArray * transitionViews;
//默认的第一个view 不可为空
@property(nonatomic,strong) LFDWTransitionView* defailtView;

-(void)pushView:(LFDWTransitionView*)pushView;
-(void)popViewAnimated:(BOOL)animated;
-(void)popToRootViewAnimated:(BOOL)animated;
@end

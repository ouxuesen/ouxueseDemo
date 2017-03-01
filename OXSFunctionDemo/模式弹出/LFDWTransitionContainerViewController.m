//
//  LFDWTransitionContainerViewController.m
//  
//
//  Created by ouxuesen on 2016/12/26.
//
//

#import "LFDWTransitionContainerViewController.h"

#define AnimatedTime  0.3
@interface LFDWTransitionContainerViewController ()

@end

@implementation LFDWTransitionContainerViewController

-(NSMutableArray *)transitionViews
{
    if (!_transitionViews) {
        _transitionViews = [NSMutableArray arrayWithCapacity:3];
    }
    return _transitionViews;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setDefailtView:(LFDWTransitionView *)defailtView
{
    if (_defailtView != defailtView) {
         _defailtView = defailtView;
        [self autoLayoutAddsubView:defailtView];
        if (![self.transitionViews containsObject:defailtView] ) {
            [self.transitionViews addObject:defailtView];
        }
    }
}
-(void)pushView:(LFDWTransitionView*)pushView
{
   
    if (self.transitionViews.count==0) {
       
        [self autoLayoutAddsubView:pushView];
    }else{
        [self transitonFromView:[self.transitionViews lastObject] toView:pushView];
    }
    if (![self.transitionViews containsObject:pushView] ) {
        [self.transitionViews addObject:pushView];
    }
//
}
-(void)transitonFromView:(LFDWTransitionView*)fromView toView:(LFDWTransitionView*)toView
{
    [self autoLayoutAddsubView:toView];
    if ([fromView respondsToSelector:@selector(viewWillDisappear)]) {
         [fromView viewWillDisappear];
    }
    if ([toView respondsToSelector:@selector(viewWillAppear)]) {
        [toView viewWillAppear];
    }
    fromView.leftConstraint.constant = 0;
    toView.leftConstraint.constant = WINDOW_WIDTH;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:AnimatedTime animations:^{
        toView.leftConstraint.constant = 0;
        fromView.leftConstraint.constant  = -WINDOW_WIDTH;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if ([fromView respondsToSelector:@selector(viewDidDisappear)]) {
            [fromView viewDidDisappear];
        }
        if ([toView respondsToSelector:@selector(viewDidAppear)]) {
            [toView viewDidAppear];
        }
    }];
}
-(void)popViewAnimated:(BOOL)animated
{
    if (self.transitionViews.count <2) {
        return;
    }
    NSInteger count = self.transitionViews.count;
    LFDWTransitionView * fromView = self.transitionViews[count-2];
    LFDWTransitionView * toView = self.transitionViews[count-1];
    if (animated) {
        [UIView animateWithDuration:AnimatedTime animations:^{
            fromView.leftConstraint.constant = 0;
            toView.leftConstraint.constant = WINDOW_WIDTH;
            [self.view layoutIfNeeded];

        } completion:^(BOOL finished) {
            [toView removeFromSuperview];
            [self.transitionViews removeObject:toView];
        }];
    }else{
        fromView.leftConstraint.constant = 0;
        toView.leftConstraint.constant = WINDOW_WIDTH;
        [self.view layoutIfNeeded];
        [toView removeFromSuperview];
        [self.transitionViews removeObject:toView];
    }
}
-(void)popToRootViewAnimated:(BOOL)animated
{
    if (self.transitionViews.count <2) {
        return;
    }
    NSInteger count = self.transitionViews.count;
    LFDWTransitionView * fromView = self.transitionViews[0];
    LFDWTransitionView * toView = self.transitionViews[count-1];
    if (animated) {
        [UIView animateWithDuration:AnimatedTime animations:^{
            fromView.leftConstraint.constant = 0;
            toView.leftConstraint.constant = WINDOW_WIDTH;
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            [self.transitionViews removeAllObjects];
            [self.transitionViews addObject:fromView];
            for (LFDWTransitionView*subview in self.transitionViews) {
                if (![subview isEqual:fromView]) {
                    [subview removeFromSuperview];
                }
            }
        
        }];
    }else{
        fromView.leftConstraint.constant = 0;
        toView.leftConstraint.constant = WINDOW_WIDTH;
        [self.view layoutIfNeeded];
        [self.transitionViews removeAllObjects];
        [self.transitionViews addObject:fromView];
        for (LFDWTransitionView*subview in self.transitionViews) {
            if (![subview isEqual:fromView]) {
                [subview removeFromSuperview];
            }
        }
    }
}
-(void)autoLayoutAddsubView:(LFDWTransitionView*)subView
{
    
    [self.view addSubview:subView];
    UIEdgeInsets edgeInsets = subView.edgeInset;
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    subView.heightConstraint = [NSLayoutConstraint constraintWithItem:subView attribute:  NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:edgeInsets.top];
    subView.leftConstraint  =[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:edgeInsets.left];
    subView.widthConstraint  =[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:edgeInsets.right>0?edgeInsets.right:WINDOW_WIDTH];
    subView.bottomConstraint = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:edgeInsets.bottom];
    [self.view addConstraint:subView.bottomConstraint];
    [self.view addConstraint:subView.leftConstraint];
    [self.view addConstraint:subView.widthConstraint];
    [self.view addConstraint:subView.heightConstraint];
}

@end

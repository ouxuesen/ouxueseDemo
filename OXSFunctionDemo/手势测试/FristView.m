//
//  FristView.m
//  OXSFunctionDemo
//
//  Created by 欧学森 on 2018/6/15.
//  Copyright © 2018年 ouxuesen. All rights reserved.
//

#import "FristView.h"

@implementation FristView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];

}
-(void)setResponseView:(UIView*)responseView
{
    _responseView =responseView;
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return  [super hitTest:point withEvent:event];
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return [super pointInside:point withEvent:event];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_responseView) {
        [_responseView touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (_responseView) {
        [_responseView touchesMoved:touches withEvent:event];
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    NSLog(@"%d -- %s",__LINE__,__func__);
    if (_responseView) {
        [_responseView touchesEnded:touches withEvent:event];
    }
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if (_responseView) {
        [_responseView touchesCancelled:touches withEvent:event];
    }
}
- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event {
    [super pressesBegan:presses withEvent:event];
    if (_responseView) {
        [_responseView pressesBegan:presses withEvent:event];
    }
}
- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0)
{
    [super pressesChanged:presses withEvent:event];
    if (_responseView) {
        [_responseView pressesChanged:presses withEvent:event];
    }
}
- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0)
{
    [super pressesEnded:presses withEvent:event];
    if (_responseView) {
        [_responseView pressesEnded:presses withEvent:event];
    }
}
- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0)
{
    [super pressesCancelled:presses withEvent:event];
    if (_responseView) {
        [_responseView pressesCancelled:presses withEvent:event];
    }
}
//
//
//- (BOOL)canPerformAction:(SEL)action withSender:(nullable id)sender NS_AVAILABLE_IOS(3_0);

//- (nullable id)targetForAction:(SEL)action withSender:(nullable id)sender
//{
//    [super targetForAction:action withSender:sender];
//    if (_responseView) {
//       return  [_responseView targetForAction:action withSender:sender];
//    }
//}
@end

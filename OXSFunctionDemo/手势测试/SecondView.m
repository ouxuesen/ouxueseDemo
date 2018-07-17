//
//  SecondView.m
//  OXSFunctionDemo
//
//  Created by 欧学森 on 2018/6/15.
//  Copyright © 2018年 ouxuesen. All rights reserved.
//

#import "SecondView.h"
#import "UIView+AutoLayout.h"
@implementation SecondView

-(void)awakeFromNib
{
    [super awakeFromNib];
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = [UIColor redColor];
//    [self addSubview:button];
//    [button autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
//    [button autoSetDimension:ALDimensionHeight toSize:40];
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)buttonClick:(UIButton*)button
{
    NSLog(@"buttonClick ");
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
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
      NSLog(@"%d -- %s",__LINE__,__func__);
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
}

@end

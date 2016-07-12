//
//  CAShapeLayer+Animation.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/3/31.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "CAShapeLayer+Animation.h"

@implementation CAShapeLayer (Animation)

- (void)addAnimationOneduration:(CFTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = duration;
    [self addAnimation:animation forKey:nil];
}

- (void)addAnimationTwoOnduration:(CFTimeInterval)duration
{
    //    layer.strokeStart = 0.5;
    //    layer.strokeEnd = 0.5;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation1.fromValue = @(0.5);
    animation1.toValue = @(0);
    animation1.duration = duration;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.fromValue = @(0.5);
    animation2.toValue = @(1);
    animation2.duration = duration;
    
    [self addAnimation:animation1 forKey:nil];
    [self addAnimation:animation2 forKey:nil];
}

- (void)addAnimationThreeOnduration:(CFTimeInterval)duration
{
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation1.fromValue = @(0);
    animation1.toValue = @(1);
    animation1.duration = duration;
    
    [self addAnimation:animation1 forKey:nil];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animation2.fromValue = @(1);
    animation2.toValue = @(8);
    animation2.duration = duration;
    
    [self addAnimation:animation1 forKey:nil];
    [self addAnimation:animation2 forKey:nil];
}


@end

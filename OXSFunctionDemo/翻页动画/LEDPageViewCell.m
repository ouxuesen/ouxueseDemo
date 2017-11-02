//
//  LEDPageViewCell.m
//  OXSFunctionDemo
//
//  Created by 欧学森 on 2017/10/24.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "LEDPageViewCell.h"

@interface LEDPageViewCell()
@property(nonatomic,strong)UIImageView* imageView;
@end

@implementation LEDPageViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView
{
    [self addSubview:self.imageView];
    //2.添加约束
    //2.1水平方向的约束
    NSString *hVFL = @"H:|-[imageView]-|";
    NSArray *hCons = [NSLayoutConstraint constraintsWithVisualFormat:hVFL options:0 metrics:nil views:@{@"imageView":self.imageView}];
    [self addConstraints:hCons];
    //2.2垂直方向的约束
    NSString *vVFL = @"V:|-[imageView]-|";
    NSArray *vCons = [NSLayoutConstraint constraintsWithVisualFormat:vVFL options:0 metrics:nil views:@{@"imageView":self.imageView}];
   [self addConstraints:vCons];
    self.imageView.image = [UIImage imageNamed:@"logo_shu_2"];
}
-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView  alloc]init];
      _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.backgroundColor = [UIColor blueColor];
    }
    return _imageView;
}
@end

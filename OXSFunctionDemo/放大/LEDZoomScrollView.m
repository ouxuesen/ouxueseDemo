//
//  LEDZoomScrollView.m
//  LEdulineliveTeacher
//
//  Created by 欧学森 on 2018/5/3.
//  Copyright © 2018年 ouxuesen. All rights reserved.
//

#import "LEDZoomScrollView.h"
//#import "UIImageView+YYWebImage.h"
@interface LEDZoomScrollView() <UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView*imageView;
@end
@implementation LEDZoomScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self resetScrollView];
        self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
}
- (instancetype)init
{
    self = [super init];
    if (self) {
         [self resetScrollView];
    }
    return self;
}
-(void)setMinZoomScale:(CGFloat)minScale maxZoomScale:(CGFloat)maxZoomScale
{
    self.minimumZoomScale = minScale;
    self.maximumZoomScale = maxZoomScale;
}
-(void)resetScrollView
{
    self.delegate = self;
    [self addSubview:self.imageView];
    self.bounces = NO;
    self.minimumZoomScale = 1.0;
     self.maximumZoomScale = 2.0;
}
-(void)setImageUrl:(NSString*)url
{
    
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
 {
    return self.imageView;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView

{
    
    NSLog(@"scrollView正在进行缩放");
 
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"logo_shu_2"];
    }
    return _imageView;
}
@end

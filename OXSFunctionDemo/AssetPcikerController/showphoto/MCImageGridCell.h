//
//  MCImageGridCell.h
//  MCFriends
//
//  Created by oxs on 14-6-19.
//  Copyright (c) 2014年 oxs. All rights reserved.
//


//#import "TorusIndicatorView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MCImageGridCell : UICollectionViewCell <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, strong) UIImageView *zoomImageView;

@property (nonatomic, strong) UIView *indicatorBgView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

//@property (nonatomic, strong) TorusIndicatorView *loadingView;

- (void)initWithAsset:(ALAsset *)asset index:(NSInteger)index;
- (void)initWithImage:(UIImage *)image index:(NSInteger)index;
//- (void)initWithMessage:(Message *)message index:(NSInteger)index;
//- (void)initWithImageArray:(NSArray *)imageArray index:(NSInteger)index;

- (void)doubleTapWithPoint:(CGPoint)point index:(NSInteger)index;

@end

//
//  MCImageGridCell.m
//  MCFriends
//
//  Created by oxs on 14-6-19.
//  Copyright (c) 2014年 oxs. All rights reserved.
//

#import "MCImageGridCell.h"

#define WINDOW_HEIGHT    [[UIScreen mainScreen] bounds].size.height
#define WINDOW_WIDTH     [[UIScreen mainScreen] bounds].size.width
@interface MCImageGridCell ()
{
    NSInteger myIndex;
    BOOL isLoading;
}
@end

@implementation MCImageGridCell


-(void)restView
{
    if (!_imageScrollView) {
        self.contentView.backgroundColor = [UIColor blackColor];
        self.clipsToBounds = true;
        
//        frame.origin.x = (frame.size.width-WINDOW_WIDTH)/2;
//        frame.origin.y = 0;
//        frame.size.width = WINDOW_WIDTH;
        
        _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)];
//        _imageScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageScrollView.maximumZoomScale = 2;
        _imageScrollView.backgroundColor = [UIColor clearColor];
        _imageScrollView.showsHorizontalScrollIndicator = false;
        _imageScrollView.showsVerticalScrollIndicator = false;
        _imageScrollView.delegate = self;
        
        _zoomImageView = [[UIImageView alloc] initWithFrame:_imageScrollView.bounds];
        [_imageScrollView addSubview:_zoomImageView];
        [self.contentView addSubview:_imageScrollView];
        
    }
}
#pragma mark - 双击手势触发
- (void)doubleTapWithPoint:(CGPoint)point index:(NSInteger)index
{
    if (myIndex != index || isLoading) {
        return;
    }
	if (_imageScrollView.zoomScale > 1) {
		[_imageScrollView setZoomScale:1 animated:YES];
	} else {
		[_imageScrollView zoomToRect:CGRectMake(point.x, point.y, 1, 1) animated:YES];
	}
}


- (void)initWithAsset:(ALAsset *)asset index:(NSInteger)index
{
    [self restView];
    myIndex = index;
    
    _imageScrollView.zoomScale = 1.0;
    CGSize scrollSize = _imageScrollView.frame.size;
    
    _zoomImageView.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    _zoomImageView.bounds = [self boundsOfImage:_zoomImageView.image forRect:_imageScrollView.bounds];
    _zoomImageView.center = CGPointMake(scrollSize.width/2, scrollSize.height/2);
    
    [self setMaximumZoomScale];
}

- (void)initWithImage:(UIImage *)image index:(NSInteger)index
{
    myIndex = index;
    
    _imageScrollView.zoomScale = 1.0;
    CGSize scrollSize = _imageScrollView.frame.size;
    
    _zoomImageView.image = image;
    _zoomImageView.bounds = [self boundsOfImage:image forRect:_imageScrollView.bounds];
    _zoomImageView.center = CGPointMake(scrollSize.width/2, scrollSize.height/2);
    
    [self setMaximumZoomScale];
}

//- (void)initWithImageArray:(NSArray *)imageArray index:(NSInteger)index
//{
//    myIndex = index;
//    
//    NSString *url = imageArray[index];
//    
//    CGSize scrollSize = _imageScrollView.frame.size;
//    
//    isLoading = false;
//    _indicatorBgView.hidden = true;
//    _imageScrollView.zoomScale = 1.0;
//    
//    
//    NSString *filePath = [UIImage diskCachePathWithURL:url];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        _zoomImageView.image = [UIImage imageWithContentsOfFile:filePath];
//        
//        _zoomImageView.bounds = [self boundsOfImage:_zoomImageView.image forRect:_imageScrollView.bounds];
//        _zoomImageView.center = CGPointMake(scrollSize.width/2, scrollSize.height/2);
//        
//        [self setMaximumZoomScale];
//        
//        return;
//    }
//    
//    isLoading = true;
//    //需要从网络加载时先加载缩略图
//    NSString *smallUrl = [NSString stringWithFormat:@"%@_150.jpg",[[url componentsSeparatedByString:@".jpg"] firstObject]];
//    filePath = [UIImage diskCachePathWithURL:smallUrl];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        _zoomImageView.image = [UIImage imageWithContentsOfFile:filePath];
//    }else{
//        _zoomImageView.image = [UIImage defaultImage];
//    }
//    
//    CGRect rect = CGRectZero;
//    rect.size = _zoomImageView.image.size;
//    _zoomImageView.bounds = rect;
//    _zoomImageView.center = CGPointMake(scrollSize.width/2, scrollSize.height/2);
//    
//    _loadingView.hidden = NO;
//    [_loadingView startAnimation];
//    [UIImage imageWithURL:url callback:^(UIImage *image) {
//        if (image && [image.lastCacheUrl isEqualToString:url]) {
//            _zoomImageView.image = image;
//            
//            [UIView animateWithDuration:.3 animations:^{
//                _zoomImageView.bounds = [self boundsOfImage:image forRect:_imageScrollView.bounds];
//                _zoomImageView.center = CGPointMake(scrollSize.width/2, scrollSize.height/2);
//            } completion:^(BOOL finished) {
//                [self setMaximumZoomScale];
//            }];
//            
//            isLoading = false;
//            _loadingView.hidden = YES;
//            [_loadingView stopAnimation];
//        }
//    }];
//}

//- (void)initWithMessage:(Message *)message index:(NSInteger)index
//{
//    myIndex = index;
//    
//    CGSize scrollSize = _imageScrollView.frame.size;
//    
//    isLoading = false;
//    _indicatorBgView.hidden = true;
//    _imageScrollView.zoomScale = 1.0;
//    
//    
//    if (message.image) {
//        _zoomImageView.image = message.image;
//        
//        _zoomImageView.bounds = [self boundsOfImage:_zoomImageView.image forRect:_imageScrollView.bounds];
//        _zoomImageView.center = CGPointMake(scrollSize.width/2, scrollSize.height/2);
//        
//       [self setMaximumZoomScale];
//        
//        return;
//    }
//    
//    isLoading = true;
//    
//    //需要从网络加载时先加载缩略图
//    _zoomImageView.image = message.thumbnail?:[UIImage defaultImage];
//    
//    CGRect rect = CGRectZero;
//    rect.size = _zoomImageView.image.size;
//    _zoomImageView.bounds = rect;
//    _zoomImageView.center = CGPointMake(scrollSize.width/2, scrollSize.height/2);
//    
//    _loadingView.hidden = NO;
//    [_loadingView startAnimation];
//    
//    [message fetchImageWithCompletion:^(UIImage *image) {
//        if (image && [image.lastCacheUrl isEqualToString:message.mediaUrl]) {
//            _zoomImageView.image = image;
//            
//            [UIView animateWithDuration:.3 animations:^{
//                _zoomImageView.bounds = [self boundsOfImage:image forRect:_imageScrollView.bounds];
//                _zoomImageView.center = CGPointMake(scrollSize.width/2, scrollSize.height/2);
//            }completion:^(BOOL finished) {
//                [self setMaximumZoomScale];
//            }];
//            
//            isLoading = false;
//            _loadingView.hidden = YES;
//            [_loadingView stopAnimation];
//        }
//    }];
//}


- (void)setMaximumZoomScale
{
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    float scale = _zoomImageView.image.size.width/(WINDOW_WIDTH*scale_screen);
    
    _imageScrollView.maximumZoomScale = MAX(scale, 2);
}

- (CGRect)boundsOfImage:(UIImage *)image forRect:(CGRect)rect
{
    CGSize imageSize = image.size;
    CGSize viewSize = rect.size;
    
    CGSize finalSize = CGSizeZero;
    
    if (imageSize.width / imageSize.height < viewSize.width / viewSize.height) {
        finalSize.height = viewSize.height;
        finalSize.width = viewSize.height / imageSize.height * imageSize.width;
    }
    else {
        finalSize.width = viewSize.width;
        finalSize.height = viewSize.width / imageSize.width * imageSize.height;
    }
    return CGRectMake(0, 0, finalSize.width, finalSize.height);
}

#pragma mark UIScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _zoomImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIImageView *zoomView = _zoomImageView;
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)? (scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)? (scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    zoomView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX, scrollView.contentSize.height/2 + offsetY);
}

@end

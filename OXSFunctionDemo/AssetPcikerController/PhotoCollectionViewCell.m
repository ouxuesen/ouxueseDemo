//
//  PhotoCollectionViewCell.m
//  相册
//
//  Created by oxs on 15/7/24.
//  Copyright (c) 2015年 ouxuesen. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

-(id)delegateCollectionView
{
    UICollectionView *collectionView = [self superCollectionView];
    if (collectionView) {
        return collectionView.delegate;
    }
    return nil;
}

-(UICollectionView*)superCollectionView
{
    id view = [self superview];
    
    while (view && ![view isKindOfClass:[UICollectionView class]]) {
        view = [view superview];
    }
    
    return (UICollectionView *)view;
    
}
- (void)blindAsset:(ALAsset*)asset indexPath:(NSIndexPath*)indexPathS
{
    _asset = asset;
    _indexPathS =indexPathS;
//    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
//    CGImageRef imgRef = [assetRep fullResolutionImage];
    self.backGroudImageView.image = [UIImage imageWithCGImage:asset.thumbnail];
}
- (IBAction)selectBtnClick:(UIButton*)sender {
   
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIViewController *parentVC = (UIViewController*)[self delegateCollectionView];
    SEL replyAction = @selector(btnSelected:);
    if ([parentVC respondsToSelector:replyAction]) {
        [parentVC performSelectorOnMainThread:replyAction withObject:_indexPathS waitUntilDone:true];
    }
//     sender.selected = !sender.selected;
#pragma clang diagnostic pop

}
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    self.backgroundColor = highlighted?[UIColor redColor]:[UIColor whiteColor];
}

@end

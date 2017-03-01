//
//  PhotoAlbumViewController.h
//  相册
//
//  Created by oxs on 15/7/24.
//  Copyright (c) 2015年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^photoAlbumCompleteBlock)(NSArray* assets);

@interface PhotoAlbumViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    photoAlbumCompleteBlock _seletCompleteBlock;
}
@property (nonatomic, assign)NSInteger maximumNumberOfSelection;

- (void)getSelectAssetsMaximumNumberOfSelection:(NSInteger)maximumNumberOfSelection CompleteBlock:(photoAlbumCompleteBlock)seletCompleteBlock;
@end

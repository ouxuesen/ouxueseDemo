//
//  ShowPhotosViewController.h
//  相册
//
//  Created by oxs on 15/7/24.
//  Copyright (c) 2015年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef void (^seletCompleteBlock)(NSArray* assets);
@interface ShowPhotosViewController : UIViewController

{
    seletCompleteBlock _seletCompleteBlock;
}
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

@property (nonatomic, assign)NSInteger maximumNumberOfSelection;
- (void)selectmaximumNumberOfSelection:(NSInteger)maximumNumberOfSelection assetsGroup:(ALAssetsGroup*)assetsGroup completeBlock:(seletCompleteBlock)seletCompleteBlock;

@property (weak, nonatomic) IBOutlet UICollectionView *photosCollection;
@end


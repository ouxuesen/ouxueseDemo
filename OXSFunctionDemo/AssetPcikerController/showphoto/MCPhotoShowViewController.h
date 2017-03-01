//
//  MCPhotoShowViewController.h
//  MCFriends
//
//  Created by oxs on 14-5-13.
//  Copyright (c) 2014年 oxs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MCGetImageAndVideoData.h"

@class MCGetImageAndVideoData;

typedef enum {
    kPHOTOSHOW_Preview =0,
    kPHOTOSHOW_ToView =1,
} kPHOTOSHOW_STATUS;

@protocol MCPhotoShowViewControllerDelegate <NSObject>

-(void)didFinishPickingAssets:(NSArray*)assets;

@end
@interface MCPhotoShowViewController : UIViewController  <UICollectionViewDelegate,UICollectionViewDataSource>
{
   
    __weak IBOutlet UICollectionView *colloctionView;
    
    UIButton *selectButton;
    
    //底栏
    __weak IBOutlet UIView *tabBar;
    __weak IBOutlet UILabel *countLabel;
    __weak IBOutlet UIButton *ensureButton;
}

@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic, assign) NSInteger currentIndex;

//发表动态可选择的图片数
@property (nonatomic, assign) NSInteger maximumNumberOfSelection;
@property (nonatomic, assign) kPHOTOSHOW_STATUS showType;

//@property (nonatomic, weak)   ZYQTapAssetView *zyasset;
@property (nonatomic, weak)   id <MCPhotoShowViewControllerDelegate> delegate;

@property (nonatomic, strong) MCGetImageAndVideoData *getData;

- (void)selectButtonAction:(UIButton *)sender;
- (IBAction)ensureButtonAction:(UIButton *)sender;

@end

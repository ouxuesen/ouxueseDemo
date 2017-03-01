//
//  MCPhotoShowViewController.m
//  MCFriends
//
//  Created by oxs on 14-5-13.
//  Copyright (c) 2014年 oxs. All rights reserved.
//

#import "MCPhotoShowViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MCImageGridCell.h"

#define WINDOW_HEIGHT    [[UIScreen mainScreen] bounds].size.height
#define WINDOW_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define ShortSystemVersion  [[UIDevice currentDevice].systemVersion floatValue]
#define IS_IOS_6 (ShortSystemVersion < 7)
#define BASE_TAG     1001
#define GAP          20.f    //UIScrollView 之间的空隙
static NSString * const reuseIdentifier = @"ControllerReuseIdentifier";
@interface MCPhotoShowViewController ()
{
    //所有元素的选中状态
    NSMutableArray *_allStuArr;

    //用于存储数据源
    NSMutableArray * tempDataSourceArray;
}

@end

@implementation MCPhotoShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"预览";
    
    selectButton = [[UIButton alloc] init];
    selectButton.frame = CGRectMake(0, 0, 48, 40);
    selectButton.contentEdgeInsets = UIEdgeInsetsMake(10, 24, 10, 4);
    [selectButton setImage:[UIImage imageNamed:@"image_picker_ensure_light.png"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"image_picker_ensure.png"] forState:UIControlStateSelected];
    [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:selectButton];
    self.navigationItem.rightBarButtonItem = item;
    _allStuArr = [[NSMutableArray alloc] init];
    _getData = [[MCGetImageAndVideoData alloc] init];
    
    
    ensureButton.layer.masksToBounds = true;
    ensureButton.layer.cornerRadius = 3;
    countLabel.layer.masksToBounds = true;
    countLabel.layer.cornerRadius = countLabel.bounds.size.height/2;
    countLabel.backgroundColor = [UIColor redColor];
    
    if (_selectedArray.count == 0) {
        countLabel.hidden = YES;
        ensureButton.selected = NO;
        ensureButton.userInteractionEnabled = NO;
    }else{
        ensureButton.selected = YES;
    }
    if (self.showType == kPHOTOSHOW_Preview) {
        tempDataSourceArray = _selectedArray;
        _allStuArr = [self getImageStatusArrayWithArray:_selectedArray];
    }else{
        tempDataSourceArray = [_dataSourceArray mutableCopy];
        _allStuArr = [self getImageStatusArrayWithArray:_dataSourceArray];
    }

    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delaysTouchesBegan = YES;
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    colloctionView.backgroundColor = [UIColor clearColor];
    colloctionView.directionalLockEnabled = YES;
    [colloctionView registerClass:[MCImageGridCell class] forCellWithReuseIdentifier:reuseIdentifier];
};

- (void)viewWillAppear:(BOOL)animated
{
    if (IS_IOS_6) {
//        self.navigationBar.translucent = YES;
        self.navigationController.navigationBar.translucent = YES;
    }
    
    [super viewWillAppear:animated];
    
    countLabel.text = [NSString stringWithFormat:@"%@", @(_selectedArray.count)];
    
    for (int i = 0; i <= _currentIndex; i++) {
        NSMutableDictionary *dictState = [_allStuArr objectAtIndex:i];
        if ([dictState[@"state"] integerValue] == 0) {
            selectButton.selected = NO;
        }else
        {
            selectButton.selected = YES;
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (IS_IOS_6) {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:UIStatusBarAnimationFade];  // 显示状态栏
    [super viewWillDisappear:animated];
}


- (NSMutableArray *)getImageStatusArrayWithArray:(NSArray *)array
{
    NSMutableArray *staArr = [[NSMutableArray alloc] init];
    for (ALAsset*image in array) {
        NSMutableDictionary*dict = [[NSMutableDictionary alloc]init];
        if ([_selectedArray containsObject:image]) {
            [dict setValue:image forKey:@"image"];
            [dict setValue: @"1" forKey:@"state"];
        }else
        {
            [dict setValue:image forKey:@"image"];
            [dict setValue: @"0" forKey:@"state"];
        }
        [staArr addObject:dict];
    }
    return staArr;
}


#pragma mark - 单双击手势触发
-(void)handleSingleTap:(UITapGestureRecognizer*)tap
{
    [self hideNavigationBarAndTabBar];
}
- (void)handleDoubleTap:(UITapGestureRecognizer *)tap
{
    CGPoint touchPoint = [tap locationInView:tap.view];
    
    NSArray *cellArray = colloctionView.visibleCells;
    for (MCImageGridCell *cell in cellArray) {
        [cell doubleTapWithPoint:touchPoint index:_currentIndex];
    }
}

- (void)hideNavigationBarAndTabBar
{
    tabBar.hidden = !tabBar.hidden;
    self.navigationController.navigationBar.hidden = !self.navigationController.navigationBar.hidden;
    [UIApplication sharedApplication].statusBarHidden = ![UIApplication sharedApplication].statusBarHidden;
}

- (void)selectButtonStatus
{
    if (_currentIndex < 0 || _currentIndex >= _allStuArr.count)  {
        if (_currentIndex < 0) {
            _currentIndex = 0;
        }
        if (_currentIndex >= _allStuArr.count) {
            _currentIndex = _allStuArr.count - 1 ;
        }
    }
    NSMutableDictionary *dictState = [_allStuArr objectAtIndex:_currentIndex];
    if (dictState && [dictState[@"state"] isEqualToString:@"1"]){
        selectButton.selected = YES;
    }else
    {
        selectButton.selected = NO;
    }
}

- (void)selectButtonAction:(UIButton *)sender
{
    if (_selectedArray.count == self.maximumNumberOfSelection) {
        if (!sender.selected) {
            [MCAlertView showWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"只能选取%@张照片",@(self.maximumNumberOfSelection)]];
            return;
        }
    }
    
    [self changePhotoStatus];
    sender.selected =! sender.selected;
    
    countLabel.text = [NSString stringWithFormat:@"%@", @(_selectedArray.count)];
    if (_selectedArray.count == 0) {
        countLabel.hidden = YES;
        ensureButton.selected = NO;
        ensureButton.userInteractionEnabled = NO;

    }else
    {
        countLabel.hidden = NO;
        ensureButton.selected = YES;
        ensureButton.userInteractionEnabled = YES;
    }

}

- (void)changePhotoStatus
{
    NSDictionary *dic = [_allStuArr objectAtIndex:_currentIndex];
    if (dic) {
        if ([_selectedArray containsObject:dic[@"image"]]) {
            [_selectedArray removeObject:dic[@"image"]];
        }
        if ([dic[@"state"] isEqualToString:@"1"]) {
            [dic setValue:@"0" forKeyPath:@"state"];
             [_allStuArr replaceObjectAtIndex:_currentIndex withObject:dic];
        }else
        {
            [dic setValue:@"1" forKeyPath:@"state"];
            [_allStuArr replaceObjectAtIndex:_currentIndex withObject:dic];
            [_selectedArray addObject:[dic objectForKey:@"image"]];
        }
    }
}

- (IBAction)ensureButtonAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishPickingAssets:)]) {
        [self.delegate didFinishPickingAssets:_selectedArray];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [tempDataSourceArray count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCImageGridCell *cell = (MCImageGridCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell initWithAsset:tempDataSourceArray[indexPath.row] index:indexPath.row];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WINDOW_WIDTH, WINDOW_HEIGHT);
}

#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger beforeIndex = _currentIndex;
    _currentIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (_currentIndex != beforeIndex) {
        [self selectButtonStatus];
//        self.title = [NSString stringWithFormat:@"%d / %d", _currentIndex+1, _dataSourceArray.count];
    }
}


- (void)dealloc
{
}

@end

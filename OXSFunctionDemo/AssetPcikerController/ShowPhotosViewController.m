//
//  ShowPhotosViewController.m
//  相册
//
//  Created by oxs on 15/7/24.
//  Copyright (c) 2015年 ouxuesen. All rights reserved.
//

#import "ShowPhotosViewController.h"
#import "PhotoCollectionViewCell.h"
#import "MCPhotoShowViewController.h"

@interface ShowPhotosViewController ()<MCPhotoShowViewControllerDelegate>
{
    //存去的是ALAsset对象
    NSMutableArray * selectedPhotoes;

}
@property (weak, nonatomic) IBOutlet UIButton *btnPreview;
@property (weak, nonatomic) IBOutlet UIButton *btnFinish;
- (IBAction)btnClick:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showLableWithConstraint;
@property (weak, nonatomic) IBOutlet UILabel *unLable;

@property (nonatomic, assign) NSInteger numberOfPhotos;
@property (nonatomic, assign) NSInteger numberOfVideos;
@property (nonatomic, strong) NSMutableArray* assets;
@end

@implementation ShowPhotosViewController
static NSString * CellIdentifier = @"PhotoCollectionViewCell";

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (selectedPhotoes) {
        [self changeBottomViewState];
        [self.photosCollection reloadData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.photosCollection registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    [self donePhotoesFromAlum];
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    [self.navigationItem setRightBarButtonItem:bbi];
    _unLable.layer.masksToBounds = true;
    _unLable.layer.cornerRadius = _unLable.bounds.size.height/2;

    selectedPhotoes = [NSMutableArray new];
    //调整固定间距
    CGFloat gaps = 10.0f;
    CGFloat cellWidth = 80.0f;
    CGSize sizeWindown = [UIScreen mainScreen].bounds.size;
    
    NSInteger row = floor((sizeWindown.width+gaps)/(gaps+cellWidth));
    CGFloat contentInset = sizeWindown.width - row*(gaps+cellWidth) +10;
    [self.photosCollection setContentInset:UIEdgeInsetsMake(0, contentInset/2, 49, contentInset/2)];
    
}
- (void)selectmaximumNumberOfSelection:(NSInteger)maximumNumberOfSelection assetsGroup:(ALAssetsGroup*)assetsGroup completeBlock:(seletCompleteBlock)seletCompleteBlock
{
    _maximumNumberOfSelection = maximumNumberOfSelection;
    _assetsGroup = assetsGroup;
    _seletCompleteBlock = seletCompleteBlock;
}
- (void)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)donePhotoesFromAlum
{
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    self.numberOfPhotos = 0;
    self.numberOfVideos = 0;
    
    if (!self.assets)
        self.assets = [[NSMutableArray alloc] init];
    else
        [self.assets removeAllObjects];
    
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        
        if (asset)
        {
            [self.assets addObject:asset];
            
            NSString *type = [asset valueForProperty:ALAssetPropertyType];
            
            if ([type isEqual:ALAssetTypePhoto])
                self.numberOfPhotos ++;
            if ([type isEqual:ALAssetTypeVideo])
                self.numberOfVideos ++;
        }
        
        else if (self.assets.count > 0)
        {
            [self.photosCollection reloadData];
            
        }
    };
    
    [self.assetsGroup enumerateAssetsUsingBlock:resultsBlock];
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.assets count];
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    [cell blindAsset:self.assets[indexPath.row] indexPath:indexPath];
    if ([selectedPhotoes containsObject:self.assets[indexPath.row]]) {
        cell.selctedBtn.selected = YES;
    }else{
        cell.selctedBtn.selected = NO;
    }
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}
//#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCPhotoShowViewController *showVC = [[MCPhotoShowViewController alloc] initWithNibName:@"MCPhotoShowViewController" bundle:nil];
    showVC.dataSourceArray = _assets;
    showVC.selectedArray = selectedPhotoes;
    showVC.currentIndex = indexPath.row;
    showVC.showType = kPHOTOSHOW_ToView;
    showVC.maximumNumberOfSelection = _maximumNumberOfSelection;
    showVC.delegate = self;
    [self.navigationController pushViewController:showVC animated:true];
    NSLog(@"预览");
}
//MCPhotoShowViewController-- 代理
-(void)didFinishPickingAssets:(NSArray *)assets
{
  //数据
    _seletCompleteBlock?_seletCompleteBlock(assets):nil;
    [self dismiss:nil];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (IBAction)btnClick:(UIButton*)sender {
    if (selectedPhotoes.count==0) {
        return;
    }
    if (sender.tag==1001) {
        MCPhotoShowViewController *showVC = [[MCPhotoShowViewController alloc] initWithNibName:@"MCPhotoShowViewController" bundle:nil];
        showVC.dataSourceArray = _assets;
        showVC.selectedArray = selectedPhotoes;
        showVC.showType = kPHOTOSHOW_Preview;
        showVC.maximumNumberOfSelection = _maximumNumberOfSelection;
        showVC.delegate = self;
        [self.navigationController pushViewController:showVC animated:true];
    }else if (sender.tag==1002)
    
    {
       _seletCompleteBlock?_seletCompleteBlock(selectedPhotoes):nil;
        [self dismiss:nil];
    }
    
}


- (void)btnSelected:(NSIndexPath*)indexPath
{
    NSLog(@"选中");
    PhotoCollectionViewCell * cell = (PhotoCollectionViewCell *)[self.photosCollection cellForItemAtIndexPath:indexPath];
    
    if (!cell.selctedBtn.selected) {
        if (![self cheackMax]) {
            return;
        }
    }
    cell.selctedBtn.selected = !cell.selctedBtn.selected;
    if ([selectedPhotoes containsObject:cell.asset]) {
        [selectedPhotoes removeObject:cell.asset];
    }else{
        [selectedPhotoes addObject:cell.asset];
    }
    [self changeBottomViewState];
}

-(void)changeBottomViewState
{
    if (selectedPhotoes.count == 0) {
        _unLable.hidden = YES;
        _btnPreview.selected = YES;
        _btnFinish.selected = YES;
    }else{
        _unLable.hidden = NO;
        _btnFinish.selected = NO;
        _btnPreview.selected = NO;
        _unLable.text = [NSString stringWithFormat:@"%@",@([selectedPhotoes count])];
    }
   
}
- (BOOL)cheackMax
{
    if ([selectedPhotoes count]>=_maximumNumberOfSelection) {
        [MCAlertView showWithMessage:[NSString stringWithFormat:@"最多选中%@张照片",@(_maximumNumberOfSelection)]];
        return NO;
    }
    
    return YES;
}
- (void)dealloc
{
    
    NSLog(@"释放了--%@", NSStringFromClass([self class]));
    
}
@end

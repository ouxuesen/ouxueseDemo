//
//  LFDMonthSelectViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/3/30.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "LFDMonthSelectViewController.h"
#import "MouthCollectionViewCell.h"
#define CellWidth [[UIScreen mainScreen]bounds].size.width/3
@interface LFDMonthSelectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger _currentIndex;
    BOOL firstload;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation LFDMonthSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.collectionView registerNib:[UINib nibWithNibName:@"MouthCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MouthCollectionViewCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, CellWidth, 0, CellWidth)];
    self.collectionView.decelerationRate = 0.1;
//        self.collectionView.pagingEnabled = YES;
//    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (!firstload) {
         [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        firstload = YES;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MouthCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MouthCollectionViewCell" forIndexPath:indexPath];
  
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([[UIScreen mainScreen]bounds].size.width/3, self.collectionView.frame.size.height);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//    if (indexPath.row>0) {
//          [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row -1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//    }else{
//        [self.collectionView scrollsToTop];
//    }
    if (indexPath.row == 1) {
         [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

-(void)setSelectIndex
{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = [[UIScreen mainScreen]bounds].size.width/3;
    NSInteger beforeIndex = _currentIndex;
    _currentIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 2;
    
    if (_currentIndex != beforeIndex&&_currentIndex<10&&_currentIndex>=0) {
        
        //       [self resetBtnBackGroudColorwithIndex:_currentIndex];
        //        isSelectbtn = YES;
        NSLog(@"划到%ld。行",_currentIndex);
        MouthCollectionViewCell *currentcell = (MouthCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0]];
        currentcell.heightLightCell =YES;
         MouthCollectionViewCell *beforecell = (MouthCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:beforeIndex inSection:0]];
          beforecell.heightLightCell =NO;
    }
//    CGPoint point= self.collectionView.center;
//    CGRect
    
}
@end

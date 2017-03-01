//
//  PhotoAlbumViewController.m
//  相册
//
//  Created by oxs on 15/7/24.
//  Copyright (c) 2015年 ouxuesen. All rights reserved.
//

#import "PhotoAlbumViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ShowPhotosViewController.h"

#define kThumbnailLength    78.0f
@interface PhotoAlbumViewController ()
{
    ALAssetsFilter* _assetsFilter;
    NSMutableArray * _gropsAlbum;
    ALAssetsLibrary * _assetsPhotoLibrary;
    ALAssetsLibrary * _assetsAllLibrary;
}
@property (weak, nonatomic) IBOutlet UITableView *ablumTableView;
@end

@implementation PhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"相簿";
    _assetsFilter = [ALAssetsFilter allPhotos];
    _gropsAlbum = [NSMutableArray new];
    _assetsPhotoLibrary = [ALAssetsLibrary new];
    _assetsPhotoLibrary = [ALAssetsLibrary new];
    [self donePhotoAlbumData];
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    [self.navigationItem setRightBarButtonItem:bbi];
    // Do any additional setup after loading the view from its nib.
}
- (void)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)getSelectAssetsMaximumNumberOfSelection:(NSInteger)maximumNumberOfSelection CompleteBlock:(photoAlbumCompleteBlock)seletCompleteBlock;
{
    _seletCompleteBlock = seletCompleteBlock;
    _maximumNumberOfSelection = maximumNumberOfSelection;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//拿相册的数据
- (void)donePhotoAlbumData
{
    ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group)
        {
            [group setAssetsFilter:_assetsFilter];
            if (group.numberOfAssets > 0)
            [_gropsAlbum addObject:group];
        }
        else
        {
            [_ablumTableView reloadData];
        }
    };
    
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
        
        
    };
    
    // Enumerate Camera roll first
    [_assetsPhotoLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                      usingBlock:resultsBlock
                                    failureBlock:failureBlock];
    
    // Then all other groups
    NSUInteger type =
    ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent |
    ALAssetsGroupFaces | ALAssetsGroupPhotoStream;
    
    [_assetsPhotoLibrary enumerateGroupsWithTypes:type
                                      usingBlock:resultsBlock
                                    failureBlock:failureBlock];
}

#pragma mark - Ttable View DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [_gropsAlbum count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kThumbnailLength +12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SettingTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
    }
    ALAssetsGroup *assetsGroup = _gropsAlbum[indexPath.row];
    CGImageRef posterImage      = assetsGroup.posterImage;
    size_t height               = CGImageGetHeight(posterImage);
    float scale                 = height / kThumbnailLength;
    cell.imageView.image        = [UIImage imageWithCGImage:posterImage scale:scale orientation:UIImageOrientationUp];
    cell.textLabel.text         = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    cell.detailTextLabel.text   = [NSString stringWithFormat:@"%ld", (long)[assetsGroup numberOfAssets]];
    cell.accessoryType          = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

//选中某行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowPhotosViewController * showPhotoVC = [[ShowPhotosViewController alloc]initWithNibName:@"ShowPhotosViewController" bundle:nil];
//    showPhotoVC.assetsGroup = _gropsAlbum[indexPath.row];
    __block photoAlbumCompleteBlock weekSeletBlock =  _seletCompleteBlock;
    [showPhotoVC selectmaximumNumberOfSelection:_maximumNumberOfSelection assetsGroup:_gropsAlbum[indexPath.row] completeBlock:^(NSArray *assets) {
        weekSeletBlock?weekSeletBlock(assets):nil;
    }];
    [self.navigationController pushViewController:showPhotoVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)dealloc
{
   
  NSLog(@"释放了--%@", NSStringFromClass([self class]));

}

@end

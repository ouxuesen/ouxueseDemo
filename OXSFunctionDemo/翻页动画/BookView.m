//
//  BookView.m
//  OXSFunctionDemo
//
//  Created by 欧学森 on 2017/10/23.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "BookView.h"
#import "BookCell.h"
#import "BookLayout.h"
@interface BookView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end


@implementation BookView
{
    NSMutableArray *_array;
    NSMutableArray *_arrayStr;
}

static NSString *const reuseIdentifier = @"cell";
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate =self;
        [self registerClass:[BookCell class] forCellWithReuseIdentifier:reuseIdentifier];
        self.showsHorizontalScrollIndicator = NO;
      
        _array = (NSMutableArray *)@[@"",@"12",@"12",@"12",@"12",@"12",@"12",@"12",@"12",@"12",@"12",@"12",@"12",@"12",@"12",@""];
        _arrayStr = (NSMutableArray *)@[@"",@"",@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天平座",@"天蝎座",@"射手座",@"魔蝎座",@"水瓶座",@"双鱼座",@"",@""];
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 160;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UIImage * iamge = [UIImage imageNamed:@"/Users/ouxuesen/ouxueseDemo/OXSFunctionDemo/wild_pig.jpg"];
    //indexPath.row%2?nil:
    cell.imageView.image = iamge;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [UIColor colorWithRed:148 / 255.0f green:0.0f blue:211 / 255.0f alpha:1.0f];
    return cell;
}
@end

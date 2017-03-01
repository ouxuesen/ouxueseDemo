//
//  MouthCollectionViewCell.h
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/3/30.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MouthCollectionViewCell : UICollectionViewCell
{
    __weak IBOutlet UILabel *topLable;
    
    __weak IBOutlet UILabel *bottom;
}
@property(nonatomic,assign)BOOL heightLightCell;

- (void)refeshtopLable:(NSString*)topStr bottomStr:(NSString*)bottomStr;

@end

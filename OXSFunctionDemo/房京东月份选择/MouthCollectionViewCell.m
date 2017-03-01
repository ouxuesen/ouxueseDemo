//
//  MouthCollectionViewCell.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/3/30.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "MouthCollectionViewCell.h"

@implementation MouthCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)refeshtopLable:(NSString*)topStr bottomStr:(NSString*)bottomStr
{
    
}
-(void)setHeightLightCell:(BOOL)heightLightCell
{
    UIFont *textFont = nil;
    UIColor * textColor = nil;
    if (heightLightCell) {
        textFont = [UIFont systemFontOfSize:18];
        textColor = [UIColor blueColor];
    }else{
        textFont = [UIFont systemFontOfSize:14];
        textColor = [UIColor blackColor];
    }
    topLable.textColor = textColor;
    bottom.textColor= textColor;
    topLable.font= textFont;
    bottom.font = textFont;
}

@end

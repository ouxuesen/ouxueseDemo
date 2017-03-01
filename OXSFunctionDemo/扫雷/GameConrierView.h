//
//  GameConrierView.h
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/6/3.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GameOver)(BOOL win);
@interface GameConrierView : UIView

@property(nonatomic,copy) GameOver gameOver;
-(void)cretaRowCount:(NSInteger)row lowCount:(NSInteger)low booNumeber:(NSInteger)bollNumber;
-(void)restsetGame;
@end

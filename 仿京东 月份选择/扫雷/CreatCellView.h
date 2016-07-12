//
//  CreatCellView.h
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/6/3.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,ShowCellState){
    ShowCellState_None = 0,
    ShowCellState_Number,
    ShowCellState_Bool,
};
typedef void(^TouchUp)(NSInteger tag);
@interface CreatCellView : UIView

@property(nonatomic,assign)ShowCellState stateRay;
@property(nonatomic,assign) BOOL flip;
@property(nonatomic,copy) TouchUp touchUp;
-(void)setNumberText:(NSString*)number state:(ShowCellState)state;
@end

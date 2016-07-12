//
//  LFDCoordinateView.h
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/3/30.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationType){
    AnimationTypeNone = 0,
    AnimationTypeOne,
    AnimationTypeTwo,
    AnimationTypeThree,
};
//cpont 坐标点 touchPint是触摸点的在当前view的位置
typedef void(^touchPoint)(CGPoint cpont,CGPoint touchPint);
typedef void(^touchPointCancale)();
@interface LFDCoordinateView : UIView
//** x轴数值数组 */
@property (nonatomic, strong) NSMutableArray * xLineValueArray;
/** x轴名字数组 */

/** y轴数值显示的上限 */
@property (nonatomic, assign) float yLineMaxValue;
/** y轴数值显示的段数 */
@property (nonatomic, assign) NSInteger yLineSectionCount;

@property(nonatomic,assign) AnimationType animationType;

@property (nonatomic,assign) NSInteger timeZeor;
#pragma -- 折线
@property(nonatomic,strong) NSArray* brokenPointsArray;

//#warning message - readonly(只读)

/** 获取坐标轴起点x值 */
@property (nonatomic, assign, readonly) CGFloat axisStartXPos;
/** 获取坐标轴起点Y值 */
@property (nonatomic, assign, readonly) CGFloat axisStartYPos;
/** 获取坐标轴间距 Y值 */
@property (nonatomic, assign, readonly) CGFloat YSegmentation;

/** 获取y轴最大上限值与0值的高度 */
@property (nonatomic, assign, readonly) CGFloat yLineMaxValueHeight;
/** 获取x轴坐标分割点的值*/
@property (nonatomic, strong, readonly) NSMutableArray* xLineDivisionValueArray;

#pragma mark - public method

/**
 *  重绘
 */
- (void)strokePath;

- (void)drawLayerBrokenLinePath;

-(void)touchPointBlock:(touchPoint)touchPoint cancaleBlock:(touchPointCancale)cancaleBlock;
@end

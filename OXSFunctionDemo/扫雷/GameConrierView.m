//
//  GameConrierView.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/6/3.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "GameConrierView.h"
#import "CreatCellView.h"

@interface GameConrierView ()
{
    NSMutableArray * mutableArray ;
    NSInteger _row;
    NSInteger _low;
    NSInteger _bollNumber;
    NSMutableArray * openArray;
}
@end
@implementation GameConrierView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}
-(void)cretaRowCount:(NSInteger)row lowCount:(NSInteger)low  booNumeber:(NSInteger)bollNumber
{
    if (!row||!low) {
        return;
    }
    self.backgroundColor = [UIColor lightGrayColor];
    _row = row;
    _low = low;
    _bollNumber = bollNumber;
    if (!mutableArray) {
        mutableArray = [NSMutableArray arrayWithCapacity:30];
    }else{
        [mutableArray removeAllObjects];
    }
    CGRect rect = self.frame;
    CGFloat gap = 0.5;
    CGFloat width = (rect.size.width + gap)/low - gap;
    CGFloat height = (rect.size.width + gap)/row - gap;
    for (int i = 0; i< row*low; i++) {
       
        CreatCellView *cellView = [[CreatCellView alloc]initWithFrame:CGRectMake(i%low*(gap + width), i/low*(gap+height), width, height)];
        cellView.tag = i+1;
        [self addSubview:cellView];
        [mutableArray addObject:cellView];
    }
    [self restsetGame];
}
-(void)restsetGame
{
       for (CreatCellView* cellView in mutableArray) {
           [cellView setNumberText:@"" state:ShowCellState_None];
       }
    [self distributionRay:_bollNumber];
    if (!openArray) {
        openArray = [NSMutableArray arrayWithCapacity:20];
    }else{
        [openArray removeAllObjects];
    }
    __weak GameConrierView * weekSelf = self;
    for (CreatCellView* cellView in mutableArray) {
        if (cellView.stateRay != ShowCellState_Bool) {
            NSInteger tempCount = [self computingAroundRay:cellView.tag showBlank:NO];
            if (tempCount) {
                [cellView setNumberText:@(tempCount).stringValue state:ShowCellState_Number];
            }else{
                [cellView setNumberText:@"" state:ShowCellState_None];
            }
        }
        cellView.flip = NO;
        cellView.touchUp = ^(NSInteger tag){
            [weekSelf seletViewTag:tag];
        };
    }
}
-(void)seletViewTag:(NSInteger)tag
{
    CreatCellView* cellViewTemp = (CreatCellView*)[self viewWithTag:tag];
    if (cellViewTemp.flip) {
        return;
    }
    if (cellViewTemp.stateRay == ShowCellState_Bool) {
        if (_gameOver) {
            _gameOver(NO);
        }
        for (CreatCellView* cellView in mutableArray) {
            if (cellView.stateRay == ShowCellState_Bool) {
                cellView.flip = YES;
            }
        }
        return;
    }else if (cellViewTemp.stateRay == ShowCellState_None){
        [self blackSHow:tag];
    }else{
        cellViewTemp.flip = YES;
    }
      NSInteger count = 0;
    for (CreatCellView* cellView in mutableArray) {
        if (!cellView.flip) {
            count ++;
        }
    }
    if (count == _bollNumber) {
        if (_gameOver) {
            _gameOver(YES);
        }
    }
}
-(void)blackSHow:(NSInteger)tag
{
    [self computingAroundRay:tag showBlank:YES];
}
-(void)distributionRay:(NSInteger)bollNumber
{
    NSMutableArray * tempArray = [mutableArray mutableCopy];
    for (int i = 0; i< bollNumber; i++) {
        NSInteger count = tempArray.count;
        if (count == 0) {
            return;
        }
        CreatCellView *cellView = tempArray[arc4random()%count];
        [cellView setNumberText:@"" state:ShowCellState_Bool];
        [tempArray removeObject:cellView];
    }
   
}
-(NSInteger)computingAroundRay:(NSInteger)tag showBlank:(BOOL)showBlank
{
    //一行的tag差值
    NSInteger tempCount = 0;
    if (tag - _low >0) {
        tempCount += [self computingLineRay:tag - _low showBlank:showBlank];
    }
    
    tempCount += [self computingLineRay:tag showBlank:showBlank];
   
    
    if (tag +_low <= _row*_low) {
        tempCount += [self computingLineRay:tag + _low showBlank:showBlank];
    }

    return tempCount;
}
-(NSInteger)computingLineRay:(NSInteger)tag showBlank:(BOOL)showBlank
{
    NSInteger temoCount = 0;
    CreatCellView *cellView = nil;
    if ((tag-1)%_low>0) {
        
        cellView = [self viewWithTag:(tag-1)];
        if (cellView.stateRay == ShowCellState_Bool) {
             temoCount ++;
        }else{
            if (showBlank) {
                
                if (cellView.stateRay == ShowCellState_None&&![openArray containsObject:cellView] ){
                    [openArray addObject:cellView];
                    [self blackSHow:cellView.tag];
                 
                }
                cellView.flip = YES;
            }
            
        }
    }
    
        cellView = [self viewWithTag:tag];
        if (cellView.stateRay == ShowCellState_Bool) {
            temoCount ++;
        }else{
            if (showBlank) {
                
                if (cellView.stateRay == ShowCellState_None&&![openArray containsObject:cellView] ){
                    [openArray addObject:cellView];
                    [self blackSHow:cellView.tag];
                    
                }
                cellView.flip = YES;
            }
        }
   
    
    if (((tag+1)<=_row*_low)&&(tag+1)%_low != 1) {
        cellView = [self viewWithTag:(tag+1)];
        if (cellView.stateRay == ShowCellState_Bool) {
            temoCount ++;
        }else{
            if (showBlank) {
                
                if (cellView.stateRay == ShowCellState_None&&![openArray containsObject:cellView] ){
                     [openArray addObject:cellView];
                    [self blackSHow:cellView.tag];
                   
                }
                cellView.flip = YES;
            }

        }
    }
    return temoCount;
}
@end

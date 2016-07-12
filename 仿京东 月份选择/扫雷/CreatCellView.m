//
//  CreatCellView.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/6/3.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "CreatCellView.h"

@interface CreatCellView ()
{
    UILabel * numberLabel;
}
@end
@implementation CreatCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadCellView:frame];
    }
    return self;
}

-(void)loadCellView:(CGRect)frame
{
    self.backgroundColor = [UIColor orangeColor];
    if (!numberLabel) {
        UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:control];
        control.backgroundColor = [UIColor clearColor];
        [control addTarget:self action:@selector(touchUpinset) forControlEvents:UIControlEventTouchUpInside];
        numberLabel = [[UILabel alloc]init];
        numberLabel.backgroundColor = [UIColor whiteColor];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        numberLabel.bounds = self.bounds;
//        numberLabel.hidden = YES;
        [self addSubview:numberLabel];
    }
}
-(void)touchUpinset
{
    if (_touchUp) {
        _touchUp(self.tag);
    }

}
-(void)setNumberText:(NSString*)number state:(ShowCellState)state
{
    _stateRay = state;
    switch (state) {
        case ShowCellState_None:
        {
            numberLabel.text = @"";
            numberLabel.hidden = YES;
        }
            break;
        case ShowCellState_Number:
        {
//            numberLabel.hidden = NO;
            numberLabel.text = number;
        }
            break;
        case ShowCellState_Bool:
        {
//            numberLabel.hidden = NO;
            numberLabel.text = @"*";
        }
            break;
        default:
            break;
    }
}
-(void)setFlip:(BOOL)flip
{
    _flip = flip;
    if (flip) {
       numberLabel.hidden = NO;
//        self.backgroundColor = [UIColor whiteColor];
    }else{
        numberLabel.hidden = YES;
    }
}
@end

//
//  LEDSelectColorView.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/6/15.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "LEDSelectColorView.h"

#define SelecCellHeight 54
#define SelecCellWidth 54

@interface LEDSelectColorView ()
{
    CGRect _blowViewRect;
    CGRect _tostViewRect;
}
@property (weak, nonatomic) IBOutlet UIImageView *backImagView;
@property (weak, nonatomic) IBOutlet UIView *continerView_1;
@property (weak, nonatomic) IBOutlet UIView *continerView_2;

@end

@implementation LEDSelectColorView

-(void)awakeFromNib
{
    [super awakeFromNib];
//     _backImagView.image = [[UIImage imageNamed:@"WechatIMG204"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 20, 10) resizingMode:UIImageResizingModeStretch];
    NSArray*color_1s = @[RGBCOLOR(232, 22, 22),RGBCOLOR(241, 125, 0),RGBCOLOR(252, 255, 0),RGBCOLOR(54, 198, 109),RGBCOLOR(0, 201, 219)];
    NSArray*color_2s = @[RGBCOLOR(6, 87, 220),RGBCOLOR(132, 6, 220),RGBCOLOR(232, 1, 88),RGBCOLOR(255, 255, 255),RGBCOLOR(0, 0, 0)];
    CGFloat leftgap = 19.5;
    CGFloat gaps = (self.frame.size.width - 5*SelecCellWidth -leftgap*2)/4;
    NSInteger count = 0;
    for (UIColor*color in color_1s) {
        UIButton*colorCellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        colorCellButton.frame = CGRectMake((gaps+SelecCellWidth)*count+leftgap-2, 5, SelecCellWidth+2, self.continerView_1.frame.size.height-10);
        
        colorCellButton.backgroundColor = color;
        [colorCellButton addTarget:self action:@selector(colorViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.continerView_1 addSubview:colorCellButton];

        count ++;
    }
     count = 0;
    for (UIColor*color in color_2s) {
        UIButton*colorCellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        colorCellButton.frame = CGRectMake((gaps+SelecCellWidth)*count+leftgap-2, 5, SelecCellWidth+2, self.continerView_2.frame.size.height-10);
        [self.continerView_2 addSubview:colorCellButton];
        colorCellButton.backgroundColor = color;
        [colorCellButton addTarget:self action:@selector(colorViewClick:) forControlEvents:UIControlEventTouchUpInside];
        count ++;
    }
}
-(void)colorViewClick:(UIButton*)btn
{
    _selectColor?_selectColor(btn.backgroundColor):nil;
    [self disMissView];
}
-(void)showViewWithSupview:(UIView*)supview blowView:(UIView*)blowView selectColor:(SelectColorBlock)selectColor
{
    [supview addSubview:self];
    CGRect rect_1= [blowView.superview convertRect:blowView.frame toView:supview];
    
    CGRect rect = self.frame;
    rect.origin.x = CGRectGetMidX(rect_1) - self.frame.size.width/2.0f;
    rect.origin.y = CGRectGetMinY(rect_1)- self.frame.size.height - 10;
    
    [self showViewBlowViewRect:rect_1 tostViewRect:rect];
    _selectColor = selectColor;
}

-(void)showViewBlowViewRect:(CGRect)blowViewRect tostViewRect:(CGRect)tostViewRect
{
    _blowViewRect = blowViewRect;
    _tostViewRect = tostViewRect;
    self.frame = CGRectMake(CGRectGetMidX(_blowViewRect), CGRectGetMinY(_blowViewRect), 0, 0);
    self.alpha = 0.3;
    [UIView animateWithDuration:0.25 animations:^{
       self.frame = _tostViewRect;
        self.alpha = 1;

    }];
}
-(void)disMissView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(CGRectGetMidX(_blowViewRect), CGRectGetMinY(_blowViewRect), 0, 0);
//         self.alpha = 0.3;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end

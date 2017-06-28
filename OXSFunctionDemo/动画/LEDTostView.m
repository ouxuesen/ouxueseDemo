//
//  LEDTostView.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/6/15.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "LEDTostView.h"

#define animationDuration   0.3
@interface LEDTostView ()
{
    BOOL lockedState;
}
@property (weak, nonatomic) IBOutlet UIImageView *backImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *tostLable;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end
@implementation LEDTostView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    lockedState = true;
    self.backgroundColor = [UIColor clearColor];
    [_backImageVIew setImage:[[UIImage imageNamed:@"bg_toast"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 125, 10, 12) resizingMode:UIImageResizingModeStretch] ];
}

-(void)showTosetMessage:(NSString*)message isError:(BOOL)isError
{
    [self setMessage:message];
    if (isError) {
        _iconImageView.image = [UIImage imageNamed:@"icon_cuo"];
    }else{
        _iconImageView.image = [UIImage imageNamed:@"icon_dui"];
    }
}
- (void)setMessage:(NSString *)message
{
    _tostLable.text = message;
    
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if(newSuperview){
        self.alpha = 0;
        [UIView animateWithDuration:animationDuration animations:^{
            self.alpha = 1;
        }completion:^(BOOL finsished){
            lockedState = false;
            [self performSelector:@selector(W_removeShortAlertView) withObject:nil afterDelay:1];
        }];
    }
}


- (void)W_removeShortAlertView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    lockedState = true;
    
    [UIView animateWithDuration:animationDuration animations:^{
        _messageView.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.6, 0.6, 1.0);
        _messageView.alpha = 0.1;
    }completion:^(BOOL finsished){
        [self removeFromSuperview];
    }];
}

-(void)dealloc
{
    NSLog(@"释放了——--%@",NSStringFromClass([self class]));
}
@end

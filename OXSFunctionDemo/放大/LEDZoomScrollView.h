//
//  LEDZoomScrollView.h
//  LEdulineliveTeacher
//
//  Created by 欧学森 on 2018/5/3.
//  Copyright © 2018年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LEDZoomScrollView : UIScrollView
-(void)setMinZoomScale:(CGFloat)minScale maxZoomScale:(CGFloat)maxZoomScale;
//-(void)zoomToRect:<#(CGRect)#> animated:<#(BOOL)#>
-(void)setImageUrl:(NSString*)url;
@end

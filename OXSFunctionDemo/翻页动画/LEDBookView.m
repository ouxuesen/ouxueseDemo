//
//  LEDBookView.m
//  OXSFunctionDemo
//
//  Created by 欧学森 on 2017/10/24.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "LEDBookView.h"
#import "LEDPageViewCell.h"

@interface LEDBookView()
@property(nonatomic,strong)NSMutableArray* dequeueViewPool;
@property(nonatomic,strong)NSMutableArray* currentSouceArray;
@property(nonatomic,strong)NSMutableArray * visualizationArray;
@property(nonatomic,assign)NSInteger currentPage;

@property(nonatomic,assign)CGPoint starPoint;
@end

@implementation LEDBookView

static CGFloat width = 100;
static CGFloat height = 60;

-(instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self) {
        [self reloadView];
        self.clipsToBounds = YES;
    }
    return self;
}
-(LEDPageViewCell*)creatPageView
{
    LEDPageViewCell*pageView = [[LEDPageViewCell alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    pageView.backgroundColor = [UIColor redColor];
    return pageView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
   _starPoint = [touch locationInView:self];
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    [self scrollPageViewWithTouchePoint:currentPoint];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    [self scrollEndPageViewWithTouchePoint:currentPoint];
}

-(void)scrollPageViewWithTouchePoint:(CGPoint)point
{
    CGFloat offset_x = point.x - _starPoint.x;
    if (offset_x<0) {
        [self animationScrollPageWithProportion:offset_x/(self.frame.size.width*0.7)];
    }
    
}

-(void)scrollEndPageViewWithTouchePoint:(CGPoint)point
{
     CGFloat offset_x = point.x - _starPoint.x;
    CGFloat proportion = offset_x/(self.frame.size.width*0.7);
    if (proportion<-0.5) {
        [UIView animateWithDuration:0.2 animations:^{
            [self animationScrollPageWithProportion:-1];
        }];
    }
}
-(void)animationScrollPageWithProportion:(CGFloat)proportion
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / - 2000;
    CGFloat angle = proportion*M_PI*0.5;
    NSLog(@"angle = %lf",angle);
    transform = CATransform3DRotate(transform, angle, 0, 1, 0);
    LEDPageViewCell* currentCell = [self currentPageViewCell];
     CALayer *layer = currentCell.layer;
    layer.anchorPoint = CGPointMake(0, 0.5);
    layer.transform = transform;
    currentCell.frame=CGRectMake(width*0.3,0,width,height);
}

-(NSMutableArray*)dequeueViewPool
{
    if (!_dequeueViewPool) {
        _dequeueViewPool = [NSMutableArray arrayWithCapacity:10];
    }
    return _dequeueViewPool;
}
-(NSMutableArray*)visualizationArray
{
    if (!_visualizationArray) {
        _visualizationArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _visualizationArray;
}


-(void)reloadView
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i<3; i++) {
        if (self.visualizationArray.count<3) {
            [self loadDequeueView];
        }else{
            break;
        }
    }
    CGFloat offset_x = width*0.3;
    for (LEDPageViewCell*cell in self.visualizationArray) {
        cell.frame = CGRectMake(offset_x, 0, width, height);
        [self addSubview:cell];
    }
}
-(LEDPageViewCell*)currentPageViewCell
{
    for (int i = 0; i<3; i++) {
        if (self.visualizationArray.count<3) {
            [self loadDequeueView];
        }else{
            break;
        }
    }
    return self.visualizationArray[1];
}
-(LEDPageViewCell*)beforePageViewCell
{
    for (int i = 0; i<3; i++) {
        if (self.visualizationArray.count<3) {
            [self loadDequeueView];
        }else{
            break;
        }
    }
    return self.visualizationArray[0];
}
-(LEDPageViewCell*)nextPageViewCell
{
    for (int i = 0; i<3; i++) {
        if (self.visualizationArray.count<3) {
            [self loadDequeueView];
        }else{
            break;
        }
    }
    return self.visualizationArray[2];
}
-(LEDPageViewCell*)loadDequeueView
{
    if (self.dequeueViewPool.count) {
        LEDPageViewCell* cell = [self.dequeueViewPool firstObject];
        [self.dequeueViewPool removeObject:cell];
        [self.visualizationArray addObject:cell];
        return cell;
    }else{
        LEDPageViewCell* cell = [self creatPageView];
         [self.visualizationArray addObject:cell];
        return cell;
    }
}

-(void)removeVisualizationCell:(LEDPageViewCell*)cell
{
     [self.visualizationArray removeObject:cell];
     [self.dequeueViewPool addObject:cell];
}

@end

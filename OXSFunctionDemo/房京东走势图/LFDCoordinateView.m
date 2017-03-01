//
//  LFDCoordinateView.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/3/30.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "LFDCoordinateView.h"
#import "CAShapeLayer+Animation.h"


#define YLableWithD 20 //y轴
#define xLableHight 10 //x
#define durationAnomation 0.5
@interface LFDCoordinateView ()
{
    CGSize viewSize ;
    //一个单位转换frame的值
    CGFloat x_cell;
    CGFloat y_cell;
    BOOL firstLoad;
    

    //画的折线的
    NSMutableArray * brokenLayerArray;
    NSMutableArray * touchLayerArray ;
    
    //touch
    CGPoint _beforePoint;
    touchPoint _touchBlock;
    touchPointCancale _touchPointCancale;
}

@end
@implementation LFDCoordinateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        viewSize = frame.size;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (!firstLoad) {
        [self getDataPoint];
        [self initPoint_x];
        [self initPoint_y];
        firstLoad = YES;
    }
}

-(void)initPoint_x
{

    NSInteger count = 0 ;
    for (NSNumber * x in _xLineValueArray) {
       
        [self.layer addSublayer:[self strokeLineWithPoint_x:CGPointMake([x floatValue], 0) ePoint:CGPointMake([x floatValue], _yLineMaxValue) strokeColor:[UIColor redColor]]];
        UILabel* xlable = [self creatLableX:CGPointMake([x floatValue], _axisStartYPos) text:[x stringValue]];
        [self addSubview:xlable];
        count ++;
    }
    
}
-(void)initPoint_y
{
    CGFloat xMaxVale = [[_xLineValueArray lastObject] floatValue];
    _YSegmentation = _yLineMaxValue /(_yLineSectionCount -1);
 
    for (int i = 0; i<_yLineSectionCount; i++) {
       
        [self.layer addSublayer:[self strokeLineWithPoint_x:CGPointMake(0, i*_YSegmentation) ePoint:CGPointMake(xMaxVale, i*_YSegmentation) strokeColor:[UIColor redColor]]];
        UILabel* ylable = [self creatLableY:CGPointMake(0 , i*_YSegmentation) text:[@(i*_YSegmentation) stringValue]];
        [self addSubview:ylable];
    }
}
//划线
-(CAShapeLayer*)strokeLineWithPoint_x:(CGPoint)sPoint ePoint:(CGPoint)ePoint strokeColor:(UIColor*)strokeColor
{
    CGPoint cSpoint = [self centerchangeFramePoint:sPoint];
    CGPoint cEpoint = [self centerchangeFramePoint:ePoint];
     CAShapeLayer *lineLayer = [CAShapeLayer layer];
     lineLayer.strokeColor = strokeColor.CGColor;
     UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:cSpoint];
    [linePath addLineToPoint:cEpoint];
     lineLayer.path =linePath.CGPath;
    lineLayer.lineWidth = 0.1;
     [self addAnimation:lineLayer duration:durationAnomation];
     return lineLayer;
}
//这个花坐标系用
-(CGPoint)centerchangeFramePoint:(CGPoint)fPoint
{
    
    NSInteger index = [_xLineValueArray indexOfObject:@(fPoint.x)];
    CGPoint  cpoint = CGPointMake(_axisStartXPos+index*x_cell, _axisStartYPos - fPoint.y*y_cell );
    return cpoint;
}
//坐标点 - frame的坐标点 转换  传入的是坐标点  转成实际的frame的点
-(CGPoint)changeFramePoint:(CGPoint)fPoint
{
    //算出在x轴的 位置 在第几个分隔中  按时间排序不一定是等分的。
    
    NSInteger index = -1 ;
    for (NSNumber *tiemMber in _xLineValueArray) {
        
        if (tiemMber.floatValue >fPoint.x) {
            break;
        }
        index ++;
    }
    //    NSInteger index = [_xLineValueArray indexOfObject:@(fPoint.x)];
    CGPoint  cpoint  = CGPointZero;
    if (index !=  [_xLineValueArray count] -1) {
       
        CGFloat gaps = [_xLineValueArray[index +1] floatValue];
        if (index > 0) {
            gaps =  [_xLineValueArray[index +1] floatValue] -[_xLineValueArray[index] floatValue];
        }
       
        CGFloat multiple = (fPoint.x -[_xLineValueArray[index] floatValue])/gaps;
        cpoint = CGPointMake(_axisStartXPos+index*x_cell+multiple*x_cell, _axisStartYPos - fPoint.y*y_cell );
    }else{
        cpoint = CGPointMake(viewSize.width -_axisStartXPos, _axisStartYPos - fPoint.y*y_cell );
    }
    
    return cpoint;
}

//显示刻度的lable
-(UILabel*)creatScaleLableWithLableFrame:(CGRect)rect text:(NSString*)text
{
    UILabel * titellable= [[UILabel alloc]initWithFrame:rect];
    titellable.text = text;
    titellable.textColor = [UIColor lightGrayColor];
    titellable.font = [UIFont systemFontOfSize:6];
    titellable.text = text;
    titellable.textAlignment = NSTextAlignmentCenter;
    return titellable;
}
//x轴lable 传入的是刻度值
-(UILabel*)creatLableX:(CGPoint)point text:(NSString*)text
{
    CGPoint  cpoint = [self centerchangeFramePoint:point];
    return [self creatScaleLableWithLableFrame:CGRectMake(cpoint.x-x_cell/2, _axisStartYPos, x_cell, xLableHight) text:text];
}
//y轴lable
-(UILabel*)creatLableY:(CGPoint)point text:(NSString*)text
{
    CGFloat rates = [text floatValue];
    CGPoint  cpoint = [self centerchangeFramePoint:point];
     return [self creatScaleLableWithLableFrame:CGRectMake(0, cpoint.y-xLableHight/2, YLableWithD, xLableHight) text:[NSString stringWithFormat:@"%.3f",rates]];
}
-(void)getDataPoint
{
     _axisStartXPos = YLableWithD;
    _axisStartYPos = viewSize.height - xLableHight;
    _yLineMaxValueHeight = viewSize.height - xLableHight;
    x_cell = (viewSize.width -_axisStartXPos*2)/([_xLineValueArray count] -1);
    y_cell = (_axisStartYPos-YLableWithD)/_yLineMaxValue;
//    _xLineDivisionValueArray = [NSMutableArray new];
//    for (int i = 1; i<[_xLineValueArray count]; i++) {
//        1
//    }
}
- (void)strokePath
{
    [self  clearDisplayView];
    [self initPoint_x];
    [self initPoint_y];
    
}
- (void)clearDisplayView
{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

//动画
- (void)addAnimation:(CAShapeLayer *)layer duration:(CFTimeInterval)duration
{
    switch (_animationType) {
        case AnimationTypeNone:
            break;
            
        case AnimationTypeOne:
            [layer addAnimationOneduration:duration];
            break;
            
        case AnimationTypeTwo:
            [layer addAnimationTwoOnduration:duration];
            break;
            
        case AnimationTypeThree:
            [layer addAnimationThreeOnduration:duration];
            break;
        default:
            break;
    }
}

#pragma --- 折现图绘制
-(void)drawLayerBrokenLinePath
{
    if (brokenLayerArray) {
        [brokenLayerArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
    UIBezierPath *brokenLinePath = [UIBezierPath bezierPath];
    NSInteger count = 0;
    for (NSString * pointStr in _brokenPointsArray) {
        CGPoint cpoint = CGPointFromString(pointStr);
        if (count == 0) {
            brokenLinePath = [UIBezierPath bezierPath];
            [brokenLinePath moveToPoint:[self changeFramePoint:cpoint]];
        }else{
            [self deawPointPath:brokenLinePath Point:cpoint];
        }
        count++;
    }
    UIBezierPath * shownPath = [UIBezierPath bezierPathWithCGPath:brokenLinePath.CGPath];
    CGPoint lastPoint = CGPointFromString([_brokenPointsArray lastObject]);
    [self deawPointPath:shownPath Point:CGPointMake(lastPoint.x, 0)];
    CGPoint fristPoint = CGPointFromString([_brokenPointsArray firstObject]);
     [self deawPointPath:shownPath Point:CGPointMake(fristPoint.x, 0)];
    [shownPath closePath];
    
    CAShapeLayer*brokenLayer = [CAShapeLayer layer];
    brokenLayer.path = shownPath.CGPath;
    brokenLayer.strokeColor = [ UIColor colorWithWhite:255 alpha:0.1].CGColor;
    brokenLayer.fillColor = [UIColor blueColor].CGColor;
    [self setLayer:brokenLayer delay:durationAnomation];

    CAShapeLayer*brokenLayer_1 = [CAShapeLayer layer];
    brokenLayer_1.path = brokenLinePath.CGPath;
    brokenLayer_1.strokeColor = [UIColor redColor].CGColor;
    brokenLayer_1.fillColor = [UIColor colorWithWhite:255 alpha:0.1].CGColor;
    [self addAnimation:brokenLayer_1 duration:durationAnomation];
     [self.layer addSublayer:brokenLayer_1];
    brokenLayerArray = [[NSMutableArray alloc] initWithCapacity:10];
    [brokenLayerArray addObject:brokenLayer];
    [brokenLayerArray addObject:brokenLayer_1];
}
- (void)setLayer:(CAShapeLayer *)layer delay:(CFTimeInterval)delay
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.layer addSublayer:layer];
    });
}


-(void)deawPointPath:(UIBezierPath*)bezierPath Point:(CGPoint)cPont
{
    NSLog(@"cPont = %@",NSStringFromCGPoint([self changeFramePoint:cPont]));
    [bezierPath addLineToPoint:[self changeFramePoint:cPont]];
    
}
//typedef <#returnType#>(^<#name#>)(<#arguments#>);
-(void)cheackTouchPoint:(CGPoint)fpont blockCheak:(void(^)(CGPoint cpoint))blockCheak
{
    NSInteger count = 0;
    CGFloat gaps = 100.0f;
    NSInteger index = 0;
    
    for (NSString * pointStr in _brokenPointsArray) {
        CGPoint cpoint = CGPointFromString(pointStr);
        CGPoint fApoint = [self changeFramePoint:cpoint];
        if (fabs(fpont.x - fApoint.x) <gaps ) {
            index = count;
            gaps = fabs(fpont.x - fApoint.x);
        }
        count ++;
    }
    blockCheak(CGPointFromString(_brokenPointsArray[index]));
}
-(void)touchPointBlock:(touchPoint)touchPoint cancaleBlock:(touchPointCancale)cancaleBlock
{
    _touchBlock = touchPoint;
    _touchPointCancale = cancaleBlock;

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    for (UITouch * touch in touches) {
        [self cheackTouchPoint:[touch locationInView:self] blockCheak:^(CGPoint cpoint) {
            NSLog(@"选中了当前的 touch = %@",NSStringFromCGPoint(cpoint));
            if (cpoint.x == _beforePoint.x &&cpoint.y == _beforePoint.y) {
                
            }else{
                [self drawLayerTouchLinePath:cpoint];
                _beforePoint = cpoint;
                 _touchBlock?_touchBlock(cpoint,[self changeFramePoint:cpoint]):nil;
            }
            
        }];
    }
   
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    for (UITouch * touch in touches) {
        [self cheackTouchPoint:[touch locationInView:self] blockCheak:^(CGPoint cpoint) {
//            NSLog(@"选中了当前的 touch = %@",NSStringFromCGPoint(cpoint));
            if (cpoint.x == _beforePoint.x &&cpoint.y == _beforePoint.y) {
                
            }else{
                [self drawLayerTouchLinePath:cpoint];
                _beforePoint = cpoint;
                _touchBlock?_touchBlock(cpoint,[self changeFramePoint:cpoint]):nil;
            }
           
        }];
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if (_touchPointCancale) {
        _touchPointCancale();
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (touchLayerArray) {
        [touchLayerArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
    if (_touchPointCancale) {
        _touchPointCancale();
    }
}

-(void)drawLayerTouchLinePath:(CGPoint)cpoint
{
    if (touchLayerArray) {
        [touchLayerArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
    CGFloat xMaxVale = [[_xLineValueArray lastObject] floatValue];
    
    CAShapeLayer * layerLintH = [self touchStrokeLineWithPoint_x:CGPointMake(0, cpoint.y) ePoint:CGPointMake(xMaxVale, cpoint.y) strokeColor:[UIColor orangeColor]];
     CAShapeLayer * layerLintV = [self touchStrokeLineWithPoint_x:CGPointMake(cpoint.x, 0) ePoint:CGPointMake(cpoint.x, _yLineMaxValue) strokeColor:[UIColor orangeColor]];
    CGPoint fpoint = [self changeFramePoint:cpoint];
    CGFloat height = 3.0f;
    UIBezierPath * circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(fpoint.x - height/2, fpoint.y - height/2, height, height)];
    CAShapeLayer * layerCircle = [CAShapeLayer layer];
    layerCircle.path = circlePath.CGPath;
    layerCircle.strokeColor = [UIColor redColor].CGColor;
    layerCircle.fillColor = [UIColor colorWithWhite:255 alpha:0.1].CGColor;
    
    [self.layer addSublayer:layerLintH];
    [self.layer addSublayer:layerLintV];
    [self.layer addSublayer:layerCircle];
    
    touchLayerArray = [NSMutableArray new];
    [touchLayerArray addObject:layerLintV];
    [touchLayerArray addObject:layerLintH];
    [touchLayerArray addObject:layerCircle];
}
//划线
-(CAShapeLayer*)touchStrokeLineWithPoint_x:(CGPoint)sPoint ePoint:(CGPoint)ePoint strokeColor:(UIColor*)strokeColor
{
    CGPoint cSpoint = [self changeFramePoint:sPoint];
    CGPoint cEpoint = [self changeFramePoint:ePoint];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = strokeColor.CGColor;
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:cSpoint];
    [linePath addLineToPoint:cEpoint];
    lineLayer.path =linePath.CGPath;
    lineLayer.lineWidth = 1;
    return lineLayer;
}
@end

//
//  GraphicsAnimationLable.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/7/3.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "GraphicsAnimationLable.h"
#import <CoreText/CoreText.h>

@interface GraphicsAnimationLable ()<CAAnimationDelegate>
@property(nonatomic,strong)CAShapeLayer *pathLayer;
@property(nonatomic,strong)CALayer *penLayer;
@end
@implementation GraphicsAnimationLable

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self creatAnimation];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     [self creatAnimation];
    }
    return self;
}
-(void)creatAnimation
{
    CGMutablePathRef letters = CGPathCreateMutable();   //创建path
    
    CTFontRef font = CTFontCreateWithName(CFSTR("Helvetica-Bold"), 60.0f, NULL);       //设置字体
    
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           nil ];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"我们都是好孩子" attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);   //创建line
    CFArrayRef runArray = CTLineGetGlyphRuns(line);     //根据line获得一个数组
    
    // 获得每一个 run
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        // 获得 run 的字体
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // 获得 run 的每一个形象字
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            // 获得形象字
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            //获得形象字信息
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            NSLog(@"position = %@",NSStringFromCGPoint(position));
            // 获得形象字外线的path
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                
                NSLog(@"letter = %@",letter);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
              
            }
        }
    }
    CFRelease(line);
    
    //根据构造出的 path 构造 bezier 对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(font);
    
    //根据 bezier 创建 shapeLayer对象
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.layer.bounds;
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor blackColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 3.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    [self.layer addSublayer:pathLayer];
    
    self.pathLayer = pathLayer;
    UIImage *penImage = [UIImage imageNamed:@"noun_project_347_2"];
    CALayer *penLayer = [CALayer layer];
    penLayer.contents = (id)penImage.CGImage;
    penLayer.anchorPoint = CGPointZero;
    penLayer.frame = CGRectMake(0.0f, 0.0f, penImage.size.width, penImage.size.height);
    [pathLayer addSublayer:penLayer];
//    penLayer.backgroundColor = [UIColor redColor].CGColor;
    self.penLayer = penLayer;
    self.penLayer.frame = self.layer.bounds;
    self.penLayer.hidden = YES;
}
- (void)startAnimation
{
    self.penLayer.hidden = NO;
    [self.pathLayer removeAllAnimations];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    CAKeyframeAnimation *penAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    penAnimation.duration = 10.0;
    penAnimation.path = self.pathLayer.path;
    penAnimation.calculationMode = kCAAnimationPaced;
    penAnimation.delegate = self;
    [self.penLayer addAnimation:penAnimation forKey:@"position"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.penLayer.hidden = YES;
}

-(CAAnimationGroup *)labelAppearAnimationForLabel:(UILabel *)label delay:(CGFloat)delay{
    
    CABasicAnimation *moveDownAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveDownAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(label.layer.position.x, label.layer.position.y-3)];
    moveDownAnimation.fromValue = [NSValue valueWithCGPoint:label.layer.position];
    moveDownAnimation.autoreverses = YES;
    moveDownAnimation.fillMode = kCAFillModeForwards;
    moveDownAnimation.duration = 0.5f;
    moveDownAnimation.beginTime = 0.0 + delay;
    moveDownAnimation.removedOnCompletion = NO;
    moveDownAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[moveDownAnimation];
    group.duration = 2 + 0.5;
    group.repeatCount = MAXFLOAT;
    group.removedOnCompletion = NO;
    group.autoreverses = NO;
    group.fillMode = kCAFillModeForwards;
    //    group.delegate = self;
    
    return group;
}
@end

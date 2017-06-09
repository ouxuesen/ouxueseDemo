//
//  CombinationAnimationViewController.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/6/7.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "CombinationAnimationViewController.h"
#import <CoreText/CoreText.h>

@interface WaterRippleLable ()
@property(nonatomic,strong)NSMutableArray *labelArray;
@property (assign, nonatomic) BOOL animating;
@end
@implementation WaterRippleLable

-(void)awakeFromNib
{
    [super awakeFromNib];
    NSArray *textArray = @[@"L", @"o", @"a", @"d", @"i", @"n", @"g",@".", @".", @"."];
    
    self.labelArray = [NSMutableArray arrayWithCapacity:10];
    
    //记录字符串的总长度，用以设定下一个 Label 的位置
    CGFloat totalWidth = 0.0;
    
    for (int i = 0; i < 10; i ++) {
        
        //获取字符宽度
        NSString *contentString = textArray[i]; //目标字符串
        CGRect rect = [contentString boundingRectWithSize:CGSizeMake(MAXFLOAT, 30.0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :self.font} context:nil] ;
        
        CGFloat charWidth = CGRectGetWidth(rect);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(totalWidth, 0, charWidth, 30)];
        label.text = textArray[i];
        label.font = self.font;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = self.textColor;
        label.layer.opacity = 1.0f;
        
        totalWidth += charWidth;
        
        [self.labelArray addObject:label];
        [self addSubview:label];
    }
    CGRect frame= self.frame;
    frame.size.width = totalWidth;
    self.frame = frame;
}

-(CAAnimationGroup *)labelAppearAnimationForLabel:(UILabel *)label delay:(CGFloat)delay{
    

    //2. 向下移动
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
- (void)startAnimate{
    
    if (self.animating) {
        return;
    }
    self.animating = YES;
    
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.alpha = 1.0f;
    }];
    

    for (int i = 0; i < 10; i ++) {
        UILabel *label = self.labelArray[i];
        CAAnimationGroup *group = [self labelAppearAnimationForLabel:label delay:i * 0.2];
        [group setValue:[NSString stringWithFormat:@"%d",i] forKey:@"name"];
        
        [label.layer addAnimation:group forKey:@"labelAppear"];
    }
}
/**
 *  结束动画
 */
- (void)stopAnimate{
    
    if (!self.animating) {
        return;
    }
    
    self.animating = NO;
    
    self.alpha = 1.0;
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
    
        for (int i = 0; i < 10; i ++) {
            UILabel *label = self.labelArray[i];
            [label.layer removeAllAnimations];
        }
        
        //        [self removeFromSuperview];
    }];
    
}
-(void)showAnimation
{
//    NSAttributedString * attrString = self.attributedText;
//    CGMutablePathRef path = CGPathCreateMutable(); //2
//    CGRect textFrame = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);
//    CGPathAddRect(path, NULL, textFrame);
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attrString);
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
//    
//    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame); //1
//    NSUInteger const lineCount = [lines count];
//    CGPoint origins[lineCount];
//    
//    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins); //2
//    CFRelease(frame);
//    CFRelease(path);
//    CFRelease(framesetter);
//    
//    for (CFIndex i = 0; i < lineCount; ++i) {
//        CTLineRef line = (__bridge CTLineRef) (lines[i]);
//        CGFloat ascent;
//        CGFloat descent;
//        CGFloat leading;
//        CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
//        CFArrayRef runs = CTLineGetGlyphRuns(line);
//        
//        for (CFIndex j = 0; j < CFArrayGetCount(runs); ++j) {
//            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
// 
//
//            
//           
//
//           
//        }
//    }

    

}
@end

@interface CombinationAnimationViewController ()
- (IBAction)buttonClick:(id)sender;
@property (weak, nonatomic) IBOutlet WaterRippleLable *showLablke;
@property (weak, nonatomic) IBOutlet UIImageView *lodingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *xingxing;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *continerView;
@property (weak, nonatomic) IBOutlet UIImageView *strImagIVew2;

@end

@implementation CombinationAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//按钮出现的时候有一个动画效果
- (void)buttonAnimation:(UIView *)lable
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.3f;
    
    [lable.layer addAnimation:animation forKey:@"DSPopUpAnimation"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)buttonClick:(UIButton*)sender {
    if (sender.tag == 0) {
        CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animate.byValue = @(M_PI*2);
        animate.duration = 1;
        animate.repeatCount = MAXFLOAT;
        [_lodingImageView.layer addAnimation:animate forKey:nil];
    }else if (sender.tag == 1){
        [_showLablke startAnimate];
        
    }else if (sender.tag == 2){
        [self anmiationWithView:_xingxing fromPosion:_xingxing.center toPosion:_button.center totolTime:2 delay:0 isRotation:YES];
         [self anmiationWithView:_xingxing fromPosion:_strImagIVew2.center toPosion:_button.center totolTime:2 delay:0 isRotation:YES];
        [CombinationAnimationViewController testView:_continerView ];
    }
}
-(void)anmiationWithView:(UIView*)anmiationView fromPosion:(CGPoint)fromPosion toPosion:(CGPoint)toPosion totolTime:(CGFloat)totolTime delay:(CGFloat)delay isRotation:(BOOL)isRotation
{
    CABasicAnimation *animation_1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation_1.toValue = [NSValue valueWithCGPoint:toPosion];
    animation_1.fromValue = [NSValue valueWithCGPoint:fromPosion];
//    animation_1.autoreverses = YES;
    animation_1.fillMode = kCAFillModeForwards;
    animation_1.duration = totolTime;
    animation_1.beginTime = 0;
    animation_1.removedOnCompletion = NO;
    animation_1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    CABasicAnimation *animation_2 = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation_2.toValue = [NSValue valueWithCGRect:anmiationView.layer.bounds];
    animation_2.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, anmiationView.layer.bounds.size.width/3,  anmiationView.layer.bounds.size.height/3)];
    //    animation_1.autoreverses = YES;
    animation_2.fillMode = kCAFillModeForwards;
    animation_2.duration = totolTime*5/8;
    animation_2.beginTime = 0.0 ;
    animation_2.removedOnCompletion = NO;
    animation_2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *animation_3 = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation_3.fromValue = [NSValue valueWithCGRect:anmiationView.layer.bounds];
    animation_3.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, anmiationView.layer.bounds.size.width/3,  anmiationView.layer.bounds.size.height/3)];
    //    animation_1.autoreverses = YES;
    animation_3.fillMode = kCAFillModeForwards;
    animation_3.duration = totolTime*5/8;
    animation_3.beginTime = totolTime*3/8 ;
    animation_3.removedOnCompletion = NO;
    animation_3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CABasicAnimation *animate_4 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animate_4.byValue = isRotation?@(M_PI*2):0;
    animate_4.duration = 1;
    animate_4.repeatCount = MAXFLOAT;
//    animate_4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation_1,animation_2,animation_3,animate_4];
    group.duration = totolTime;
    group.repeatCount = 1;
    group.beginTime = delay;
    group.removedOnCompletion = NO;
//    group.autoreverses = NO;
    group.fillMode = kCAFillModeForwards;
    //    group.delegate = self;
    [_xingxing.layer addAnimation:group forKey:@"xingxing"];

}

void startAnimate(CAEmitterLayer *emitterLayer)
{
    
    CABasicAnimation *starBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.star.birthRate"];
    starBurst.fromValue		= [NSNumber numberWithFloat:5];
    starBurst.toValue			= [NSNumber numberWithFloat:  0.0];
    starBurst.duration		= 0.5;
    starBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.repeatCount = 1;
    group.animations = @[starBurst];
    
    [emitterLayer addAnimation:group forKey:@"heartsBurst"];
}

+(void)testView:(UIView*)testView
{
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = testView.layer.bounds;
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    fireworksEmitter.emitterSize	= CGSizeMake(0, 0.0);
    fireworksEmitter.emitterMode	= kCAEmitterLayerOutline;
    fireworksEmitter.emitterShape	= kCAEmitterLayerLine;
    fireworksEmitter.renderMode		= kCAEmitterLayerAdditive;
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
//     fireworksEmitter.seed = (arc4random()%100)+1;
    //    rocket.birthRate		= 1.0;
    rocket.emissionRange	= 0.25 * M_PI;  // some variation in angle
    rocket.velocity			= 60;
    rocket.velocityRange	= 160;
    rocket.yAcceleration	= 70;
    rocket.lifetime			= 1.02;	// we cannot set the birthrate < 1.0 for the burst
    rocket.name = @"star";
    rocket.contents			= (id) [[UIImage imageNamed:@"d2_xingxing"] CGImage];
    rocket.scale			= 0.2;
    rocket.spinRange		= M_PI;		// slow spin
    rocket.spin = 2*M_PI;
    
    // putting it together
    fireworksEmitter.emitterCells	= [NSArray arrayWithObject:rocket];
    
    [testView.layer addSublayer:fireworksEmitter];
    startAnimate(fireworksEmitter);
}
@end

//
//  Gradient ViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/5/31.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "GradientViewController.h"
#import "CFGradientLabel.h"
#import "CAShapeLayer+Animation.h"
@implementation CicleView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAShapeLayer * shapLayer = [CAShapeLayer layer];
        frame.origin.x = 0;
        frame.origin.y = 0;
        UIBezierPath * path = [UIBezierPath bezierPathWithRect:frame];
        [shapLayer addAnimationTwoOnduration:2.0];
        shapLayer.path = path.CGPath;
        shapLayer.lineWidth = 2.1f;
        shapLayer.fillColor = [UIColor whiteColor].CGColor;
        shapLayer.strokeColor = [UIColor redColor].CGColor;
       
        CAGradientLayer * layerColor = [CAGradientLayer layer];
        layerColor.frame = CGRectMake(0, 0, frame.size.width+2, frame.size.height+2);
        layerColor.colors =
        [NSArray arrayWithObjects:(id)[[[UIColor blackColor] colorWithAlphaComponent:1] CGColor],
         (id)[[[UIColor yellowColor] colorWithAlphaComponent:1] CGColor],
         (id)[[[UIColor blueColor] colorWithAlphaComponent:1] CGColor],
         (id)[[UIColor clearColor] CGColor],
         nil];
        layerColor.locations =  [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
                                 [NSNumber numberWithFloat:0.3],
                                 [NSNumber numberWithFloat:0.8],
                                 [NSNumber numberWithFloat:1.0],
                                 nil];
        layerColor.startPoint = CGPointMake(0, 0);
        layerColor.endPoint = CGPointMake(1, 1);
        
        layerColor.mask = shapLayer;
//        layerColor.masksToBounds = NO;
         [self.layer addSublayer:layerColor];
        [ self addAnimationTwoOnduration:0.2 :layerColor];
        
    }
    return self;
}
- (void)addAnimationTwoOnduration:(CFTimeInterval)duration :(CALayer*)layer
{
    //    layer.strokeStart = 0.5;
    //    layer.strokeEnd = 0.5;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation1.fromValue = @(0.5);
    animation1.toValue = @(0);
    animation1.duration = duration;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.fromValue = @(0.5);
    animation2.toValue = @(1);
    animation2.duration = duration;
    
    [layer addAnimation:animation1 forKey:nil];
    [layer addAnimation:animation2 forKey:nil];
}
@end
@interface GradientViewController ()

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    CAGradientLayer * layerColor = [CAGradientLayer layer];
//    layerColor.frame = self.view.bounds;
//    layerColor.colors =
//    [NSArray arrayWithObjects:(id)[[[UIColor blackColor] colorWithAlphaComponent:1] CGColor],
//     (id)[[[UIColor yellowColor] colorWithAlphaComponent:1] CGColor],
//     (id)[[[UIColor blueColor] colorWithAlphaComponent:1] CGColor],
//     (id)[[UIColor clearColor] CGColor],
//     nil];
//    layerColor.locations =  [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
//                             [NSNumber numberWithFloat:0.3],
//                             [NSNumber numberWithFloat:0.8],
//                             [NSNumber numberWithFloat:1.0],
//                             nil];
//    layerColor.startPoint = CGPointMake(0.5, 0);
//    layerColor.endPoint = CGPointMake(0.5, 1);
//    [self.view.layer addSublayer:layerColor];
    
    CicleView *cicleVIew= [[CicleView alloc]initWithFrame:CGRectMake(100, 100, 70, 70)];
    [self.view addSubview:cicleVIew];
    
    NSArray *gradientColors = @[(id)[UIColor redColor].CGColor, (id)[UIColor greenColor].CGColor];
    // label
    [self addGradientLabelWithColors:gradientColors];
    
    // layer
    [self addGradientLayerWithColors:gradientColors];
   
//    UIBezierPath * path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(200, 100)];
//    [path addLineToPoint:CGPointMake(270, 100)];
//      UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(200, 100, 70, 70)];
//    CAShapeLayer * sharlayer = [CAShapeLayer layer];
//    sharlayer.path = path.CGPath;
//    sharlayer.fillColor = [UIColor redColor].CGColor;
////    sharlayer.lineWidth = 70;
//    [self.view.layer addSublayer:sharlayer];
////    [sharlayer addAnimationOneduration:3];
//    [self addAnimationTwoOnLayer:sharlayer duration:3 rectStar:CGRectZero rectEnd:CGRectZero];
    
    //
//    UIView * baleKview = [[UIView alloc]initWithFrame:CGRectMake(200, 100, 70, 70)];
//    [self.view.layer addSublayer:baleKview.layer];
//    baleKview.backgroundColor = [UIColor redColor];
//    [self addAnimationTwoOnLayer:baleKview.layer duration:3 rectStar:CGRectZero rectEnd:CGRectZero];
    

}
- (void)addAnimationTwoOnLayer:(CALayer *)layer duration:(CFTimeInterval)duration rectStar:(CGRect)rectStar rectEnd:(CGRect)rectEnd
{
//layer.bounds.size.width
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];//strokeStart ,strokeEnd
    animation.fromValue = @(200);
    animation.toValue =@(200);
    animation.duration = duration;
    [layer addAnimation:animation forKey:nil];
    CABasicAnimation *animation_1 = [CABasicAnimation animationWithKeyPath:@"bounds"];//strokeStart ,strokeEnd
    animation_1.fromValue = [NSValue valueWithCGRect:CGRectMake(200, 100, 0, 70)];
    animation_1.toValue =[NSValue valueWithCGRect:CGRectMake(200, 100, 70, 70)];
    animation_1.duration = duration;
    [layer addAnimation:animation_1 forKey:nil];
}
- (void)addGradientLabelWithColors:(NSArray *)colors
{
    CFGradientLabel* testLabel = [[CFGradientLabel alloc] init];
    testLabel.text = @"我是渐变色的呀呀呀呀--label";
    testLabel.font = [UIFont systemFontOfSize:23];
    [testLabel sizeToFit];
    testLabel.colors = colors;
    
    [self.view addSubview:testLabel];
    testLabel.center = CGPointMake(WINDOW_WIDTH * 0.5, self.view.bounds.size.height * 0.5);
}

- (void)addGradientLayerWithColors:(NSArray *)colors
{
    UILabel* testLabel = [[UILabel alloc] init];
    testLabel.text = @"我是渐变色的呀呀呀呀--layer";
    testLabel.font = [UIFont systemFontOfSize:23];
    [testLabel sizeToFit];
    
    [self.view addSubview:testLabel];
    testLabel.center = CGPointMake(WINDOW_WIDTH * 0.5, self.view.bounds.size.height * 0.7);
    
    // 创建渐变层
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = testLabel.frame;
    gradientLayer.colors = colors;
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [self.view.layer addSublayer:gradientLayer];
    
    gradientLayer.mask = testLabel.layer;
    testLabel.frame = gradientLayer.bounds;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

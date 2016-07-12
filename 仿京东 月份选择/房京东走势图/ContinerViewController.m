//
//  ContinerViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/4/7.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "ContinerViewController.h"
#import "LFDCoordinateView.h"
#import "LFDMonthSelectViewController.h"
@interface ContinerViewController ()
{
    LFDCoordinateView*coordinateView;
    UILabel * _showLable ;
}
@end

@implementation ContinerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Do any additional setup after loading the view, typically from a nib.
    
    if (_type ==type_continer) {
        [self loadCoordinateView];
    }else{
        [self loadDMonthSelectView];
    }
    
}
//京东月份]
-(void)loadDMonthSelectView
{
    LFDMonthSelectViewController * vc = [[LFDMonthSelectViewController alloc]initWithNibName:@"LFDMonthSelectViewController" bundle:nil];
//     vc.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
   [ vc.view setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin ];
}
//走势图
-(void)loadCoordinateView
{
    coordinateView = [[LFDCoordinateView alloc]initWithFrame:CGRectMake(10, 100, 300, 100)];
    coordinateView.xLineValueArray = [@[@0,@10,@20,@30,@40] mutableCopy];
    
    
    coordinateView.yLineSectionCount = 10;
    coordinateView.yLineMaxValue = 0.875;
    coordinateView.animationType = AnimationTypeOne;
    [self.view addSubview:coordinateView];
    _animationBtn.hidden = NO;
    _pointBtn.hidden = NO;
    __weak ContinerViewController *weekSelf = self;
    [coordinateView touchPointBlock:^(CGPoint cpont,CGPoint touchPoint) {
        NSLog(@"滑到了 当前的point = %@",NSStringFromCGPoint(cpont));
        [weekSelf showTopLabelWithPoint:touchPoint coordinates:cpont];
    }cancaleBlock:^{
        _showLable.hidden = YES;
    }];
}
-(void)showTopLabelWithPoint:(CGPoint)point  coordinates:(CGPoint)cpont
{
    if (!_showLable) {
        _showLable = [[UILabel alloc]init];
        _showLable.backgroundColor = [UIColor orangeColor];
        _showLable.clipsToBounds = YES;
        _showLable.bounds = CGRectMake(0, 0,40, 20);
        _showLable.numberOfLines = 2;
        _showLable.font = [UIFont systemFontOfSize:8];
        [self.view addSubview:_showLable];
    }
    CGPoint currentPiont = [coordinateView  convertPoint:point toView:self.view];
    _showLable.center = CGPointMake(currentPiont.x, 110);
    _showLable.text = [NSString stringWithFormat:@"x = %.2f\n y = %.2f",cpont.x,cpont.y];
    _showLable.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
- (IBAction)showAnimation:(UIButton*)sender {
    if (sender.tag == 0) {
        [coordinateView strokePath];
    }else{
        NSMutableArray * points = [NSMutableArray new];
        NSInteger count = 0 ;
        for (int i =0; i<20; i++) {
            CGPoint point = CGPointMake(arc4random()%40, (arc4random()%875)/1000.0);
            [points addObject:NSStringFromCGPoint(point)];
            count ++;
        }
        NSMutableArray * tempArray = [NSMutableArray new];
        [ points sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            CGPoint point1 = CGPointFromString(obj1);
            CGPoint point2 = CGPointFromString(obj2);
            if (point1.x == point2.x) {
                [tempArray addObject:obj2];
            }
            if (point1.x>point2.x) {
                return NSOrderedDescending;
            }else{
                return NSOrderedAscending;
            }
            
        }];
        [points removeObjectsInArray:tempArray];
        //        NSLog(@"points = %@", points);
        coordinateView.brokenPointsArray = points;
        [coordinateView drawLayerBrokenLinePath];
    }
    
}

@end

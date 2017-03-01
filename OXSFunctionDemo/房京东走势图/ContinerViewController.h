//
//  ContinerViewController.h
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/4/7.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,VCType) {
    type_continer,
    tupe_mouth,
};
@interface ContinerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *animationBtn;
@property (weak, nonatomic) IBOutlet UIButton *pointBtn;

@property (assign,nonatomic) VCType type;
- (IBAction)showAnimation:(UIButton*)sender;


@end

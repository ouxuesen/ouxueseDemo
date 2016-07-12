//
//  PresentSubViewController.h
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/6/6.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnClick)();
@interface PresentSubViewController : UIViewController

@property(nonatomic,copy) BtnClick btnClick;
@end

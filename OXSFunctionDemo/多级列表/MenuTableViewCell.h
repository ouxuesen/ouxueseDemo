//
//  MenuTableViewCell.h
//  OXSFunctionDemo
//
//  Created by ouxuesen on 21/03/2017.
//  Copyright © 2017 ouxuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"

typedef void(^ThirdCellClick)(NSIndexPath* indexPath,id data);
typedef void(^SecondCellClick)(NSIndexPath* indexPath,id data);
@interface MenuTableViewCell : UITableViewCell

@property(nonatomic,copy)ThirdCellClick thirdCellClick;
@property(nonatomic,copy)SecondCellClick secondCellClick;
-(void)updateWithcellSouce:(NSArray*)listSouce index:(NSIndexPath*)indexPath;

+(CGFloat)cellSouce:(NSArray*)listSouce;
+(CGFloat)menuCellHeight;
+(CGFloat)menuCellSectionHeight;

@end

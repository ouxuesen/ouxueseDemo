//
//  AutoLayoutCellHeightViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/5/24.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "AutoLayoutCellHeightViewController.h"
#import "AutoLayoutTableViewCell.h"

@interface AutoLayoutCellHeightViewController ()
{
    NSArray * souceArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AutoLayoutCellHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    souceArray = @[@"为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i",@"为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i",@"为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i",@"为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i",@"为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i",@"为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i为其日期七日而奇瑞奇瑞奇葩日排期认为群殴热欧文确认为群殴容器诶哦日七日i"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Ttable View DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoLayoutTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AutoLayoutTableViewCell" owner:self options:nil] firstObject];
        cell.contenrtLable.text = souceArray[indexPath.row];

    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"h=%f", size.height + 1);
    return 1  + size.height;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [souceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"AutoLayoutTableViewCell";
    
    AutoLayoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] firstObject];
    }
    cell.contenrtLable.text = souceArray[indexPath.row];
    
    return cell;
}

//选中某行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end

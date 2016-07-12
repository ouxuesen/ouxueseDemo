//
//  PictureHeardPullViewControll.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/5/27.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "PictureHeardPullViewControll.h"

@interface PictureHeardPullViewControll ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UIView *tableHeardView;
    __weak IBOutlet UIImageView *headBgImageView;
    __weak IBOutlet UITableView *tableViewS;
}

@end
@implementation PictureHeardPullViewControll

-(void)viewDidLoad

{
    [super viewDidLoad];
    [tableViewS setTableHeaderView:tableHeardView];
    [tableViewS reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* indentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.textLabel.text = @"我们都是好孩子";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (void)setContentOffset:(CGPoint)offset
{
    CGRect rect = headBgImageView.frame;
    rect.origin.y = 0;
    rect.size.height = 320;
    
    if (offset.y < 0) {
        rect.origin.y = offset.y;
        rect.size.height -= offset.y;
    }
    headBgImageView.frame = rect;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setContentOffset:scrollView.contentOffset];
}
@end

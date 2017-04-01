//
//  MenuTableViewCell.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 21/03/2017.
//  Copyright © 2017 ouxuesen. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "ThiredTableViewCell.h"

@interface MenuTableViewCell ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _listSouce;
    NSIndexPath * _secondIndePath;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
@implementation MenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_tableView registerNib:[UINib nibWithNibName:@"ThiredTableViewCell" bundle:nil] forCellReuseIdentifier:@"ThiredTableViewCell"];
}
-(void)updateWithcellSouce:(NSArray*)listSouce index:(NSIndexPath*)indexPath;
{
    _secondIndePath =indexPath;
    _listSouce = listSouce;
    [_tableView reloadData];
}
+(CGFloat)cellSouce:(NSArray *)listSouce
{
    CGFloat height = [self menuCellSectionHeight]*[listSouce count]; //sectioinView的高
    //cell列表
    for (MenuSecondModel * secondModel in listSouce) {
        if (secondModel.isopen) {
              height += [secondModel.secondListArray count]*[self menuCellHeight];
        }
    }
    return height;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_listSouce count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [MenuTableViewCell menuCellSectionHeight];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect rect = CGRectMake(0, 0, WINDOW_WIDTH, [MenuTableViewCell menuCellSectionHeight]);
    
    UIView * contentView = [[UIView alloc]initWithFrame:rect];
    contentView.backgroundColor = [UIColor brownColor];
    rect.origin.x = 15;
    UILabel * lable = [[UILabel alloc]initWithFrame:rect];
    lable.text = [self cellTopStrWithSection:section];
    lable.font = [UIFont systemFontOfSize:15];
    UIControl * control = [[UIControl alloc]initWithFrame:rect];
    [control addTarget:self action:@selector(secondClick:) forControlEvents:UIControlEventTouchUpInside];
    control.tag = section;
    [contentView addSubview:control];
    [contentView addSubview:lable];
    return contentView;
}
-(void)secondClick:(UIControl*)control
{
    MenuSecondModel * secondModel = _listSouce[control.tag];
    secondModel.isopen = !secondModel.isopen;
    _secondCellClick?_secondCellClick(_secondIndePath,secondModel):nil;
    UITableViewRowAnimation animation = UITableViewRowAnimationTop;
    if (secondModel.isopen) {
        animation = UITableViewRowAnimationBottom;
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:control.tag] withRowAnimation:animation];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return [self cellSouceWithSection:section].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *contenStr = [self cellSouceWithSection:indexPath.section][indexPath.row];
    ThiredTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThiredTableViewCell" forIndexPath:indexPath];
    cell.contentLable.text = contenStr;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MenuTableViewCell menuCellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuSecondModel * secondModel = _listSouce[indexPath.row];
    _thirdCellClick?_thirdCellClick(_secondIndePath,secondModel):nil;
}
-(NSArray *)cellSouceWithSection:(NSInteger)section
{
    MenuSecondModel * secondModel = _listSouce[section];
    if (secondModel.isopen) {
         return secondModel.secondListArray;
    }
    return nil;
    
}
-(NSString*)cellTopStrWithSection:(NSInteger)section
{
    MenuSecondModel * secondModel = _listSouce[section];
    return secondModel.secondConteStr;
}
+(CGFloat)menuCellHeight
{
    return 40;
}
+(CGFloat)menuCellSectionHeight
{
    return 40;
}
@end

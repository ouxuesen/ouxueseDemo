//
//  MenuListViewController.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 21/03/2017.
//  Copyright © 2017 ouxuesen. All rights reserved.
//

#import "MenuListViewController.h"
#import "MenuTableViewCell.h"
#import "MenuModel.h"

@interface MenuListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_testSouceArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_tableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenuTableViewCell"];
    [self testSouce];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSArray*)cellArrayWithSection:(NSInteger)section
{
    MenuModel * model = _testSouceArray[section];
    if (model.isopen) {
        return model.listArray;
    }
    return nil;
}
-(NSString*)cellTitleWithSection:(NSInteger)section
{
    MenuModel * model = _testSouceArray[section];
    return model.conteStr;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MenuTableViewCell cellSouce:[self cellArrayWithSection:indexPath.section]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
      return [MenuTableViewCell menuCellSectionHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_testSouceArray count];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, [MenuTableViewCell menuCellSectionHeight])];
    lable.userInteractionEnabled = YES;
    lable.backgroundColor = [UIColor redColor];
    lable.text = [self cellTitleWithSection:section];
    lable.font = [UIFont systemFontOfSize:15];
    UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH-15, [MenuTableViewCell menuCellSectionHeight])];
    [control addTarget:self action:@selector(firstClick:) forControlEvents:UIControlEventTouchUpInside];
    control.tag = section;
    [lable addSubview:control];
    return lable;
}
-(void)firstClick:(UIControl*)control
{
    MenuModel * model = _testSouceArray[control.tag];
    model.isopen = !model.isopen;
    UITableViewRowAnimation animation = UITableViewRowAnimationNone;
    if (model.isopen) {
        animation = UITableViewRowAnimationBottom;
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:control.tag] withRowAnimation:animation];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *cellArray = [self cellArrayWithSection:indexPath.section];
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath:indexPath];
    [cell updateWithcellSouce:cellArray index:indexPath];
    __weak MenuListViewController* weekSelf = self;
    cell.secondCellClick =^(NSIndexPath* indexPath,MenuSecondModel * secondModel){
        [weekSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    };
//    cell.thirdCellClick = ^(NSIndexPath* indexPath){
//        
//    };
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return 1;
}

-(void)testSouce
{
    _testSouceArray = [NSMutableArray new];
    for(int i= 0 ;i< 2;i++){
        MenuModel * menuModel = [[MenuModel alloc]init];
        menuModel.conteStr = [NSString stringWithFormat:@"第一级目录%d",i];
       
        for(int j= 0 ;j< 2;j++){
             NSString * secondStr = [NSString stringWithFormat:@"第二级目录%d",j];
            MenuSecondModel*secondModel = [[MenuSecondModel alloc]init];
            secondModel.secondConteStr = secondStr;
            for(int k= 0 ;k< 2;k++){
                NSString * thirdStr = [NSString stringWithFormat:@"第三级目录%d",k];
                [secondModel.secondListArray addObject:thirdStr];
            }
            [menuModel.listArray addObject:secondModel];
        }
        [_testSouceArray addObject:menuModel];
    }
    NSLog(@"_testSouceArray = %@",_testSouceArray);
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

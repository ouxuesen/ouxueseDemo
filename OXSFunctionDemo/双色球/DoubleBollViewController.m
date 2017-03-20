//
//  DoubleBollViewController.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 10/03/2017.
//  Copyright © 2017 ouxuesen. All rights reserved.
//

#import "DoubleBollViewController.h"

@interface DoubleBollViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _bollSRedArray;
    NSMutableArray * _bollSBlueeArray;
    NSMutableArray * _resutArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)buttonClcik:(id)sender;
@end

@implementation DoubleBollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.tableFooterView = [UIView new];
    self.title = @"双色球";
}
-(void)doubleBoll
{
    [self restBollStore];
    [self beaginScan];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_resutArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(void)restBollStore
{
    _bollSRedArray = [NSMutableArray new];
    for (int i=1; i<34; i++) {
        [_bollSRedArray addObject:@(i)];
    }
    _bollSBlueeArray = [NSMutableArray new];
    for (int i=1; i<17; i++) {
        [_bollSBlueeArray addObject:@(i)];
    }
}
-(void)beaginScan
{
    if (!_resutArray) {
        _resutArray = [NSMutableArray new];
    }
    NSMutableArray * restMutable = [NSMutableArray new];
    for (int i=0; i<6; i++) {
        NSNumber * tempNumber = _bollSRedArray[arc4random()%[_bollSRedArray count]];
        [_bollSRedArray removeObject:tempNumber];
        [restMutable addObject:[NSString stringWithFormat:@"%02ld",[tempNumber integerValue]]];
        
    }
    [restMutable sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2){
        return [obj1 integerValue]>[obj2 integerValue];
    }];
    NSNumber * tempBluee = _bollSBlueeArray[arc4random()%[_bollSBlueeArray count]];
     [_bollSBlueeArray removeObject:tempBluee];
    [restMutable addObject:[NSString stringWithFormat:@"%02ld",[tempBluee integerValue]]];
  
    [_resutArray addObject:restMutable];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_resutArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indeCell = @"bollCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indeCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indeCell];
        
    }
    NSArray * tempArray = _resutArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld次选择", indexPath.row+1];
    cell.detailTextLabel.text = [tempArray componentsJoinedByString:@" "] ;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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

- (IBAction)buttonClcik:(id)sender {
    [self doubleBoll];
}
@end

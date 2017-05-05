//
//  MenuViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/4/7.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "MenuViewController.h"
#import "ContinerViewController.h"


//#import TimeListViewController
@interface MenuViewController ()
{
    NSMutableArray * listArray;
}
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    listArray = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DemoName" ofType:@"plist"]];
    
}

#pragma mark - Ttable View DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary * dic = listArray[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    return cell;
}

//选中某行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = listArray[indexPath.row];
    NSString * nameClass = dic[@"vc"];
    Class class = NSClassFromString(nameClass);
    
    UIViewController * vc = [[class alloc]init];
    
    if ([vc isKindOfClass:[ContinerViewController class]]) {
        ((ContinerViewController*)vc).type = [dic[@"type"] integerValue];
    }
//    UIViewController * vc;
//    vc = [[UIViewController alloc]initWithNibName:<#(nullable NSString *)#> bundle:(nullable NSBundle *)]
//    if ([nameClass isEqualToString:@"ShowNavigationBarViewController"]) {
//        vc = [[ShowNavigationBarViewController alloc]initWithNibName:@"ShowNavigationBarViewController"bundle:nil];
//    }
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


@end

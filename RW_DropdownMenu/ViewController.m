//
//  ViewController.m
//  RW_DropdownMenu
//
//  Created by Ryan Wong on 15/9/14.
//  Copyright (c) 2015年 RyanWong. All rights reserved.
//

#import "ViewController.h"
#import "TestDropdownViewController.h"

#define SCREEN_RECT ([UIScreen mainScreen].bounds)

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    
    NSArray *_array;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"测试列表";
    _tableView = [[UITableView alloc] initWithFrame:SCREEN_RECT style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _array = @[@"下拉菜单"];
    [self.view addSubview:_tableView];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"testCell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testCell"];
            }
            [self removeCellView:cell];
            UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 44)];
            titleLab.text = [_array objectAtIndex:indexPath.row];
            [cell.contentView addSubview:titleLab];
            break;
        }
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TestDropdownViewController *dropDown = [[TestDropdownViewController alloc] initWithFrame:SCREEN_RECT];
        [self.navigationController pushViewController:dropDown animated:YES];
    }
}

- (void)removeCellView:(UITableViewCell*)cell {
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

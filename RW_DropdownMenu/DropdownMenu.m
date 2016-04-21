//
//  DropdownMenu.m
//  Common
//
//  Created by Ryan Wong on 15/9/9.
//  Copyright (c) 2015年 tenfoldtech. All rights reserved.
//

#import "DropdownMenu.h"
#import "CommonDefine.h"

@implementation DropdownMenu

- (id)initDropdownWithButtonTitles:(NSArray*)titles andLeftListArray:(NSArray*)leftArray andRightListArray:(NSArray *)rightArray {
    self = [super init];
    if (self) {
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 104);
        _button = [[DropdownButton alloc] initDropdownButtonWithTitles:titles];
        _button.delegate = self;
        _tableView = [[ConditionDoubleTableView alloc] initWithFrame:self.view.bounds andLeftItems:leftArray andRightItems:rightArray];
        _tableView.delegate = self;
        _titles = titles;
        _leftArray = leftArray;
        _rightArray = rightArray;
        [self.view addSubview:_tableView.view];
        [self.view addSubview:_button];
        [self initSelectedArray:titles];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reduceBackgroundSize) name:@"hideMenu" object:nil];
    }
    return self;
}

- (void)initSelectedArray:(NSArray *)titles {
    _buttonIndexArray = [[NSMutableArray alloc] initWithCapacity:titles.count];
}

//button点击代理
- (void)showMenu:(NSInteger)index {
    _lastIndex = index;
    [self.view setFrame:SCREEN_RECT];
    _buttonSelectedIndex = index - 10000;
    NSString *selected = @"0-0";
    if (_buttonIndexArray.count > _buttonSelectedIndex){
        selected = [_buttonIndexArray objectAtIndex:_buttonSelectedIndex];
    } else {
        [_buttonIndexArray addObject:selected];
    }
    NSArray *selectedArray = [selected componentsSeparatedByString:@"-"];
    NSString *left = [selectedArray objectAtIndex:0];
    NSString *right = [selectedArray objectAtIndex:1];
    [_tableView showTableView:_buttonSelectedIndex WithSelectedLeft:left Right:right];
}

- (void)hideMenu {
    [_tableView hideTableView];
}

- (void)reduceBackgroundSize {
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 104)];
}

- (void)selectedFirstValue:(NSString *)first SecondValue:(NSString *)second{
    NSString *index = [NSString stringWithFormat:@"%@-%@", first, second];
    [_buttonIndexArray setObject:index atIndexedSubscript:_buttonSelectedIndex];
    [self returnSelectedLeftIndex:first RightIndex:second];
}

- (void)returnSelectedLeftIndex:(NSString *)left RightIndex:(NSString *)right {
    
    NSString *buttonIndex = [NSString stringWithFormat:@"%ld",(long)_lastIndex - 10000];
    NSDictionary *dic = [self returnSelectedValueWithIndex:buttonIndex Left:left Right:right];
    NSString *title = [dic objectForKey:@"title"];
    NSString *leftValue = [dic objectForKey:@"left"];
    NSString *rightValue = [dic objectForKey:@"right"];
    if(rightValue.length>5){
        rightValue=[NSString stringWithFormat:@"%@...",[rightValue substringToIndex:4]];
    }
    [self changeButtonTitle:rightValue];
    //业务需要返回下标，删除可返回选中值
    title = buttonIndex;
    leftValue = left;
    rightValue = right;
    SEL aSelector = @selector(dropdownSelectedButtonIndex:LeftIndex:RightIndex:);
    if([_delegate respondsToSelector:aSelector]) {
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[[_delegate class] instanceMethodSignatureForSelector:aSelector]];
        [inv setSelector:aSelector];
        [inv setTarget:_delegate];
        [inv setArgument:&title atIndex:2]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
        [inv setArgument:&left atIndex:3]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
        [inv setArgument:&right atIndex:4];
        [inv invoke];
    }
}

- (NSDictionary *)returnSelectedValueWithIndex:(NSString *)index Left:(NSString *)left Right:(NSString *)right {
    NSString *title         = [_titles objectAtIndex:[index intValue]];
    NSArray *leftArray      = [_leftArray objectAtIndex:[index intValue]];
    NSString *leftValue     = @"null";
    if (leftArray.count > 0) {
        leftValue = [leftArray objectAtIndex:[left intValue]];
    }
    NSArray *rightArray     = [_rightArray objectAtIndex:[index intValue]];
    NSArray *rightValueArray= [rightArray objectAtIndex:[left intValue]];
    NSString *rightValue    = [[rightValueArray objectAtIndex:[right intValue]] valueForKey:@"title"];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:title, @"title", leftValue, @"left", rightValue, @"right", nil];
    return dic;
}

- (void)changeButtonTitle:(NSString *)menu{
    UIButton *button = (UIButton *)[_button viewWithTag:_lastIndex];
    [button setTitle:menu forState:UIControlStateNormal];
}

@end

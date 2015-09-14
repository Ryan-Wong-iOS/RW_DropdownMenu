//
//  DropdownMenu.h
//  Common
//
//  Created by Ryan Wong on 15/9/9.
//  Copyright (c) 2015年 tenfoldtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropdownButton.h"
#import "ConditionDoubleTableView.h"

@protocol dropdownDelegate <NSObject>

@optional
- (void)dropdownSelectedLeftIndex:(NSString *)left RightIndex:(NSString *)right;

@end

@interface DropdownMenu : UIViewController<showMenuDelegate, ConditionDoubleTableViewDelegate> {
    DropdownButton *_button;
    ConditionDoubleTableView *_tableView;
    NSInteger _lastIndex;
    
    NSInteger _buttonSelectedIndex;
    NSMutableArray *_buttonIndexArray;
    
    NSArray *_leftArray;
    NSArray *_rightArray;
}

@property (assign, nonatomic) id<dropdownDelegate>delegate;

- (id)initDropdownWithButtonTitles:(NSArray*)titles andLeftListArray:(NSArray*)leftArray andRightListArray:(NSArray *)rightArray;

@end

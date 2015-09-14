//
//  DropdownButton.h
//  Common
//
//  Created by Ryan Wong on 15/9/9.
//  Copyright (c) 2015年 tenfoldtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol showMenuDelegate <NSObject>

- (void)showMenu:(NSInteger)index;
- (void)hideMenu;

@end

@interface DropdownButton : UIView {
    NSInteger _count;
    NSInteger _lastTap;
    NSString *_lastTapObj;
    UIImage *_image;
    
    BOOL _isButtion;
}

@property (nonatomic, strong) UIImageView *buttonImageView;
@property (nonatomic, assign) id<showMenuDelegate> delegate;

- (id)initDropdownButtonWithTitles:(NSArray*)titles;

@end

//
//  SwipeTableViewCell.h
//  iOSProgrammer
//
//  Created by ZhuangXiaowei on 14-9-2.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SwipeTableViewCellRevealDirection) {
    SwipeTableViewCellRevealDirectionNone = -1, // disables panning
    SwipeTableViewCellRevealDirectionBoth = 0,
    SwipeTableViewCellRevealDirectionRight = 1,
    SwipeTableViewCellRevealDirectionLeft = 2,
};

typedef NS_ENUM(NSUInteger, SwipeTableViewCellStartOffset) {
    SwipeTableViewCellStartOffsetNone = -1,
    SwipeTableViewCellStartOffsetLeft = 0,
    SwipeTableViewCellStartOffsetRight = 1
};

@class SwipeTableViewCell;

@protocol SwipeTableViewCellDelegate

@optional
- (void)swipeTableViewCell:(SwipeTableViewCell *)cell shouldStartSwipeWithIndex:(NSIndexPath *)indexPath;

@end

@interface SwipeTableViewCell : UITableViewCell <
  UIGestureRecognizerDelegate
>

@property (nonatomic, weak) id<SwipeTableViewCellDelegate> delegate;
@property (nonatomic) NSInteger revealDirection;
@property (nonatomic) CGFloat hiddenElementWidth;
@property (nonatomic) NSInteger startOffset;
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) UIView *backView;

@end

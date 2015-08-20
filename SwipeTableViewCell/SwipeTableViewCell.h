//
//  SwipeTableViewCell.h
//  iOSProgrammer
//
//  Created by ZhuangXiaowei on 14-9-2.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SwipeTableViewCellDirection) {
    SwipeTableViewCellDirectionNone,                    ///不可滑动
    SwipeTableViewCellDirectionSingleLeft,              ///左边可滑动
    SwipeTableViewCellDirectionSingleRight,             ///右边可滑动,
    SwipeTableViewCellDirectionBoth                     ///两边都可滑动
};

@interface SwipeTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isSwiped;
@property (nonatomic, assign) CGFloat maxRightOffsetX;
@property (nonatomic, assign) CGFloat maxLeftOffsetX;
@property (nonatomic, strong) UIView *backgroundContainerView;
@property (nonatomic, assign) SwipeTableViewCellDirection direction;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier direction:(SwipeTableViewCellDirection)direction;

- (void)swipeOver;

@end

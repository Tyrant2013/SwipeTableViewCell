//
//  SwipeTableViewCell.m
//  iOSProgrammer
//
//  Created by ZhuangXiaowei on 14-9-2.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import "SwipeTableViewCell.h"

static NSTimeInterval animationDuration = 0.25f;

@interface SwipeTableViewCell()

@property (nonatomic, assign) CGPoint startLocation;

@end

@implementation SwipeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUIAndData];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUIAndData];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier direction:(SwipeTableViewCellDirection)direction {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUIAndData];
        _direction = direction;
    }
    return self;
}

- (void)initUIAndData {
    _direction = SwipeTableViewCellDirectionSingleRight;
    self.maxRightOffsetX = 100.0f;
    self.maxLeftOffsetX = 100.0f;
    [self addBackgroundContainerView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundContainerView.backgroundColor = [UIColor lightGrayColor];
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(panGestureRecogniser:)];
    [self.contentView addGestureRecognizer:panGestureRecognizer];
}

- (void)addBackgroundContainerView {
    UIView *containerView = [[UIView alloc] init];
    
    [self addSubview:containerView];
    [self sendSubviewToBack:containerView];
    self.backgroundContainerView = containerView;
    
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:containerView
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:containerView
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1
                                                              constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:containerView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1
                                                               constant:0];
    [self addConstraints:@[centerX, width, height]];
}

#pragma mark - swipe animation

- (void)panGestureRecogniser:(UIPanGestureRecognizer *)sender {
    if (self.direction == SwipeTableViewCellDirectionNone) {
        return;
    }
    CGPoint loc = [sender translationInView:sender.view];
    static CGFloat canNotMoveOffsetX = 10.0f;
    if (loc.x >= canNotMoveOffsetX
        && CGRectGetMinX(sender.view.frame) >= 0
        && self.direction == SwipeTableViewCellDirectionSingleRight) {
        CGPoint resetCenter = self.center;
        resetCenter.y = sender.view.center.y;
        [self resetPositionToView:sender.view offsetX:loc.x resetCenter:resetCenter];
        return;
    }
    else if (loc.x <= -canNotMoveOffsetX
             && CGRectGetMinX(sender.view.frame) <= 0
             && self.direction == SwipeTableViewCellDirectionSingleLeft) {
        return;
    }
    UIView *attachedView = sender.view;
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.startLocation = attachedView.center;
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            [self positionChangeToView:attachedView offsetX:loc.x];
            break;
        }
        default:
        {
            CGPoint resetCenter = self.center;
            resetCenter.y = attachedView.center.y;
            [self resetPositionToView:attachedView offsetX:loc.x resetCenter:resetCenter];
            break;
        }
    }
}

- (void)positionChangeToView:(UIView *)view offsetX:(CGFloat)offsetX{
    CGPoint newCenter = CGPointZero;
    CGFloat curPositionX = CGRectGetMinX(view.frame);
    newCenter.x = self.startLocation.x + offsetX;
    newCenter.y = self.startLocation.y;
    CGPoint center = self.center;
    
    CGFloat offsetCenterX = newCenter.x - center.x;
    BOOL canMove = NO;
    
    switch (self.direction) {
        case SwipeTableViewCellDirectionSingleLeft:
        {
            canMove = fabs(offsetCenterX) <= self.maxLeftOffsetX;
            canMove =  canMove && ((offsetX > 0 && curPositionX >= 0) || (offsetX < 0 && curPositionX > 0));
            break;
        }
        case SwipeTableViewCellDirectionSingleRight:
        {
            canMove = fabs(offsetCenterX) <= self.maxRightOffsetX;
            canMove = canMove && ((offsetX > 0 && curPositionX < 0) || (offsetX < 0 && curPositionX <= 0));
            break;
        }
        case SwipeTableViewCellDirectionBoth:
        {
            canMove = fabs(offsetCenterX) <= self.maxLeftOffsetX;
            canMove = canMove && fabs(offsetCenterX) <= self.maxRightOffsetX;
            break;
        }
        default:
            canMove = NO;
            break;
    }
    if (canMove) {
        view.center = newCenter;
    }
}

- (void)resetPositionToView:(UIView *)view offsetX:(CGFloat)offsetX resetCenter:(CGPoint)resetCenter {
    
    CGRect curFrame = view.frame;
    CGPoint curCenter = view.center;
    CGFloat curPositionX = CGRectGetMinX(curFrame);
    CGFloat offsetCenterX = fabs(curCenter.x - resetCenter.x);
    
    BOOL isNeedToResetPosition = NO;
    
    switch (self.direction) {
        case SwipeTableViewCellDirectionSingleLeft:
        {
            isNeedToResetPosition = (curPositionX < 0) || (offsetCenterX <= self.maxLeftOffsetX / 2);
            if (!isNeedToResetPosition) {
                curCenter.x = resetCenter.x + self.maxLeftOffsetX;
            }
            break;
        }
        case SwipeTableViewCellDirectionSingleRight:
        {
            isNeedToResetPosition = (curPositionX > 0) || (offsetCenterX <= self.maxRightOffsetX / 2);
            if (!isNeedToResetPosition) {
                curCenter.x = resetCenter.x - self.maxRightOffsetX;
            }
            break;
        }
        case SwipeTableViewCellDirectionBoth:
        {
            isNeedToResetPosition = (curPositionX > 0) && (offsetCenterX <= self.maxLeftOffsetX / 2);
            isNeedToResetPosition = isNeedToResetPosition || ((curPositionX < 0) && (offsetCenterX <= self.maxRightOffsetX / 2));
            if (!isNeedToResetPosition) {
                CGFloat offset = curPositionX > 0 ? self.maxLeftOffsetX : -self.maxRightOffsetX;
                curCenter.x = resetCenter.x + offset;
            }
            break;
        }
        default:
            break;
    }
    if (isNeedToResetPosition) {
        [self animateResetToOriginPosition:resetCenter view:view];
    }
    else {
        [self animateToDestinationPosition:curCenter view:view];
    }
}

- (void)animateResetToOriginPosition:(CGPoint)pos view:(UIView *)view {
    _isSwiped = NO;
    [UIView animateWithDuration:animationDuration
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         view.center = pos;
     }
                     completion:^(BOOL finished) {
                         [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
                     }];
    
    
}

- (void)animateToDestinationPosition:(CGPoint)pos view:(UIView *)view {
    _isSwiped = YES;
    
    [UIView animateWithDuration:animationDuration
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.8
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         view.center = pos;
     }
                     completion:^(BOOL finished) {
                         [self setSelectionStyle:UITableViewCellSelectionStyleNone];
                     }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)swipeOver {
    CGPoint center = self.center;
    center.y = self.contentView.center.y;
    [self animateResetToOriginPosition:center view:self.contentView];
}

@end

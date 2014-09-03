//
//  SwipeTableViewCell.m
//  iOSProgrammer
//
//  Created by ZhuangXiaowei on 14-9-2.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import "SwipeTableViewCell.h"

@interface SwipeTableViewCell()

@end

@implementation SwipeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initial];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initial];
    }
    return self;
}

- (void)initial
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    panGesture.delegate = self;
    [self addGestureRecognizer:panGesture];
    
    self.hiddenElementWidth = 80;
    self.startOffset = SwipeTableViewCellStartOffsetNone;
    self.revealDirection = SwipeTableViewCellRevealDirectionBoth;
    self.animationDuration = 0.1f;
    
    UIView *backView = [[UIView alloc] initWithFrame:self.frame];
    backView.backgroundColor = UIColor.whiteColor;
    [self addSubview:backView];
    [self sendSubviewToBack:backView];
    self.backView = backView;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
    if (self.startOffset == SwipeTableViewCellStartOffsetNone)
    {
        if ((translation.x < 0.0f && self.revealDirection == SwipeTableViewCellRevealDirectionLeft)
            || (translation.x > 0.0 && self.revealDirection == SwipeTableViewCellRevealDirectionRight)
            || self.revealDirection == SwipeTableViewCellRevealDirectionNone)
        {
            return;
        }
    }
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            [self startAnimateWithOffset:translation.x velocity:velocity];
            break;
        case UIGestureRecognizerStateChanged:
            [self changingAnimateWithOffset:translation.x velocity:velocity];
            break;
        case UIGestureRecognizerStateEnded:
            [self stopAnimateWithOffset:translation.x velocity:velocity];
            break;
        default:
            break;
    }
}

- (void)startAnimateWithOffset:(CGFloat)offset velocity:(CGPoint)velocity
{
    //    CGFloat startPox = CGRectGetMinX(self.frame);
    if ([((NSObject *)self.delegate) respondsToSelector:@selector(swipeTableViewCell:shouldStartSwipeWithIndex:)])
    {
        UITableView *tableView = (UITableView *)self.superview.superview;
        NSIndexPath *indexPath = nil;
        if (tableView)
            indexPath = [tableView indexPathForCell:self];
        [self.delegate swipeTableViewCell:self shouldStartSwipeWithIndex:indexPath];
    }
}

- (void)changingAnimateWithOffset:(CGFloat)offset velocity:(CGPoint)velocity
{
    if (self.startOffset == SwipeTableViewCellStartOffsetNone)
    {
        if (ABS(offset) > self.hiddenElementWidth) offset = 0;
        if (offset == 0.0) return;
        offset = offset - CGRectGetMinX(self.contentView.frame);
        self.contentView.frame = CGRectOffset(self.contentView.frame, offset, 0);
    }
    else
    {
        CGFloat x = CGRectGetMinX(self.contentView.frame);
        if ((x >= 0.0 && (self.revealDirection == SwipeTableViewCellRevealDirectionRight))
            || (x <= 0.0f && (self.revealDirection == SwipeTableViewCellRevealDirectionLeft)))
        {
            CGRect frame = self.contentView.frame;
            frame.origin.x = 0;
            self.contentView.frame = frame;
        }
        else
        {
            CGFloat maxMove = (self.startOffset == SwipeTableViewCellStartOffsetLeft ? -1 : 1) * self.hiddenElementWidth;
            offset = offset - x + maxMove;
            
            self.contentView.frame = CGRectOffset(self.contentView.frame, offset, 0);
        }
    }
}

- (void)stopAnimateWithOffset:(CGFloat)offset velocity:(CGPoint)velocity
{
    CGRect frame = self.contentView.frame;
    if (ABS(CGRectGetMinX(frame)) < (self.hiddenElementWidth / 2))
    {
        frame.origin.x = 0;
    }
    else
    {
        CGFloat whichOne = self.startOffset == SwipeTableViewCellStartOffsetNone ? offset : CGRectGetMinX(frame);
        frame.origin.x = (whichOne > 0.0f ? 1 : -1) * self.hiddenElementWidth;
    }
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        [self configCurrentOffset];
    }];
}

- (void)configCurrentOffset
{
    CGFloat startPos = CGRectGetMinX(self.contentView.frame);
    if (startPos < 0.0)
    {
        self.startOffset = SwipeTableViewCellStartOffsetLeft;
    }
    else if (startPos > 0.0)
    {
        self.startOffset = SwipeTableViewCellStartOffsetRight;
    }
    else
    {
        self.startOffset = SwipeTableViewCellStartOffsetNone;
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (self.startOffset != SwipeTableViewCellStartOffsetNone)
        self.highlighted = NO;
    // Configure the view for the selected state
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.contentView.frame = (CGRect){0, CGRectGetMinY(self.contentView.frame),self.contentView.frame.size};
    } completion:^(BOOL finished) {
        self.startOffset = SwipeTableViewCellStartOffsetNone;
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end

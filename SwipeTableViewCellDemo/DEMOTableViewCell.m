//
//  DEMOTableViewCell.m
//  SwipeTableViewCellDemo
//
//  Created by 庄晓伟 on 15/8/19.
//  Copyright (c) 2015年 Tyrant. All rights reserved.
//

#import "DEMOTableViewCell.h"

@implementation DEMOTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier direction:SwipeTableViewCellDirectionSingleRight];
    if (self) {
        [self appendSubViews];
    }
    return self;
}

- (void)appendSubViews {
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:14.0f];
    title.textColor = [UIColor blackColor];
    [self.foregroundContainerView addSubview:title];
    self.title = title;
    
    UILabel *detail = [[UILabel alloc] init];
    detail.font = [UIFont systemFontOfSize:14.0f];
    detail.textColor = [UIColor blackColor];
    [self.foregroundContainerView addSubview:detail];
    self.detail = detail;
    
    NSLayoutConstraint *titleTop = [NSLayoutConstraint constraintWithItem:title
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.foregroundContainerView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:0];
    NSLayoutConstraint *titleBottom = [NSLayoutConstraint constraintWithItem:title
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.foregroundContainerView
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:0];
    NSLayoutConstraint *titleLeft = [NSLayoutConstraint constraintWithItem:title
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.foregroundContainerView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:0];
    NSLayoutConstraint *titleWidth = [NSLayoutConstraint constraintWithItem:title
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.foregroundContainerView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:0.5f
                                                                   constant:0];
    
    
    NSLayoutConstraint *detailTop = [NSLayoutConstraint constraintWithItem:detail
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.foregroundContainerView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1
                                                                  constant:0];
    NSLayoutConstraint *detailBottom = [NSLayoutConstraint constraintWithItem:detail
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.foregroundContainerView
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1
                                                                     constant:0];
    NSLayoutConstraint *detailRight = [NSLayoutConstraint constraintWithItem:detail
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.foregroundContainerView
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1
                                                                    constant:0];
    NSLayoutConstraint *detailWidth = [NSLayoutConstraint constraintWithItem:detail
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.foregroundContainerView
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:0.5f
                                                                    constant:0];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    detail.translatesAutoresizingMaskIntoConstraints = NO;
    [self.foregroundContainerView addConstraints:@[titleTop, titleBottom, titleLeft, titleWidth]];
    [self.foregroundContainerView addConstraints:@[detailTop, detailBottom, detailRight, detailWidth]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

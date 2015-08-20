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
        UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){240, 0, 80, 30}];
        [button setBackgroundColor:[UIColor redColor]];
        [button setTitle:@"Delete" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundContainerView addSubview:button];
    }
    return self;
}

- (void)buttonSelected:(UIButton *)sender {
    NSLog(@"buttonSelected");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

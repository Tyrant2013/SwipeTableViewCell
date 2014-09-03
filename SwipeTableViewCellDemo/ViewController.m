//
//  ViewController.m
//  SwipeTableViewCellDemo
//
//  Created by ZhuangXiaowei on 14-9-3.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import "ViewController.h"
#import "SwipeTableViewCell.h"

@interface ViewController ()<
  UITableViewDataSource,
  UITableViewDelegate,
  SwipeTableViewCellDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *array;
@property (nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _array = [@[
                @"This is something !",
                @"Oh no!That is not my option!",
                @"So!What do you want?",
                @"Yes? Anything can i help you?",
                @"Bye!Bye!"
               ] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.array[indexPath.row];
    cell.hiddenElementWidth = 80;
    cell.delegate = self;
    cell.revealDirection = SwipeTableViewCellRevealDirectionRight;
    if (![cell.backView viewWithTag:11])
    {
        UIButton *btn = [self deleteButton:cell.hiddenElementWidth cellSize:cell.frame.size];
        btn.tag = 11;
        [cell.backView addSubview:btn];
    }
    return cell;
}

- (UIButton *)deleteButton:(CGFloat)btnWidth cellSize:(CGSize)cellSize
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = (CGRect){cellSize.width - btnWidth, 0, btnWidth, cellSize.height};
    button.backgroundColor = UIColor.redColor;
    [button setTitle:@"Delete" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)deleteClick:(UIButton *)sender
{
    SwipeTableViewCell *cell =  (SwipeTableViewCell *)sender.superview.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.array removeObjectAtIndex:indexPath.row];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
    self.selectedIndexPath = nil;
}

#pragma mark - SwipeTableViewCell delegate

- (void)swipeTableViewCell:(SwipeTableViewCell *)cell shouldStartSwipeWithIndex:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.selectedIndexPath.section && indexPath.row == self.selectedIndexPath.row)
    {
        return;
    }
    if (self.selectedIndexPath)
    {
        SwipeTableViewCell *selectedCell = (SwipeTableViewCell *)[self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
        selectedCell.selected = NO;
    }
    self.selectedIndexPath = indexPath;
}

@end

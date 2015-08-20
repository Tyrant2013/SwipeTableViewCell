//
//  ViewController.m
//  SwipeTableViewCellDemo
//
//  Created by ZhuangXiaowei on 14-9-3.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import "ViewController.h"
#import "DEMOTableViewCell.h"

@interface ViewController ()<
  UITableViewDataSource,
  UITableViewDelegate
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
                @"Open Right",
                @"Open Right!Again!",
                @"Open Left",
                @"Open Left!Again!",
                @"Both Side!"
               ] mutableCopy];
    self.tableView.tableFooterView = [[UIView alloc] init];
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
    DEMOTableViewCell *cell = (DEMOTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = _array[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    if (indexPath.row == 2 || indexPath.row == 3) {
        cell.direction = SwipeTableViewCellDirectionSingleLeft;
    }
    else if (indexPath.row == 4) {
        cell.direction = SwipeTableViewCellDirectionBoth;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DEMOTableViewCell *cell = (DEMOTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.isSwiped) {
        [cell swipeOver];
    }
    else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end

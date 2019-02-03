//
//  HistoryTableViewController.m
//  LifeCounter
//
//  Created by Dustin Langner on 2/2/19.
//  Copyright © 2019 Dustin Langner. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "HistoryTableViewCell.h"

@interface HistoryTableViewController ()

@end

@implementation HistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.09 green:0.26 blue:0.36 alpha:1.0];
    
    [self.tableView registerClass:HistoryTableViewCell.class forCellReuseIdentifier:@"HistoryTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if (!self.moveHistoryList) {
        self.moveHistoryList = [[NSMutableArray alloc]init];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.moveHistoryList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryTableViewCell" forIndexPath:indexPath];
    cell.moveLabel.text = self.moveHistoryList[indexPath.row];
    cell.moveLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  HistoryTableViewController.h
//  LifeCounter
//
//  Created by Dustin Langner on 2/2/19.
//  Copyright © 2019 Dustin Langner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryTableViewController : UITableViewController

@property (nonatomic) NSMutableArray<NSString *> *moveHistoryList;

@end

NS_ASSUME_NONNULL_END

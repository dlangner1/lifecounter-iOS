//
//  ViewController.m
//  LifeCounter
//
//  Created by Dustin Langner on 1/25/19.
//  Copyright © 2019 Dustin Langner. All rights reserved.
//

#import "ViewController.h"
#import "PlayerLifeView.h"
#import "PlayerManagerView.h"
#import "HistoryTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    HistoryTableViewController *historyTableViewController;
    
    UIScrollView *scrollView;
    
    UIStackView *playerLifeContainerView;
    UILabel *losingPlayerLabel;
    PlayerManagerView *playerManagerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.09 green:0.26 blue:0.36 alpha:1.0];
    
    historyTableViewController = [[HistoryTableViewController alloc]initWithStyle:UITableViewStylePlain];
    
    [self setupNavigationBar];
    
    losingPlayerLabel = [[UILabel alloc]init];
    losingPlayerLabel.hidden = YES;
    [losingPlayerLabel setTextColor:[UIColor colorWithRed:0.85 green:0.86 blue:0.84 alpha:1.0]];
    [losingPlayerLabel setFont: [UIFont systemFontOfSize:25]];
    losingPlayerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:losingPlayerLabel];
    
    playerManagerView = [[PlayerManagerView alloc]initWithDelegate:self];
    [self.view addSubview:playerManagerView];
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:scrollView];
    
    [self setupPlayerLifeViews];
    [self setSubviewConstraints];
}

- (void)setupNavigationBar
{
    UIBarButtonItem *historyBarButton = [[UIBarButtonItem alloc]initWithTitle:@"History" style:UIBarButtonItemStylePlain target:self action:@selector(navigateToHistoryPage)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.51 green:0.76 blue:0.84 alpha:1.0];
    self.navigationItem.rightBarButtonItem = historyBarButton;
    self.navigationItem.title = @"Life Counter";
    
}

- (void)setupPlayerLifeViews
{
    playerLifeContainerView = [[UIStackView alloc]init];
    playerLifeContainerView.axis = UILayoutConstraintAxisVertical;
    playerLifeContainerView.alignment = UIStackViewAlignmentCenter;
    playerLifeContainerView.spacing = 50;
    playerLifeContainerView.distribution = UIStackViewDistributionEqualSpacing;
    
    for (int i = 0; i < 4; i++) {
        [self addPlayerLifeView];
    }
    [scrollView addSubview:playerLifeContainerView];
    [scrollView setContentSize:playerLifeContainerView.bounds.size];
}

#pragma mark Layout

- (void)setSubviewConstraints
{
    playerManagerView.translatesAutoresizingMaskIntoConstraints = NO;
    [playerManagerView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [playerManagerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [playerManagerView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    [playerManagerView.heightAnchor constraintEqualToConstant:80].active = YES;
    
    losingPlayerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [losingPlayerLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [losingPlayerLabel.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10].active = YES;
    
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [scrollView.topAnchor constraintEqualToAnchor:playerManagerView.bottomAnchor].active = YES;
    [scrollView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [scrollView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    [scrollView.bottomAnchor constraintEqualToAnchor:losingPlayerLabel.topAnchor constant:-10].active = YES;
    
    playerLifeContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [playerLifeContainerView.widthAnchor constraintEqualToAnchor:scrollView.widthAnchor].active = YES;
    [playerLifeContainerView.topAnchor constraintEqualToAnchor:scrollView.topAnchor].active = YES;
    [playerLifeContainerView.leftAnchor constraintEqualToAnchor:scrollView.leftAnchor].active = YES;
    [playerLifeContainerView.rightAnchor constraintEqualToAnchor:scrollView.rightAnchor].active = YES;
    [playerLifeContainerView.bottomAnchor constraintLessThanOrEqualToAnchor:scrollView.bottomAnchor].active = YES;
}

# pragma mark PlayerLifeViewsDelegate

- (void)presentLosingPlayer:(NSString *)playerName
{
    NSString *losingText;
    
    if (playerName.length == 0) {
        losingText = @"Unnamed Player LOSES!";
    } else {
        losingText = [playerName stringByAppendingString:@" LOSES!"];
    }
    
    losingPlayerLabel.text = losingText;
    losingPlayerLabel.hidden = NO;
}

- (void)hideLosingPlayerLabel
{
    losingPlayerLabel.text = @"";
    losingPlayerLabel.hidden = YES;
}

- (void)saveMove:(NSString *)playerName didAdd:(BOOL)didAdd PointCost:(int)pointCost
{
    if (!historyTableViewController.moveHistoryList) {
        historyTableViewController.moveHistoryList = [[NSMutableArray alloc]init];
    }
    
    NSString *move = [NSString stringWithFormat:@"%@ %@ %d life", playerName, didAdd ? @"gained" : @"lost", pointCost];
    [historyTableViewController.moveHistoryList insertObject:move atIndex:0];
    [historyTableViewController.tableView reloadData];
}


# pragma mark PlayerManagerViewDelegate

- (void)addPlayerLifeView {
    PlayerLifeView *playerView = [[PlayerLifeView alloc]initWithDelegate:self];
    [playerLifeContainerView addArrangedSubview:playerView];
    [playerManagerView.playerLifeViews addObject:playerView];
}

- (void)removePlayerLifeView {
    int lastIndex = playerManagerView.playerLifeViews.count - 1.0;
    PlayerLifeView *viewForRemoval = playerManagerView.playerLifeViews[lastIndex];
    [playerManagerView.playerLifeViews removeLastObject];
    [viewForRemoval removeFromSuperview];
}

- (void)navigateToHistoryPage
{
    [self.navigationController pushViewController:historyTableViewController animated:YES];
}

@end

//
//  ViewController.m
//  LifeCounter
//
//  Created by Dustin Langner on 1/25/19.
//  Copyright © 2019 Dustin Langner. All rights reserved.
//

#import "ViewController.h"
#import "PlayerLifeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:20.0/255 green:29.0/255 blue:38.0/255 alpha:1.0];
    [self setupPlayerLifeViews];
}

- (void)setupPlayerLifeViews
{
    PlayerLifeView *firstPlayerView = [[PlayerLifeView alloc]init];
    [self.view addSubview:firstPlayerView];
    

    firstPlayerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [firstPlayerView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:10].active = YES;
    [firstPlayerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:30].active = YES;
    [firstPlayerView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor constant:10].active = YES;
}

- (void)setPlayerViewConstraints:(PlayerLifeView *)playerView withTopAnchor:(NSLayoutAnchor *)topAnchor
{
}

@end

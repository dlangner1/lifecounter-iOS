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
    self.playerLifeViews = [[NSArray<PlayerLifeView *> alloc] init];
    PlayerLifeView *playerView = [[PlayerLifeView alloc]init];
    [self.view addSubview:playerView];
    
    playerView.translatesAutoresizingMaskIntoConstraints = NO;
    [playerView.heightAnchor constraintEqualToConstant:100];
    [playerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:50].active = YES;
    [playerView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [playerView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
}

@end

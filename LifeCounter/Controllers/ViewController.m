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

@implementation ViewController {
    UIStackView *playerLifeContainerView;
    UILabel *losingPlayerLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:20.0/255 green:29.0/255 blue:38.0/255 alpha:1.0];
    
    losingPlayerLabel = [[UILabel alloc]init];
    losingPlayerLabel.hidden = YES;
    [losingPlayerLabel setTextColor:[UIColor colorWithRed:197.0/255 green:31.0/255.0 blue:93.0/255.0 alpha:1.0]];
    [losingPlayerLabel setFont: [UIFont systemFontOfSize:25]];
    losingPlayerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:losingPlayerLabel];
    
    [self setupPlayerLifeViews];
    [self setSubviewConstraints];
}

- (void)setupPlayerLifeViews
{
    playerLifeContainerView = [[UIStackView alloc]init];
    playerLifeContainerView.axis = UILayoutConstraintAxisVertical;
    playerLifeContainerView.alignment = UIStackViewAlignmentCenter;
    playerLifeContainerView.distribution = UIStackViewDistributionEqualSpacing;
    
    for (int i = 0; i < 4; i++) {
        PlayerLifeView *playerView = [[PlayerLifeView alloc]initWithDelegate:self];
        [playerLifeContainerView addArrangedSubview:playerView];
    }
    [self.view addSubview:playerLifeContainerView];
}

- (void)setSubviewConstraints
{
    losingPlayerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [losingPlayerLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [losingPlayerLabel.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10].active = YES;
    
    playerLifeContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [playerLifeContainerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:50].active = YES;
    [playerLifeContainerView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [playerLifeContainerView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    [playerLifeContainerView.bottomAnchor constraintEqualToAnchor:losingPlayerLabel.topAnchor constant:-40].active = YES;
}

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

@end

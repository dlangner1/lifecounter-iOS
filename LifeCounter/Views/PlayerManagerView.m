//
//  PlayerManagerView.m
//  LifeCounter
//
//  Created by Dustin Langner on 1/31/19.
//  Copyright © 2019 Dustin Langner. All rights reserved.
//

#import "PlayerManagerView.h"

@implementation PlayerManagerView

- (instancetype)initWithDelegate:(id<PlayerManagerViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.playerLifeViews = [[NSMutableArray alloc]init];
    
        self.axis = UILayoutConstraintAxisHorizontal;
        self.alignment = UIStackViewAlignmentCenter;
        self.spacing = 10;
        self.distribution = UIStackViewDistributionFillEqually;
        
        self.addPlayerButton = [self createPlayerManagerButton:@"+ Add Player" WithColor:UIColor.greenColor AndAction:@selector(addPlayer)];
        self.removePlayerButton = [self createPlayerManagerButton:@"- Remove Player" WithColor:UIColor.redColor AndAction:@selector(removePlayer)];
        
        [self addArrangedSubview:self.addPlayerButton];
        [self addArrangedSubview:self.removePlayerButton];
    }
    return self;
}

- (UIButton *)createPlayerManagerButton:(NSString *)text WithColor:(UIColor *)color AndAction:(nonnull SEL)action
{
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = color;
    button.layer.cornerRadius = 10;
    [button setTintColor:UIColor.whiteColor];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

# pragma mark Button Actions

- (void)addPlayer
{
    if (self.playerLifeViews.count < 8) {
        [self.delegate addPlayerLifeView];
    }
}

- (void)removePlayer
{
    if (self.playerLifeViews.count > 2) {
        [self.delegate removePlayerLifeView];
    }
}

@end

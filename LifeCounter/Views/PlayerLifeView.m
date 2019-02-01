//
//  PlayerLifeView.m
//  LifeCounter
//
//  Created by Dustin Langner on 1/25/19.
//  Copyright © 2019 Dustin Langner. All rights reserved.
//


#import "PlayerLifeView.h"
#import <UIKit/UIKit.h>

@implementation PlayerLifeView
{
    UILabel *playerNameLabel;
    
    UILabel *lifeCountLabel;
    int currentLifeCount;
    
    UIScrollView *scrollView;
    UIStackView *buttonContainerView;
    UIButton *plusOneButton;
    UIButton *minusOneButton;
    UIButton *plusFiveButton;
    UIButton *minusFiveButton;
}

static int playerNumber = 0;

- (instancetype)initWithDelegate:(id <PlayerLifeViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        currentLifeCount = 20;
        
        // Initialize all subviews
        playerNumber += 1;
        playerNameLabel = [[UILabel alloc]init];
        [playerNameLabel setTextColor:UIColor.whiteColor];
        [playerNameLabel setFont:[UIFont systemFontOfSize:22]];
        playerNameLabel.text = [NSString stringWithFormat: @"Player %d", playerNumber];
        [self addSubview:playerNameLabel];
    
        plusOneButton = [self createLifeCountButtonWithLabelText:@"+" Action:@selector(incrementLifeLabelOne)];
        minusOneButton = [self createLifeCountButtonWithLabelText:@"-" Action:@selector(decrementLifeLabelOne)];
        plusFiveButton = [self createLifeCountButtonWithLabelText:@"+5" Action:@selector(incrementLifeLabelFive)];
        minusFiveButton = [self createLifeCountButtonWithLabelText:@"-5" Action:@selector(decrementLifeLabelFive)];
        
        buttonContainerView = [[UIStackView alloc]init];
        buttonContainerView.axis = UILayoutConstraintAxisHorizontal;
        buttonContainerView.distribution = UIStackViewDistributionFillEqually;
        buttonContainerView.alignment = UIStackViewAlignmentCenter;
        buttonContainerView.spacing = 10;
        
        [buttonContainerView addArrangedSubview:plusOneButton];
        [buttonContainerView addArrangedSubview:minusOneButton];
        [buttonContainerView addArrangedSubview:plusFiveButton];
        [buttonContainerView addArrangedSubview:minusFiveButton];
        [self addSubview:buttonContainerView];
        
        lifeCountLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        lifeCountLabel.backgroundColor = [UIColor colorWithRed:197.0/255 green:31.0/255.0 blue:93.0/255.0 alpha:1.0];
        lifeCountLabel.text = [NSString stringWithFormat: @"%d", currentLifeCount];
        [lifeCountLabel setTextColor:UIColor.whiteColor];
        lifeCountLabel.textAlignment = NSTextAlignmentCenter;
        [lifeCountLabel setFont: [UIFont systemFontOfSize:20]];
        lifeCountLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:lifeCountLabel];
        
        // Set subview constraints
        [self setSubviewConstraints];
    }
    return self;
}

- (void)dealloc
{
    playerNumber -= 1;
}

- (void)setSubviewConstraints
{
    playerNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [playerNameLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [playerNameLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [playerNameLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    buttonContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonContainerView.leftAnchor constraintEqualToAnchor:playerNameLabel.rightAnchor constant:20].active = YES;
    [buttonContainerView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [buttonContainerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    lifeCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [lifeCountLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [lifeCountLabel.leftAnchor constraintEqualToAnchor:buttonContainerView.rightAnchor constant:10].active = YES;
    [lifeCountLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [lifeCountLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [lifeCountLabel.widthAnchor constraintEqualToConstant:30].active = YES;
    [lifeCountLabel.heightAnchor constraintEqualToConstant:30].active = YES;
}

- (UIButton *)createLifeCountButtonWithLabelText:(NSString *)text Action:(nonnull SEL)action
{
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor colorWithRed:36.0/255.0 green:52.0/255.0 blue:71.0/255.0 alpha:1.0];
    button.layer.cornerRadius = 10;
    
    [button setTitle:text forState:UIControlStateNormal];
    [button.titleLabel setFont: [UIFont systemFontOfSize:22]];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)incrementLifeLabelOne
{
    currentLifeCount += 1;
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", currentLifeCount];
    [self hideLosingLabelIfNeeded];
}

- (void)decrementLifeLabelOne
{
    if (currentLifeCount == 0) {
        return;
    }
    currentLifeCount -= 1;
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", currentLifeCount];
    [self showingLosingLabelIfNeeded];
}

- (void)incrementLifeLabelFive
{
    currentLifeCount += 5;
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", currentLifeCount];
    [self hideLosingLabelIfNeeded];
}

- (void)decrementLifeLabelFive
{
    if (currentLifeCount == 0 || currentLifeCount - 5 <= 0) {
        currentLifeCount = 0;
    } else {
        currentLifeCount -= 5;
    }
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", currentLifeCount];
    [self showingLosingLabelIfNeeded];
}

- (void)showingLosingLabelIfNeeded
{
    if (currentLifeCount == 0 && [self.delegate respondsToSelector:@selector(presentLosingPlayer:)]) {
        [self.delegate presentLosingPlayer:playerNameLabel.text];
    }
}

- (void)hideLosingLabelIfNeeded
{
    if (currentLifeCount > 0 && [self.delegate respondsToSelector:@selector(hideLosingPlayerLabel)]) {
        [self.delegate hideLosingPlayerLabel];
    }
}

+ (int)playerNumber
{
    return playerNumber;
}

@end

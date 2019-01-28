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
    UITextField *playerNameTextField;
    
    UILabel *lifeCountLabel;
    int currentLifeCount;
    
    UIButton *plusOneButton;
    UIButton *minusOneButton;
    UIButton *plusFiveButton;
    UIButton *minusFiveButton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Life State
        currentLifeCount = 20;
        
        // Initialize all subviews
        playerNameTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        playerNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        playerNameTextField.backgroundColor = UIColor.whiteColor;
        [self addSubview:playerNameTextField];
        
        plusOneButton = [self createLifeCountButtonWithLabelText:@"+" Action:@selector(incrementLifeLabelOne)];
        [self addSubview:plusOneButton];
        
        minusOneButton = [self createLifeCountButtonWithLabelText:@"-" Action:@selector(decrementLifeLabelOne)];
        [self addSubview:minusOneButton];
        
        plusFiveButton = [self createLifeCountButtonWithLabelText:@"+5" Action:@selector(incrementLifeLabelFive)];
        [self addSubview:plusFiveButton];
        
        minusFiveButton = [self createLifeCountButtonWithLabelText:@"-5" Action:@selector(decrementLifeLabelFive)];
        [self addSubview:minusFiveButton];
        
        lifeCountLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [UIColor colorWithRed:197.0/255 green:31.0/255.0 blue:93.0/255.0 alpha:1.0];
        
        lifeCountLabel.backgroundColor = [UIColor colorWithRed:197.0/255 green:31.0/255.0 blue:93.0/255.0 alpha:1.0];
        lifeCountLabel.text = [NSString stringWithFormat: @"%d", currentLifeCount];
        [lifeCountLabel setTextColor:UIColor.whiteColor];
        lifeCountLabel.textAlignment = NSTextAlignmentCenter;
        [lifeCountLabel setFont: [UIFont systemFontOfSize:22]];
        lifeCountLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:lifeCountLabel];
        
        // Set subview constraints
        [self setSubviewConstraints];
    }
    return self;
}

- (void)setSubviewConstraints
{
    playerNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [playerNameTextField.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:10].active = YES;
    [playerNameTextField.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [playerNameTextField.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [playerNameTextField.widthAnchor constraintEqualToConstant:100].active = YES;
    
    plusOneButton.translatesAutoresizingMaskIntoConstraints = NO;
    [plusOneButton.leftAnchor constraintEqualToAnchor:playerNameTextField.rightAnchor constant:10].active = YES;
    [plusOneButton.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [plusOneButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    minusOneButton.translatesAutoresizingMaskIntoConstraints = NO;
    [minusOneButton.leftAnchor constraintEqualToAnchor:plusOneButton.rightAnchor constant:10].active = YES;
    [minusOneButton.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [minusOneButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    plusFiveButton.translatesAutoresizingMaskIntoConstraints = NO;
    [plusFiveButton.leftAnchor constraintEqualToAnchor:minusOneButton.rightAnchor constant:10].active = YES;
    [plusFiveButton.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [plusFiveButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    minusFiveButton.translatesAutoresizingMaskIntoConstraints = NO;
    [minusFiveButton.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [minusFiveButton.leftAnchor constraintEqualToAnchor:plusFiveButton.rightAnchor constant:10].active = YES;
    [minusFiveButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    lifeCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [lifeCountLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-10].active = YES;
    [lifeCountLabel.leftAnchor constraintEqualToAnchor:minusFiveButton.rightAnchor constant:10].active = YES;
    [lifeCountLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [lifeCountLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [lifeCountLabel.widthAnchor constraintEqualToConstant:50].active = YES;
    [lifeCountLabel.heightAnchor constraintEqualToConstant:50].active = YES;
}

- (UIButton *)createLifeCountButtonWithLabelText:(NSString *)text Action:(nonnull SEL)action
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectZero];
    
//    [UIColor colorWithRed:197.0/255 green:31.0/255.0 blue:93.0/255.0 alpha:1.0];
//    [UIColor colorWithRed:20.0/255 green:29.0/255 blue:38.0/255 alpha:1.0];
    
    button.backgroundColor = [UIColor colorWithRed:36.0/255.0 green:52.0/255.0 blue:71.0/255.0 alpha:1.0];
    
    // Setup title label
    [button setTitle:text forState:UIControlStateNormal];
    [button.titleLabel setFont: [UIFont systemFontOfSize:22]];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    // Add size constraints
    [button.heightAnchor constraintEqualToConstant:100];
    [button.widthAnchor constraintGreaterThanOrEqualToConstant:50];
    
    button.layer.cornerRadius = 10;
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)incrementLifeLabelOne
{
    currentLifeCount += 1;
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", currentLifeCount];
}

- (void)decrementLifeLabelOne
{
    currentLifeCount -= 1;
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", currentLifeCount];
}

- (void)incrementLifeLabelFive
{
    currentLifeCount += 5;
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", currentLifeCount];
}

- (void)decrementLifeLabelFive
{
    currentLifeCount -= 5;
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", currentLifeCount];
}

@end

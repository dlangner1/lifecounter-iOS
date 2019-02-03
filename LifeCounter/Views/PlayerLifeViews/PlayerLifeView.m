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
    
    UIStackView *buttonContainerView;
    UIButton *plusOneButton;
    UIButton *minusOneButton;
    
    UIButton *plusXButton;
    UITextField *plusXTextField;
    
    UIButton *minusXButton;
    UITextField *minusXTextField;
}

static int playerNumber = 0;

- (instancetype)initWithDelegate:(id <PlayerLifeViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.currentLifeCount = 20;
        
        // Initialize all subviews
        playerNumber += 1;
        playerNameLabel = [[UILabel alloc]init];
        [playerNameLabel setTextColor:[UIColor colorWithRed:0.85 green:0.86 blue:0.84 alpha:1.0]];
        [playerNameLabel setFont:[UIFont systemFontOfSize:18]];
        playerNameLabel.text = [NSString stringWithFormat: @"Player %d", playerNumber];
        [self addSubview:playerNameLabel];
    
        plusOneButton = [self createLifeCountButtonWithLabelText:@"+1" Action:@selector(incrementLifeLabelOne)];
        minusOneButton = [self createLifeCountButtonWithLabelText:@"-1" Action:@selector(decrementLifeLabelOne)];
        plusXButton = [self createLifeCountButtonWithLabelText:@"+" Action:@selector(incrementLifeLabelX)];
        minusXButton = [self createLifeCountButtonWithLabelText:@"-" Action:@selector(decrementLifeLabelX)];
        
        plusXTextField = [[UITextField alloc]init];
        plusXTextField.keyboardType = UIKeyboardTypeNumberPad;
        plusXTextField.backgroundColor = [UIColor colorWithRed:0.85 green:0.86 blue:0.84 alpha:1.0];
        plusXTextField.text = @"5";
        plusXTextField.delegate = self;
        
        minusXTextField = [[UITextField alloc]init];
        minusXTextField.keyboardType = UIKeyboardTypeNumberPad;
        minusXTextField.backgroundColor = [UIColor colorWithRed:0.85 green:0.86 blue:0.84 alpha:1.0];
        minusXTextField.text = @"5";
        minusXTextField.delegate = self;
        
        buttonContainerView = [[UIStackView alloc]init];
        buttonContainerView.axis = UILayoutConstraintAxisHorizontal;
        buttonContainerView.distribution = UIStackViewDistributionFillEqually;
        buttonContainerView.alignment = UIStackViewAlignmentCenter;
        buttonContainerView.spacing = 10;
        
        [buttonContainerView addArrangedSubview:plusOneButton];
        [buttonContainerView addArrangedSubview:minusOneButton];
        [buttonContainerView addArrangedSubview:plusXButton];
        [buttonContainerView addArrangedSubview:plusXTextField];
        [buttonContainerView addArrangedSubview:minusXButton];
        [buttonContainerView addArrangedSubview:minusXTextField];
        [self addSubview:buttonContainerView];
        
        lifeCountLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        lifeCountLabel.backgroundColor = [UIColor colorWithRed:0.18 green:0.40 blue:0.56 alpha:1.0];
        lifeCountLabel.text = [NSString stringWithFormat: @"%d", self.currentLifeCount];
        [lifeCountLabel setTextColor:[UIColor colorWithRed:0.85 green:0.86 blue:0.84 alpha:1.0]];
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

# pragma mark Layout

- (void)setSubviewConstraints
{
    playerNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [playerNameLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [playerNameLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [playerNameLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    buttonContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonContainerView.leftAnchor constraintEqualToAnchor:playerNameLabel.rightAnchor constant:5].active = YES;
    [buttonContainerView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [buttonContainerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    [plusXTextField.heightAnchor constraintEqualToConstant:30].active = YES;
    [minusXTextField.heightAnchor constraintEqualToConstant:30].active = YES;
    
    lifeCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [lifeCountLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [lifeCountLabel.leftAnchor constraintEqualToAnchor:buttonContainerView.rightAnchor constant:10].active = YES;
    [lifeCountLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [lifeCountLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [lifeCountLabel.widthAnchor constraintEqualToConstant:40].active = YES;
    [lifeCountLabel.heightAnchor constraintEqualToConstant:40].active = YES;
}

# pragma Button Actions

- (void)incrementLifeLabelOne
{
    self.currentLifeCount += 1;
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", self.currentLifeCount];
    [self hideLosingLabelIfNeeded];
    if ([self.delegate respondsToSelector:@selector(saveMove:didAdd:PointCost:)]) {
        [self.delegate saveMove:playerNameLabel.text didAdd:YES PointCost:1];
    }
}

- (void)decrementLifeLabelOne
{
    if (self.currentLifeCount == 0) {
        return;
    }
    self.currentLifeCount -= 1;
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", self.currentLifeCount];
    [self showingLosingLabelIfNeeded];
    [self.delegate saveMove:playerNameLabel.text didAdd:NO PointCost:1];
    if ([self.delegate respondsToSelector:@selector(saveMove:didAdd:PointCost:)]) {
        [self.delegate saveMove:playerNameLabel.text didAdd:NO PointCost:1];
    }
}

- (void)incrementLifeLabelX
{
    int value = plusXTextField.text.intValue;
    self.currentLifeCount += value;
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", self.currentLifeCount];
    [self hideLosingLabelIfNeeded];
    if ([self.delegate respondsToSelector:@selector(saveMove:didAdd:PointCost:)]) {
        [self.delegate saveMove:playerNameLabel.text didAdd:YES PointCost:value];
    }
}

- (void)decrementLifeLabelX
{
    int value = minusXTextField.text.intValue;
    if (self.currentLifeCount == 0 || self.currentLifeCount - value <= 0) {
        self.currentLifeCount = 0;
    } else {
        self.currentLifeCount -= value;
    }
    lifeCountLabel.text = [NSString stringWithFormat:@"%d", self.currentLifeCount];
    [self showingLosingLabelIfNeeded];
    if ([self.delegate respondsToSelector:@selector(saveMove:didAdd:PointCost:)]) {
        [self.delegate saveMove:playerNameLabel.text didAdd:NO PointCost:value];
    }
}

# pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 2;
}


# pragma mark PlayerLifeViewDelegate Callers

- (void)showingLosingLabelIfNeeded
{
    if (self.currentLifeCount == 0 && [self.delegate respondsToSelector:@selector(presentLosingPlayer:)]) {
        [self.delegate presentLosingPlayer:playerNameLabel.text];
    }
}

- (void)hideLosingLabelIfNeeded
{
    if (self.currentLifeCount > 0 && [self.delegate respondsToSelector:@selector(hideLosingPlayerLabel)]) {
        [self.delegate hideLosingPlayerLabel];
    }
}

# pragma Helpers

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

# pragma mark Class methods

+ (int)playerNumber
{
    return playerNumber;
}

@end

//
//  PlayerLifeView.h
//  LifeCounter
//
//  Created by Dustin Langner on 1/25/19.
//  Copyright © 2019 Dustin Langner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerLifeViewDelegate <NSObject>

- (void)presentLosingPlayer:(NSString *)playerName;

- (void)hideLosingPlayerLabel;

@end

@interface PlayerLifeView : UIView <UITextFieldDelegate>

@property (nonatomic, weak) id<PlayerLifeViewDelegate> delegate;
@property (nonatomic) int currentLifeCount;


- (instancetype)initWithDelegate:(id <PlayerLifeViewDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END

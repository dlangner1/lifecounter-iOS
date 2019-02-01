//
//  PlayerManagerView.h
//  LifeCounter
//
//  Created by Dustin Langner on 1/31/19.
//  Copyright © 2019 Dustin Langner. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlayerLifeView;

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerManagerViewDelegate <NSObject>

- (void)addPlayerLifeView;

- (void)removePlayerLifeView;

@end



@interface PlayerManagerView : UIStackView

@property (nonatomic, weak) id<PlayerManagerViewDelegate> delegate;

@property UIButton *addPlayerButton;
@property UIButton *removePlayerButton;
@property NSMutableArray<PlayerLifeView *> *playerLifeViews;

- (instancetype)initWithDelegate:(id <PlayerManagerViewDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END

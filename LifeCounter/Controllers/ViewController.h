//
//  ViewController.h
//  LifeCounter
//
//  Created by Dustin Langner on 1/25/19.
//  Copyright © 2019 Dustin Langner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerLifeView.h"
#import "PlayerManagerView.h"

@interface ViewController : UIViewController <PlayerLifeViewDelegate, PlayerManagerViewDelegate>

@end


//
//  ViewController.h
//  Matchismo
//
//  Created by Chrisna Aing on 10/25/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Deck.h"

@interface CardGameViewController : UIViewController

// Abstract
- (Deck *)createDeck;

@end


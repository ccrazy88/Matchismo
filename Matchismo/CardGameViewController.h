//
//  ViewController.h
//  Matchismo
//
//  Created by Chrisna Aing on 10/25/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

@import UIKit;

#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

// For viewing
@property (strong, nonatomic, readonly) IBOutletCollection(UIButton) NSArray *cardButtons;

- (void)createNewGame;

// Abstract
- (Deck *)createDeck;
- (CardMatchingGame *)createGame;

@end


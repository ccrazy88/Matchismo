//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Chrisna Aing on 12/11/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

@import Foundation;

#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic) NSUInteger cardsToMatch;
// NSArray of CardMatchingGameResult
@property (strong, nonatomic, readonly) NSArray *history;
@property (nonatomic, readonly) NSInteger score;


- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                     cardsToMatch:(NSUInteger)cardsToMatch NS_DESIGNATED_INITIALIZER;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end

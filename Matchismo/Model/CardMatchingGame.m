//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Chrisna Aing on 12/11/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame()

// NSMutableArray of Cards
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) NSInteger score;

@end

@implementation CardMatchingGame

static const NSInteger COST_TO_CHOOSE = 1;
static const NSInteger MATCH_BONUS = 4;
static const NSInteger MISMATCH_PENALTY = 2;

#pragma mark - Lazy Initializers

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

#pragma mark - Initializers

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (NSUInteger i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

#pragma mark - Utilities

- (Card *)cardAtIndex:(NSUInteger)index
{
    return index < [self.cards count] ? self.cards[index] : nil;

}

#pragma mark - Game

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (card) {
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
            } else {
                // Match card against other chosen cards.
                for (Card *otherCard in self.cards) {
                    if (!otherCard.isMatched && otherCard.isChosen) {
                        NSInteger matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            otherCard.matched = YES;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                        break;
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }

}

@end

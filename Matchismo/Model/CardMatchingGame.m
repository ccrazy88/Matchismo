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

@synthesize cardsToMatch = _cardsToMatch;

static const NSInteger COST_TO_CHOOSE = 1;
static const NSInteger MATCH_BONUS = 4;
static const NSInteger MISMATCH_PENALTY = 2;

static const NSUInteger MIN_CARDS_TO_MATCH = 2;

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

#pragma mark - Computed Properties

- (NSUInteger)cardsToMatch
{
    return _cardsToMatch >= MIN_CARDS_TO_MATCH ? _cardsToMatch: MIN_CARDS_TO_MATCH;
}

- (void)setCardsToMatch:(NSUInteger)cardsToMatch
{
    if (cardsToMatch >= MIN_CARDS_TO_MATCH && cardsToMatch < [self.cards count]) {
        _cardsToMatch = cardsToMatch;
    }
}

#pragma mark - Utilities

- (Card *)cardAtIndex:(NSUInteger)index
{
    return index < [self.cards count] ? self.cards[index] : nil;

}

- (NSArray *)cardsEligibleForMatching:(NSArray *)cards
{
    NSMutableArray *eligibleCards = [[NSMutableArray alloc] init];
    for (Card *card in cards) {
        if (!card.isMatched && card.isChosen) {
            [eligibleCards addObject:card];
        }
    }
    return [eligibleCards copy];
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
                // Put potential cards to match into an array.
                NSArray *otherCards = [self cardsEligibleForMatching:self.cards];
                // Only try to match the cards when there are enough of them.
                if ([otherCards count] + 1 == self.cardsToMatch) {
                    NSInteger matchScore = [card match:otherCards];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        for (Card *otherCard in otherCards) {
                            otherCard.matched = YES;
                        }
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *otherCard in otherCards) {
                            otherCard.chosen = NO;
                        }
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }

}

@end

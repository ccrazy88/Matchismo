//
//  PlayingCard.m
//  Matchismo
//
//  Created by Chrisna Aing on 10/29/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

#pragma mark - Computed Properties

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

#pragma mark - Utilities

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[PlayingCard rankStrings] count] - 1;
}

+ (NSArray *)validSuits
{
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

+ (BOOL)isArrayOfPlayingCards:(NSArray *)cards
{
    for (id card in cards) {
        if (![card isKindOfClass:[PlayingCard class]]) {
            return NO;
        }
    }
    return YES;
}

+ (NSUInteger)uniqueRanksInCards:(NSArray *)cards
{
    if ([[self class] isArrayOfPlayingCards:cards]) {
        return [PlayingCard uniqueKey:@"rank" inCards:cards];
    }
    return 0;
}

+ (NSUInteger)uniqueSuitsInCards:(NSArray *)cards
{
    if ([PlayingCard isArrayOfPlayingCards:cards]) {
        return [PlayingCard uniqueKey:@"suit" inCards:cards];
    }
    return 0;
}

#pragma mark - Card Matching

- (NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 0;
    NSUInteger otherCardsCount = [otherCards count];

    // Only matching with PlayingCard supported.
    if (![PlayingCard isArrayOfPlayingCards:otherCards]) {
        return score;
    }

    // Matching with one other card and two other cards supported.
    if (otherCardsCount == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (self.rank == otherCard.rank) {
            score = 4;
        } else if ([self.suit isEqualToString:otherCard.suit]) {
            score = 1;
        }
    } else if (otherCardsCount == 2) {
        NSArray *allCards = [otherCards arrayByAddingObjectsFromArray:@[self]];
        NSUInteger uniqueRanks = [PlayingCard uniqueRanksInCards:allCards];
        NSUInteger uniqueSuits = [PlayingCard uniqueSuitsInCards:allCards];
        if (uniqueRanks == 1) {
            score = 100;
        } else if (uniqueSuits == 1) {
            score = 4;
        } else if (uniqueRanks == 2 && uniqueSuits == 2) {
            score = 3;
        } else if (uniqueRanks == 2) {
            score = 2;
        } else if (uniqueSuits == 2) {
            score = 1;
        }
    }
    return score;
}

@end

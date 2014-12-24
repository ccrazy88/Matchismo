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

- (NSUInteger)uniqueRanksInCards:(NSArray *)cards
{
    NSMutableDictionary *ranks = [[NSMutableDictionary alloc] init];
    for (PlayingCard *card in cards) {
        [ranks setValue:@1 forKey:[NSString stringWithFormat:@"%lu", (unsigned long)card.rank]];
    }
    return [ranks count];
}

- (NSUInteger)uniqueSuitsInCards:(NSArray *)cards
{
    NSMutableDictionary *suits = [[NSMutableDictionary alloc] init];
    for (PlayingCard *card in cards) {
        [suits setValue:@1 forKey:card.suit];
    }
    return [suits count];
}

#pragma mark - Card Matching

- (NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 0;
    NSUInteger otherCardsCount = [otherCards count];

    // Only matching with PlayingCard supported.
    for (id card in otherCards) {
        if (![card isKindOfClass:[PlayingCard class]]) {
            return score;
        }
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
        NSUInteger uniqueRanks = [self uniqueRanksInCards:allCards];
        NSUInteger uniqueSuits = [self uniqueSuitsInCards:allCards];
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

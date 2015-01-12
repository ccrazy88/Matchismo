//
//  Card.m
//  Matchismo
//
//  Created by Chrisna Aing on 10/25/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

#pragma mark - Utilities

+ (NSUInteger)uniqueKey:(NSString *)key inCards:(NSArray *)cards
{
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (id card in cards) {
        id value = [card valueForKey:key];
        [set addObject:value];
    }
    return [set count];
}

#pragma mark - Card Matching

- (NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end

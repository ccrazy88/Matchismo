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

//
//  SetCard.m
//  Matchismo
//
//  Created by Chrisna Aing on 12/28/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

static const NSUInteger COUNT_OF_TYPE = 3;

#pragma mark - Computed Properties

- (void)setColor:(NSUInteger)color
{
    if (color < [SetCard countOfType]) {
        _color = color;
    }

}

- (void)setNumber:(NSUInteger)number
{
    if (number < [SetCard countOfType]) {
        _number = number;
    }

}

- (void)setShading:(NSUInteger)shading
{
    if (shading < [SetCard countOfType]) {
        _shading = shading;
    }

}

- (void)setShape:(NSUInteger)shape
{
    if (shape < [SetCard countOfType]) {
        _shape = shape;
    }
}

#pragma mark - Utilities

+ (NSUInteger)countOfType
{
    return COUNT_OF_TYPE;
}

+ (BOOL)isArrayOfSetCards:(NSArray *)cards
{
    for (id card in cards) {
        if (![card isKindOfClass:[SetCard class]]) {
            return NO;
        }
    }
    return YES;
}

+ (NSUInteger)uniqueColorsInCards:(NSArray *)cards
{
    if ([SetCard isArrayOfSetCards:cards]) {
        return [SetCard uniqueKey:@"color" inCards:cards];
    }
    return 0;
}

+ (NSUInteger)uniqueNumbersInCards:(NSArray *)cards
{
    if ([SetCard isArrayOfSetCards:cards]) {
        return [SetCard uniqueKey:@"number" inCards:cards];
    }
    return 0;
}

+ (NSUInteger)uniqueShadingsInCards:(NSArray *)cards
{
    if ([SetCard isArrayOfSetCards:cards]) {
        return [SetCard uniqueKey:@"shading" inCards:cards];
    }
    return 0;
}

+ (NSUInteger)uniqueShapesInCards:(NSArray *)cards
{
    if ([SetCard isArrayOfSetCards:cards]) {
        return [SetCard uniqueKey:@"shape" inCards:cards];
    }
    return 0;
}

- (NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 0;

    // Only matching with SetCard supported.
    if (![SetCard isArrayOfSetCards:otherCards]) {
        return score;
    }

    if ([otherCards count] == [SetCard countOfType] - 1) {
        NSArray *allCards = [otherCards arrayByAddingObjectsFromArray:@[self]];
        NSMutableArray *allCounts = [[NSMutableArray alloc] init];

        [allCounts addObject:@([SetCard uniqueColorsInCards:allCards])];
        [allCounts addObject:@([SetCard uniqueNumbersInCards:allCards])];
        [allCounts addObject:@([SetCard uniqueShadingsInCards:allCards])];
        [allCounts addObject:@([SetCard uniqueShapesInCards:allCards])];

        for (NSNumber *count in allCounts) {
            NSInteger integerValue = [count integerValue];
            if (integerValue != 1 && (NSUInteger)integerValue != [SetCard countOfType]) {
                return score;
            }
        }
        score = 4;
    }
    return score;
}

@end

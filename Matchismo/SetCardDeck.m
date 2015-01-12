//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Chrisna Aing on 12/28/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSUInteger color = 0; color < [SetCard countOfType]; color++) {
            for (NSUInteger number = 0; number < [SetCard countOfType]; number++) {
                for (NSUInteger shading = 0; shading < [SetCard countOfType]; shading++) {
                    for (NSUInteger shape = 0; shape < [SetCard countOfType]; shape++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.number = number;
                        card.shading = shading;
                        card.shape = shape;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end

//
//  PlayingCard.h
//  Matchismo
//
//  Created by Chrisna Aing on 10/29/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end

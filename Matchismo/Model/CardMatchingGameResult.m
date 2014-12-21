//
//  CardMatchingGameResult.m
//  Matchismo
//
//  Created by Chrisna Aing on 12/21/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "CardMatchingGameResult.h"

@implementation CardMatchingGameResult

- (instancetype)init
{
    return [self initWithCards:@[] matchAttempted:NO matched:NO matchScore:0];

}

- (instancetype)initWithCards:(NSArray *)cards
               matchAttempted:(BOOL)matchAttempted
                      matched:(BOOL)matched
                   matchScore:(NSInteger)matchScore
{
    self = [super init];
    if (self) {
        _cards = cards;
        _matchAttempted = matchAttempted;
        _matched = matched;
        _matchScore = matchScore;
    }
    return self;
}


@end

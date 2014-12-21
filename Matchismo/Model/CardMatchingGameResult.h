//
//  CardMatchingGameResult.h
//  Matchismo
//
//  Created by Chrisna Aing on 12/21/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardMatchingGameResult : NSObject

@property (strong, nonatomic) NSArray *cards;
@property (nonatomic, getter=isMatchAttempted) BOOL matchAttempted;
@property (nonatomic, getter=isMatched) BOOL matched;
@property (nonatomic) NSInteger matchScore;

- (instancetype)initWithCards:(NSArray *)cards
               matchAttempted:(BOOL)matchAttempted
                      matched:(BOOL)matched
                   matchScore:(NSInteger)matchScore NS_DESIGNATED_INITIALIZER;

@end

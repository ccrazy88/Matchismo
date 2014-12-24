//
//  CardMatchingGameResult.h
//  Matchismo
//
//  Created by Chrisna Aing on 12/21/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

@import Foundation;

@interface CardMatchingGameResult : NSObject

@property (strong, nonatomic, readonly) NSArray *cards;
@property (nonatomic, getter=isMatchAttempted, readonly) BOOL matchAttempted;
@property (nonatomic, getter=isMatched, readonly) BOOL matched;
@property (nonatomic, readonly) NSInteger matchScore;

- (instancetype)initWithCards:(NSArray *)cards
               matchAttempted:(BOOL)matchAttempted
                      matched:(BOOL)matched
                   matchScore:(NSInteger)matchScore NS_DESIGNATED_INITIALIZER;

@end

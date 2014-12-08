//
//  Deck.h
//  Matchismo
//
//  Created by Chrisna Aing on 10/26/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

@import Foundation;

#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card; 
- (Card *)drawRandomCard;

@end

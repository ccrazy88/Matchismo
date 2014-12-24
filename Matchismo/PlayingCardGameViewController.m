//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Chrisna Aing on 12/24/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end

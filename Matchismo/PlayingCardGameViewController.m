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

#pragma mark - Utilities

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]
                                          cardsToMatch:2];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:card.contents];
    // Make text black because UIButton's default color is tintColor.
    [contents addAttribute:NSForegroundColorAttributeName
                     value:[UIColor blackColor]
                     range:NSMakeRange(0, [card.contents length])];
    // Return an immutable version.
    return card.isChosen ? [[NSAttributedString alloc] initWithAttributedString:contents] : nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
}

- (NSAttributedString *)stringForCards:(NSArray *)cards
{
    NSString *cardsString = @"";
    for (Card *card in cards) {
        // Don't use titleForCard, which adds a black text attribute.
        cardsString = [cardsString stringByAppendingString:card.contents];
    }
    return [[NSAttributedString alloc] initWithString:cardsString];
}

@end

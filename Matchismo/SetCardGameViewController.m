//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Chrisna Aing on 1/11/15.
//  Copyright (c) 2015 Chrisna Aing. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createNewGame];
}

#pragma mark - Utilities

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (CardMatchingGame *)createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]
                                          cardsToMatch:3];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    if ([card isKindOfClass:[SetCard class]]) {
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] init];
        SetCard *setCard = (SetCard *)card;
        for (NSUInteger i = 0; i <= setCard.number; i++) {
            NSString *shape = @[@"▲", @"●", @"■"][setCard.shape];
            UIColor *color = @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]][setCard.color];
            NSRange range = NSMakeRange(0, [shape length]);
            NSMutableAttributedString *character = [[NSMutableAttributedString alloc] initWithString:shape];
            if (setCard.shading == 0) {
                // Solid
                [character addAttribute:NSForegroundColorAttributeName value:color range:range];
            } else if (setCard.shading == 1) {
                // Striped (transparent in this case)
                [character addAttribute:NSForegroundColorAttributeName
                                  value:[color colorWithAlphaComponent:0.5f]
                                  range:range];
            } else if (setCard.shading == 2) {
                // Outlined
                [character addAttribute:NSStrokeColorAttributeName value:color range:range];
                [character addAttribute:NSStrokeWidthAttributeName value:@3 range:range];
            }
            [title appendAttributedString:character];
        }
        return title;
    } else {
        return nil;
    }
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"ChosenCardFront" : @"CardFront"];
}

- (NSAttributedString *)stringForCards:(NSArray *)cards
{
    NSMutableAttributedString *cardsString = [[NSMutableAttributedString alloc] init];
    for (Card *card in cards) {
        NSAttributedString *cardTitle = [self titleForCard:card];
        if (cardTitle) {
            [cardsString appendAttributedString:cardTitle];
        } else {
            return nil;
        }
    }
    return cardsString;
}

@end

//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Chrisna Aing on 10/25/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation CardGameViewController

#pragma mark - Lazy Initializers

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [self createGame];
    }
    return _game;
}

#pragma mark - Utilities

- (CardMatchingGame *)createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
}

- (NSString *)stringForCards:(NSArray *)cards
{
    NSString *cardsString = @"";
    for (Card *card in cards) {
        cardsString = [cardsString stringByAppendingString:card.contents];
    }
    return cardsString;
}

- (NSString *)stringForLastMove
{
    CardMatchingGameResult *lastMove = self.game.lastMove;
    NSString *cardsString = [self stringForCards:self.game.lastMove.cards];
    NSString *lastMoveString;
    if (lastMove.matchAttempted) {
        if (lastMove.isMatched) {
            lastMoveString = [NSString stringWithFormat:@"Matched %@ for %ld point", cardsString, (long)lastMove.matchScore];
            if (lastMove.matchScore != 1) {
                lastMoveString = [lastMoveString stringByAppendingString:@"s"];
            }
            lastMoveString = [lastMoveString stringByAppendingString:@"."];
        } else {
            lastMoveString = [NSString stringWithFormat:@"%@ don't match! %ld point penalty!", cardsString, (long)lastMove.matchScore];
        }
    } else {
        lastMoveString = cardsString;
    }
    return lastMoveString;
}

#pragma mark - Game

- (IBAction)startNewGame {
    UIAlertController *alertController;
    UIAlertAction *noAction;
    UIAlertAction *yesAction;

    alertController = [UIAlertController alertControllerWithTitle:@"Start New Game"
                                                          message:@"Are you sure?"
                                                   preferredStyle:UIAlertControllerStyleAlert];
    noAction = [UIAlertAction actionWithTitle:@"No"
                                        style:UIAlertActionStyleCancel
                                      handler:nil];
    yesAction = [UIAlertAction actionWithTitle:@"Yes"
                                         style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               self.game = [self createGame];
                                               [self resetUI];
                                           });
                                       }];

    [alertController addAction:noAction];
    [alertController addAction:yesAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if (self.modeSegmentedControl.enabled) {
        self.modeSegmentedControl.enabled = NO;
        NSInteger segmentIndex = self.modeSegmentedControl.selectedSegmentIndex;
        if (segmentIndex == 0) {
            self.game.cardsToMatch = 2;
        } else if (segmentIndex == 1) {
            self.game.cardsToMatch = 3;
        }
    }
    // Assumes that all buttons are inside cardButtons.
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardButtonIndex];
    [self updateUI];
}

#pragma mark - UI

- (void)resetUI
{
    self.modeSegmentedControl.enabled = YES;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.historyLabel.text = [self stringForLastMove];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

@end

//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Chrisna Aing on 10/25/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardGameHistoryViewController.h"
#import "CardMatchingGame.h"
#import "CardMatchingGameResult.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic, readwrite) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
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

#pragma mark - Abstract Utilities

- (Deck *)createDeck
{
    return nil;
}

- (CardMatchingGame *)createGame
{
    return nil;
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return nil;
}

- (NSAttributedString *)stringForCards:(NSArray *)cards
{
    return nil;
}

#pragma mark - Utilities

- (NSAttributedString *)stringForMoveAtIndex:(NSUInteger)index
{
    NSMutableAttributedString *moveString = [[NSMutableAttributedString alloc] init];
    if (index < [self.game.history count]) {
        CardMatchingGameResult *move = self.game.history[index];
        NSAttributedString *cards = [self stringForCards:move.cards];
        NSInteger score = move.matchScore;
        if (move.matchAttempted) {
            if (move.isMatched) {
                NSString *prefix = @"Matched ";
                [moveString appendAttributedString:[[NSAttributedString alloc] initWithString:prefix]];
                [moveString appendAttributedString:cards];
                NSString *suffix = [NSString stringWithFormat:@" for %ld point", (long)score];
                suffix = [suffix stringByAppendingString:score != 1 ? @"s." : @"."];
                [moveString appendAttributedString:[[NSAttributedString alloc] initWithString:suffix]];
            } else {
                [moveString appendAttributedString:cards];
                NSString *suffix = [NSString stringWithFormat:@" don't match! %ld point penalty!", (long)score];
                [moveString appendAttributedString:[[NSAttributedString alloc] initWithString:suffix]];
            }
        } else {
            [moveString appendAttributedString:cards];
        }
    }
    return moveString;
}

- (NSUInteger)maxHistoryIndex
{
    NSUInteger historyCount = [self.game.history count];
    return historyCount == 0 ? 0 : historyCount - 1;
}

#pragma mark - Game

- (void)createNewGame
{
    self.game = [self createGame];
    [self resetUI];
}

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
                                               [self createNewGame];
                                           });
                                       }];

    [alertController addAction:noAction];
    [alertController addAction:yesAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    // Assumes that all buttons are inside cardButtons.
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardButtonIndex];
    [self updateUI];
}

#pragma mark - UI

- (void)resetUI
{
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }

    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    self.historyLabel.attributedText = [self stringForMoveAtIndex:[self maxHistoryIndex]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showHistory"]) {
        CardGameHistoryViewController *cghvc = (CardGameHistoryViewController *)segue.destinationViewController;
        NSMutableAttributedString *history = [[NSMutableAttributedString alloc] init];
        for (NSUInteger i = 0; i <= [self maxHistoryIndex]; i++) {
            [history appendAttributedString:[self stringForMoveAtIndex:i]];
            [history appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
        [history addAttribute:NSFontAttributeName
                        value:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]
                        range:NSMakeRange(0, [history length])];
        cghvc.historyText = [[NSAttributedString alloc] initWithAttributedString:history];
    }
}

@end

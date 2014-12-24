//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Chrisna Aing on 10/25/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "CardMatchingGameResult.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
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

- (NSString *)stringForMoveAtIndex:(NSUInteger)index
{
    NSString *moveString;
    if (index < [self.game.history count]) {
        CardMatchingGameResult *move = self.game.history[index];
        NSString *cards = [self stringForCards:move.cards];
        NSInteger score = move.matchScore;
        if (move.matchAttempted) {
            if (move.isMatched) {
                moveString = [NSString stringWithFormat:@"Matched %@ for %ld point", cards, (long)score];
                moveString = [moveString stringByAppendingString:score != 1 ? @"s." : @"."];
            } else {
                moveString = [NSString stringWithFormat:@"%@ don't match! %ld point penalty!", cards, (long)score];
            }
        } else {
            moveString = cards;
        }
    }
    return moveString;
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
- (IBAction)slideThroughHistory:(UISlider *)sender {
    NSUInteger historyIndex = (NSUInteger)round(sender.value);
    self.historyLabel.text = [self stringForMoveAtIndex:historyIndex];
    self.historyLabel.alpha = historyIndex < (NSUInteger)round(sender.maximumValue) ? 0.5f : 1.0f;
}

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

    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];

    NSUInteger maxHistoryIndex = MAX(0, (NSInteger)[self.game.history count] - 1);
    NSLog(@"%lu", (long)maxHistoryIndex);
    self.historySlider.maximumValue = (float)maxHistoryIndex;
    self.historySlider.enabled = self.historySlider.minimumValue == self.historySlider.maximumValue ? NO : YES;
    [self.historySlider setValue:self.historySlider.maximumValue animated:YES];
    [self slideThroughHistory:self.historySlider];
}

@end

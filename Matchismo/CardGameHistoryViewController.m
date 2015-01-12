//
//  CardGameHistoryViewController.m
//  Matchismo
//
//  Created by Chrisna Aing on 1/11/15.
//  Copyright (c) 2015 Chrisna Aing. All rights reserved.
//

#import "CardGameHistoryViewController.h"

@interface CardGameHistoryViewController ()


@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation CardGameHistoryViewController

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.historyTextView.attributedText = self.historyText;
}

#pragma mark - Properties

- (NSAttributedString *)historyText
{
    if (!_historyText) {
        _historyText = [[NSAttributedString alloc] init];
    }
    return _historyText;
}

@end

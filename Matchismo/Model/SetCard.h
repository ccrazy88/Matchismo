//
//  SetCard.h
//  Matchismo
//
//  Created by Chrisna Aing on 12/28/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger shape;

+ (NSUInteger)countOfType;

@end

//
//  PhotoHuntGame.h
//  ToF Photo Hunt
//
//  Created by b.gay on 2/28/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoStack.h"
#import "ImagePlate.h"

@interface PhotoHuntGame : NSObject
@property (nonatomic, readonly) int levelScore;
@property (nonatomic, readonly) int gameScore;
@property (nonatomic, readonly) int level;

@property (nonatomic) bool hint1used;
@property (nonatomic) bool hint2used;
@property (nonatomic) bool hint3used;
@property (nonatomic, strong) NSMutableArray *imagePlates;

-(void)updateLevelScore;
-(id)initWithPhotoCount:(NSUInteger)count usingDeck:(PhotoStack *)stack;
-(ImagePlate *)currentImagePlate;
-(BOOL)nextLevel;
-(BOOL)finishedLevel;
-(Difference *)giveHint;
-(Difference *)touchedDifference:(CGPoint)tapLocation;
-(void)revealDifferences;


@end

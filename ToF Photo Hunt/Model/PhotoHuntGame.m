//
//  PhotoHuntGame.m
//  ToF Photo Hunt
//
//  Created by b.gay on 2/28/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import "PhotoHuntGame.h"

@interface PhotoHuntGame()
@property (nonatomic, readwrite) int levelScore;
@property (nonatomic, readwrite) int gameScore;
@property (nonatomic, readwrite) int level;
@property (nonatomic) int hintsLeft;

@end

@implementation PhotoHuntGame

-(NSMutableArray *)imagePlates
{
    if(!_imagePlates) _imagePlates = [[NSMutableArray alloc]init];
    return _imagePlates;
}

-(ImagePlate *)currentImagePlate
{
    return [self.imagePlates lastObject];
}

-(BOOL)nextLevel;
{
    [self.imagePlates removeLastObject];
    if ([self.imagePlates count]!=0) {
        self.gameScore+=self.levelScore;
        self.gameScore+=self.hintsLeft*1000;
        self.level++;
        self.levelScore =1000;
        return TRUE;
    }else{
        return FALSE;
    }
}

-(Difference *)touchedDifference:(CGPoint)tapLocation
{
    if ([[self currentImagePlate] touchedDifference:tapLocation]) {
        return [[self currentImagePlate] touchedDifference:tapLocation];
    }else{
        self.levelScore-=50;
        return nil;
    }
}

-(void)revealDifferences
{
    if (![self currentImagePlate].difference1.differenceFound) {
        [self currentImagePlate].difference1.differenceHinted = YES;
    }
    if (![self currentImagePlate].difference2.differenceFound) {
        [self currentImagePlate].difference2.differenceHinted = YES;
    }
    if (![self currentImagePlate].difference3.differenceFound) {
        [self currentImagePlate].difference3.differenceHinted = YES;
    }
    if (![self currentImagePlate].difference4.differenceFound) {
        [self currentImagePlate].difference4.differenceHinted = YES;
    }
    if (![self currentImagePlate].difference5.differenceFound) {
        [self currentImagePlate].difference5.differenceHinted = YES;
    }
}

-(BOOL)finishedLevel
{
    if (([self currentImagePlate].difference1.isDifferenceFound && [self currentImagePlate].difference2.isDifferenceFound
        && [self currentImagePlate].difference3.isDifferenceFound && [self currentImagePlate].difference4.isDifferenceFound
        && [self currentImagePlate].difference5.isDifferenceFound) ||(self.levelScore<1)) {
        return YES;
    }
    return NO;
}


-(id)initWithPhotoCount:(NSUInteger)count usingDeck:(PhotoStack *)stack
{
    self = [super init];
    
    if(self){
        for (int i=0; i<count; i++) {
            ImagePlate *imagePlate = [stack drawRandomImagePlate];
            if(!imagePlate){
                self = nil;
            }else{
                self.imagePlates[i]=imagePlate;
            }
            self.levelScore=1000;
            self.level =1;
            self.hintsLeft=3;
        }
        
    }
    return self;
}

-(Difference *)giveHint
{
    if (![self currentImagePlate].difference1.isDifferenceFound) {
        [self currentImagePlate].difference1.differenceFound=YES;
        [self currentImagePlate].difference1.differenceHinted=YES;
        self.hintsLeft--;
        return [self currentImagePlate].difference1;
    }
    if (![self currentImagePlate].difference2.isDifferenceFound) {
        [self currentImagePlate].difference2.differenceFound=YES;
        [self currentImagePlate].difference2.differenceHinted=YES;
        self.hintsLeft--;
        return [self currentImagePlate].difference2;
    }
    if (![self currentImagePlate].difference3.isDifferenceFound) {
        [self currentImagePlate].difference3.differenceFound=YES;
        [self currentImagePlate].difference3.differenceHinted=YES;
        self.hintsLeft--;
        return [self currentImagePlate].difference3;
    }
    if (![self currentImagePlate].difference4.isDifferenceFound) {
        [self currentImagePlate].difference4.differenceFound=YES;
        [self currentImagePlate].difference4.differenceHinted=YES;
        self.hintsLeft--;
        return [self currentImagePlate].difference4;
    }
    if (![self currentImagePlate].difference5.isDifferenceFound) {
        [self currentImagePlate].difference5.differenceFound=YES;
        [self currentImagePlate].difference5.differenceHinted=YES;
        self.hintsLeft--;
        return [self currentImagePlate].difference5;
    }
    return nil;
}

-(void)updateLevelScore
{
    self.levelScore-=1;
}


@end

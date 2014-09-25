//
//  StartScreenView.h
//  ToF Photo Hunt
//
//  Created by b.gay on 3/2/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartScreenView : UIView
@property (nonatomic) BOOL faceUp;
@property (nonatomic, strong) NSMutableArray *highscores;

-(BOOL)tapNewGame:(CGPoint)tapLocation;
-(void)setNewGame;

@end

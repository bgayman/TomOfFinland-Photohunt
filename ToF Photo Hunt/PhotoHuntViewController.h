//
//  PhotoHuntViewController.h
//  ToF Photo Hunt
//
//  Created by b.gay on 2/28/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoStack.h"
#import "NewHighScoreViewController.h"


@interface PhotoHuntViewController : UIViewController <ScoreModalViewControllerDelegate>
@property (nonatomic,strong) NSMutableArray *highscores;
-(PhotoStack *)createStack;
-(void)popSelfWithDelay;


@end

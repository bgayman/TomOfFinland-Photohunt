//
//  NewHighScoreViewController.h
//  ToF Photo Hunt
//
//  Created by b.gay on 4/13/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ScoreModalViewControllerDelegate;

@interface NewHighScoreViewController : UIViewController <UITextFieldDelegate>
{
    id<ScoreModalViewControllerDelegate>delegate;
}
@property (nonatomic, assign) id<ScoreModalViewControllerDelegate> _delegate;
@property (nonatomic, strong) NSString *gameScore;
@property (nonatomic, strong) NSNumber *index;



@end


@protocol ScoreModalViewControllerDelegate
- (void)scoreModalViewControllerFinished:(NewHighScoreViewController*)scoreModalViewController;
@end
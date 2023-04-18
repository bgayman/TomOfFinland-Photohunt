//
//  StartScreenViewController.m
//  ToF Photo Hunt
//
//  Created by b.gay on 3/2/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import "StartScreenViewController.h"
#import "StartScreenView.h"
#import "PhotoHuntViewController.h"

@interface StartScreenViewController ()

@property (weak, nonatomic) IBOutlet UIButton *gameButton;
@property (weak, nonatomic) IBOutlet StartScreenView *startScreenView;
@end

@implementation StartScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Seamless Leather Pattern.png"]]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateView)
                                                 name:NSUserDefaultsDidChangeNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateView];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)updateView
{
    //[self.startScreenView setNewGame];
    [self.startScreenView setNeedsDisplay];
}

- (IBAction)tapInView:(UITapGestureRecognizer *)sender
{
    CGPoint tapLocation = [sender locationInView:self.startScreenView];
    if ([self.startScreenView tapNewGame:tapLocation]) {
        [self performSegueWithIdentifier:@"ShowGame" sender:self];
    }else{
        
        
        [UIView transitionWithView:self.startScreenView duration:0.40 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.gameButton.hidden=!self.gameButton.hidden;
            self.startScreenView.faceUp = !self.startScreenView.faceUp;
        }
                        completion:NULL];
    }
}

/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowGame"]) {
        if ([segue.destinationViewController isKindOfClass:[PhotoHuntViewController class]]) {
            PhotoHuntViewController *photoHuntViewController = (PhotoHuntViewController *)segue.destinationViewController;
            if (self.startScreenView.highscores) {
                photoHuntViewController.highscores=self.startScreenView.highscores;
            }else{
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                if([defaults objectForKey:@"highScore"]){
                    NSMutableArray *highscores = [[NSMutableArray alloc]initWithArray:[defaults arrayForKey:@"highScore"]];
                    photoHuntViewController.highscores=highscores;
                }
            }
        }
    }
}*/

@end

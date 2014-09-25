//
//  NewHighScoreViewController.m
//  ToF Photo Hunt
//
//  Created by b.gay on 4/13/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import "NewHighScoreViewController.h"
#import "NewScoreView.h"
#import "PhotoHuntViewController.h"

@interface NewHighScoreViewController ()

@property (weak, nonatomic) IBOutlet NewScoreView *scoreView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation NewHighScoreViewController

// Call this method when the modal view is finished
- (void)dismissSelf
{
    [delegate scoreModalViewControllerFinished:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scoreView.gameScore = self.gameScore;
    self._delegate = (PhotoHuntViewController *)self.presentingViewController;
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Seamless Leather Pattern.png"]]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    [self.navBar setItems:@[self.navigationItem]];
    UIFont *scoreFont = [UIFont fontWithName:@"Arial-BoldMT" size:23.0];
    NSMutableDictionary *sAttribs =[[NSMutableDictionary alloc]initWithObjectsAndKeys:scoreFont,UITextAttributeFont, [UIColor lightTextColor],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(1.0, -1.1)],UITextAttributeTextShadowOffset,[UIColor colorWithWhite:0.0 alpha:.75],UITextAttributeTextColor, nil];
    
    [self.navBar setTitleTextAttributes:sAttribs];
    self.navBar.topItem.title = @"HIGH SCORE";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self done];
    return YES;
}

-(void)done
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *names = [[NSMutableArray alloc]init];
    
    if([[defaults objectForKey:@"names"] isKindOfClass:[NSMutableArray class]]){
        names = [NSMutableArray arrayWithArray:[defaults objectForKey:@"names"]];
        
            if ([names count]==0) {
                [names addObject:self.scoreView.playerName.text];
            }else{
                [names insertObject:self.scoreView.playerName.text atIndex:[self.index integerValue]];
            }
        
        
    }else{
        
        [names addObject:self.scoreView.playerName.text];
    }
    [defaults setObject:names forKey:@"names"];
    [self dismissSelf];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    
    return NO;
}

-(void) setup:(NSArray *)array
{
    self.index = array[0];
    self.gameScore = [NSString stringWithFormat:@"%d",[array[1] integerValue]];
    NSLog(@"Game Score: %@",[NSString stringWithFormat:@"%d",[array[1] integerValue]]);
    [self.scoreView setGameScore:[NSString stringWithFormat:@"%d",[array[1] integerValue]]];
    [self.scoreView setNeedsDisplay];
}

-(void) setIndex:(NSNumber *)index
{
    _index = index;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScoreView:nil];
    [self setNavBar:nil];
    [super viewDidUnload];
}
@end

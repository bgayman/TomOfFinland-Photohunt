//
//  PhotoHuntViewController.m
//  ToF Photo Hunt
//
//  Created by b.gay on 2/28/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import "PhotoHuntViewController.h"
#import "PhotoHuntGame.h"
#import "ImagePlateView.h"
#import "Difference.h"

@interface PhotoHuntViewController () 
@property (strong, nonatomic) PhotoHuntGame *game;
@property (strong, nonatomic) PhotoStack *photoStack;
@property (weak, nonatomic) IBOutlet ImagePlateView *imagePlateA;
@property (weak, nonatomic) IBOutlet ImagePlateView *imagePlateB;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *huntButtons;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UILabel *levelScoreLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UILabel *gameScoreLabel;
@property (weak, nonatomic) IBOutlet UIStackView *imagePlateStackView;


@end

@implementation PhotoHuntViewController

#define TIMER_INTERVAL 0.12

-(PhotoStack *)createStack{
    self.photoStack = nil;
    return self.photoStack;
}

-(NSTimer *)timer
{
    if(!_timer) _timer = [[NSTimer alloc]init];
    return _timer;
}

-(NSMutableArray *)highscores
{
    if(!_highscores) _highscores = [[NSMutableArray alloc]init];
    return _highscores;
}

-(PhotoStack*) photoStack
{
    if(!_photoStack){
        _photoStack = [[PhotoStack alloc]init];
    }
    return _photoStack;
}

-(PhotoHuntGame *)game
{
    if (!_game) {
        _game = [[PhotoHuntGame alloc] initWithPhotoCount:30 usingDeck:[self createStack]];
    }
    return _game;
}

-(void)scoreModalViewControllerFinished:(NewHighScoreViewController *)scoreModalViewController
{
    NSLog(@"Score Modal View Controller Finished");
    [self popSelfWithDelay];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imagePlateStackView.axis = self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact ? UILayoutConstraintAxisVertical : UILayoutConstraintAxisHorizontal;
    
    [self setNeedsStatusBarAppearanceUpdate];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Seamless Leather Pattern.png"]]];
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateNormal];
    [self loadCurrentImage];
    self.levelScoreLabel.text = [NSString stringWithFormat:@"%d",self.game.levelScore];
    [self.pauseButton setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateSelected];
    [self.pauseButton setImage:[UIImage imageNamed:@"pauseButton.png"] forState:UIControlStateNormal];
    self.pauseButton.selected=YES;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.imagePlateA.layer.shadowOffset = CGSizeMake(2.0, 5.0);
    self.imagePlateA.layer.shadowRadius = 5;
    self.imagePlateA.layer.shadowOpacity = 0.5;
    self.imagePlateA.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imagePlateA.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.imagePlateA.bounds].CGPath;
    self.imagePlateB.layer.shadowOffset = CGSizeMake(2.0, 5.0);
    self.imagePlateB.layer.shadowRadius = 5;
    self.imagePlateB.layer.shadowOpacity = 0.5;
    self.imagePlateB.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imagePlateB.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.imagePlateB.bounds].CGPath;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)updateDifferences
{
    self.imagePlateA.difference1.differenceFound = [self.game currentImagePlate].difference1.differenceFound;
    self.imagePlateA.difference2.differenceFound = [self.game currentImagePlate].difference2.differenceFound;
    self.imagePlateA.difference3.differenceFound = [self.game currentImagePlate].difference3.differenceFound;
    self.imagePlateA.difference4.differenceFound = [self.game currentImagePlate].difference4.differenceFound;
    self.imagePlateA.difference5.differenceFound = [self.game currentImagePlate].difference5.differenceFound;
    
    self.imagePlateB.difference1.differenceFound = [self.game currentImagePlate].difference1.differenceFound;
    self.imagePlateB.difference2.differenceFound = [self.game currentImagePlate].difference2.differenceFound;
    self.imagePlateB.difference3.differenceFound = [self.game currentImagePlate].difference3.differenceFound;
    self.imagePlateB.difference4.differenceFound = [self.game currentImagePlate].difference4.differenceFound;
    self.imagePlateB.difference5.differenceFound = [self.game currentImagePlate].difference5.differenceFound;
    [self.imagePlateA setNeedsDisplay];
    [self.imagePlateB setNeedsDisplay];
}

-(void)scoreAnimation
{
    NSLog(@"Score Animation");
    UILabel *thousand = [[UILabel alloc]initWithFrame:CGRectMake(761, 642,132, 41)];
    thousand.text = @"+1000";
    thousand.textAlignment = NSTextAlignmentCenter;
    thousand.opaque = NO;
    thousand.font=[UIFont fontWithName:@"Arial-BoldMT" size:18.0];
    thousand.textColor = [UIColor whiteColor];
    thousand.backgroundColor = [UIColor clearColor];
    
    UILabel *thousand1 = [[UILabel alloc]initWithFrame:CGRectMake(761+68, 642,132, 41)];
    thousand1.text = @"+1000";
    thousand1.textAlignment = NSTextAlignmentCenter;
    thousand1.opaque = NO;
    thousand1.font=[UIFont fontWithName:@"Arial-BoldMT" size:18.0];
    thousand1.textColor = [UIColor whiteColor];
    thousand1.backgroundColor = [UIColor clearColor];
    
    UILabel *thousand2 = [[UILabel alloc]initWithFrame:CGRectMake(761+68*2, 642,132, 41)];
    thousand2.text = @"+1000";
    thousand2.textAlignment = NSTextAlignmentCenter;
    thousand2.opaque = NO;
    thousand2.font=[UIFont fontWithName:@"Arial-BoldMT" size:18.0];
    thousand2.textColor = [UIColor whiteColor];
    thousand2.backgroundColor = [UIColor clearColor];

    //thousand.frame = CGRectMake(839-thousand.bounds.size.width/2.0, 683+30-thousand.bounds.size.height/2.0, thousand.bounds.size.width, thousand.bounds.size.width);
    UIButton *button = [[UIButton alloc] init];
    button = [self.huntButtons objectAtIndex:0];
    UIButton *button1 = [[UIButton alloc] init];
    button1 = [self.huntButtons objectAtIndex:1];
    UIButton *button2 = [[UIButton alloc] init];
    button2 = [self.huntButtons objectAtIndex:2];
    
    
    
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8];
        if (button.alpha == 1.0) {
            NSLog(@"Button1");
            thousand.center = CGPointMake(button.center.x, 642.0+18.0);
            [self.view addSubview:thousand];
            thousand.center =CGPointMake (thousand.center.x,thousand.center.y-25);
            thousand.alpha = 0.2;

        }
        
        if (button1.alpha == 1.0) {
            NSLog(@"Button2");
            thousand1.center = CGPointMake(button1.center.x, 642.0+18.0);
            [self.view addSubview:thousand1];
            thousand1.center =CGPointMake (thousand1.center.x,thousand1.center.y-25);
            thousand1.alpha = 0.2;
        }
        
        if (button2.alpha == 1.0) {
            NSLog(@"Button3");
            thousand2.center = CGPointMake(button2.center.x, 642.0+18.0);
            [self.view addSubview:thousand2];
            thousand2.center =CGPointMake (thousand2.center.x,thousand2.center.y-25);
            thousand2.alpha = 0.2;

        }
    [UIView commitAnimations];
    NSLog(@"%@",[thousand description]);
    NSLog(@"%@",[thousand1 description]);
    NSLog(@"%@",[thousand2 description]);
    [thousand performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.9];
    [thousand1 performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.9];
    [thousand2 performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.9];


}

-(void)startLevel
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(countdown) userInfo:nil repeats:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"NewScore"]){
    
        [segue.destinationViewController performSelector:@selector(setup:)withObject:@[sender,@(self.game.gameScore)]];
    }
}

-(void)modalView:(id)sender
{
    [self performSegueWithIdentifier:@"NewScore" sender:sender];
    [self popSelf];
}

-(void) countdown
{
    [self.game updateLevelScore];
    self.levelScoreLabel.text = [NSString stringWithFormat:@"%d",self.game.levelScore];
    self.timeSlider.value = (float)self.game.levelScore;
    if ([self.game finishedLevel] && self.game.levelScore<1) {
        NSLog(@"invalidating timer countdown");
        [self.timer invalidate];
        //[self flipImagePlate];
        [self.game revealDifferences];
        NSLog(@"Here1");
        [self.imagePlateA setNeedsDisplay];
        NSLog(@"Here2");
        [self.imagePlateB setNeedsDisplay];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *highscores = [[NSMutableArray alloc]init];
        if([[defaults objectForKey:@"highScore"] isKindOfClass:[NSMutableArray class]]){
            highscores = [NSMutableArray arrayWithArray:[defaults objectForKey:@"highScore"]];
            NSLog(@"%d",self.game.gameScore);
            if (!(self.game.gameScore>[[highscores lastObject]integerValue])) {
                [highscores addObject:[NSString stringWithFormat:@"%d",self.game.gameScore]];
                if ([highscores count]-1<8) {
                    [self performSelector:@selector(modalView:) withObject:@([highscores count]-1) afterDelay:2.5];
                }else{
                    [self performSelector:@selector(popSelf) withObject:nil afterDelay:2.5];
                }
            }else{
                
                for (int i=0; i<[highscores count]; i++) {
                    if (self.game.gameScore>[highscores[i] integerValue]) {
                        [highscores insertObject:[NSString stringWithFormat:@"%d",self.game.gameScore] atIndex:i];
                        if (i==0) {
                            self.gameScoreLabel.text = [NSString stringWithFormat:@"NEW HIGH SCORE: %d",self.game.gameScore];
                        }
                        if (i<8) {
                            [self performSelector:@selector(modalView:) withObject:@(i) afterDelay:2.5];
                        }else{
                            [self performSelector:@selector(popSelf) withObject:nil afterDelay:2.5];
                        }
                        break;
                    }
                }
                if ([highscores count]==0) {
                    [highscores addObject:[NSString stringWithFormat:@"%d",self.game.gameScore]];
                    self.gameScoreLabel.text = [NSString stringWithFormat:@"NEW HIGH SCORE: %d",self.game.gameScore];
                    [self performSelector:@selector(modalView:) withObject:@(0) afterDelay:2.5];
                }
            }
            
            
        }else{
            
            [highscores addObject:[NSString stringWithFormat:@"%d",self.game.gameScore]];
            [self performSelector:@selector(modalView:) withObject:@(0) afterDelay:2.5];
        }
		[defaults setObject:highscores forKey:@"highScore"];
        
        //push gameover view controller
    }else if([self.game finishedLevel] && self.game.levelScore>1){
        [self.timer invalidate];
        [self scoreAnimation];
        
        self.levelScoreLabel.textColor = [UIColor yellowColor];
        [self performSelector:@selector(nextLevel) withObject:nil afterDelay:1.5];
    }
}

-(void) popSelfWithDelay
{
    [self performSelector:@selector(popSelf) withObject:nil afterDelay:2.5];
}

-(void)popSelf
{
    self.game = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updateLabels
{
    self.levelScoreLabel.text = [NSString stringWithFormat:@"%d",self.game.levelScore];
    self.timeSlider.value = self.game.levelScore;
}

-(void)flipImagePlate
{
    [UIView transitionWithView:self.imagePlateA duration:0.40 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        self.imagePlateA.faceUp = !self.imagePlateA.faceUp;
    }
                    completion:NULL];
    [UIView transitionWithView:self.imagePlateB duration:0.40 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        self.imagePlateB.faceUp = !self.imagePlateB.faceUp;
    }
                    completion:NULL];
}

- (IBAction)tapInImageA:(UITapGestureRecognizer *)gesture {
    if (!self.imagePlateA.faceUp) {
        [self flipImagePlate];
        self.pauseButton.selected=!self.pauseButton.selected;
        [self startLevel];
    }else{
        CGPoint tapLocation = [self applyScale:[gesture locationInView:self.imagePlateA]];
        //NSLog(@"%f %f",tapLocation.x,tapLocation.y);
        if ([self.game touchedDifference:tapLocation]){
            [self.imagePlateA setNeedsDisplayInRect:[self.imagePlateA applyScale:CGRectInset([self.game touchedDifference:tapLocation].differenceRect,-2.0,-2.0)]];
            [self.imagePlateB setNeedsDisplayInRect:[self.imagePlateB applyScale:CGRectInset([self.game touchedDifference:tapLocation].differenceRect,-2.0,-2.0)]];
            if ([self.game finishedLevel]) {
                [self.timer invalidate];
                [self scoreAnimation];
                self.levelScoreLabel.textColor = [UIColor yellowColor];
                [self performSelector:@selector(nextLevel) withObject:nil afterDelay:1.0];
            }
        }else{
            [self updateLabels];
        }
    }
    
}


- (IBAction)tapInImageB:(UITapGestureRecognizer *)gesture {
    if (!self.imagePlateB.faceUp) {
        [self flipImagePlate];
        self.pauseButton.selected=!self.pauseButton.selected;
        [self startLevel];
    }else{
        CGPoint tapLocation = [self applyScale:[gesture locationInView:self.imagePlateB]];
        if ([self.game touchedDifference:tapLocation]){
            [self.imagePlateA setNeedsDisplayInRect:[self.imagePlateA applyScale:CGRectInset([self.game touchedDifference:tapLocation].differenceRect,-2.0,-2.0)]];
            [self.imagePlateB setNeedsDisplayInRect:[self.imagePlateB applyScale:CGRectInset([self.game touchedDifference:tapLocation].differenceRect,-2.0,-2.0)]];
            if ([self.game finishedLevel]) {
                [self.timer invalidate];
                [self scoreAnimation];
                self.levelScoreLabel.textColor = [UIColor yellowColor];
                [self performSelector:@selector(nextLevel) withObject:nil afterDelay:1.0];
            }
        }else{
            [self updateLabels];
        }
    }
}

- (CGPoint)applyScale:(CGPoint)point {
    CGFloat xScale = 500.0 / self.imagePlateA.bounds.size.width * point.x;
    CGFloat yScale = 600.0 / self.imagePlateA.bounds.size.height * point.y;
    return CGPointMake(xScale, yScale);
}

- (IBAction)hintTapped:(UIButton *)sender {
    if (self.imagePlateA.faceUp) {
        Difference *hint = [[Difference alloc] init];
        hint = [self.game giveHint];
        if (hint) {
            sender.enabled = NO;
            sender.alpha = 0.7;
            [self.imagePlateA setNeedsDisplayInRect:[self.imagePlateA applyScale:CGRectInset(hint.differenceRect,-2.0,-2.0)]];
            [self.imagePlateB setNeedsDisplayInRect:[self.imagePlateB applyScale:CGRectInset(hint.differenceRect,-2.0,-2.0)]];
        }
    }
}

- (IBAction)pausePressed:(UIButton *)sender {
    
    if(self.imagePlateA.faceUp){
        [self flipImagePlate];
        NSLog(@"invalidating timer pause");

        [self.timer invalidate];
        //present modal viewer
    }else if (!self.imagePlateA.faceUp) {
        [self flipImagePlate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    }
    self.pauseButton.selected =!self.pauseButton.selected;
}

-(void)loadCurrentImage
{
    self.imagePlateA.image = [self.game currentImagePlate].imageA;
    self.imagePlateA.difference1 = [self.game currentImagePlate].difference1;
    self.imagePlateA.difference2 = [self.game currentImagePlate].difference2;
    self.imagePlateA.difference3 = [self.game currentImagePlate].difference3;
    self.imagePlateA.difference4 = [self.game currentImagePlate].difference4;
    self.imagePlateA.difference5 = [self.game currentImagePlate].difference5;
    self.imagePlateB.image = [self.game currentImagePlate].imageB;
    self.imagePlateB.difference1 = [self.game currentImagePlate].difference1;
    self.imagePlateB.difference2 = [self.game currentImagePlate].difference2;
    self.imagePlateB.difference3 = [self.game currentImagePlate].difference3;
    self.imagePlateB.difference4 = [self.game currentImagePlate].difference4;
    self.imagePlateB.difference5 = [self.game currentImagePlate].difference5;
}

-(void)nextLevel
{
    if ([self.game nextLevel]) {
        NSLog(@"nextLevel");
        [self flipImagePlate];
        [self loadCurrentImage];
        
        self.pauseButton.selected=YES;
        self.levelLabel.text = [NSString stringWithFormat:@"ROUND: %d of 30",self.game.level];
        self.levelScoreLabel.text = [NSString stringWithFormat:@"%d",self.game.levelScore];
        self.gameScoreLabel.text = [NSString stringWithFormat:@"%d",self.game.gameScore];
        self.timeSlider.value = self.game.levelScore;
        self.levelScoreLabel.textColor = [UIColor whiteColor];
        
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *highscores = [[NSMutableArray alloc]init];
        if([[defaults objectForKey:@"highScore"] isKindOfClass:[NSMutableArray class]]){
            highscores = [NSMutableArray arrayWithArray:[defaults objectForKey:@"highScore"]];
            NSLog(@"%d",self.game.gameScore);
            if (!(self.game.gameScore>[[highscores lastObject]integerValue])) {
                [highscores addObject:[NSString stringWithFormat:@"%d",self.game.gameScore]];
                if ([highscores count]-1<8) {
                    [self performSelector:@selector(modalView:) withObject:@([highscores count]-1) afterDelay:2.5];
                }else{
                    [self performSelector:@selector(popSelf) withObject:nil afterDelay:2.5];
                }
            }else{
                
                for (int i=0; i<[highscores count]; i++) {
                    if (self.game.gameScore>[highscores[i] integerValue]) {
                        [highscores insertObject:[NSString stringWithFormat:@"%d",self.game.gameScore] atIndex:i];
                        if (i==0) {
                            self.gameScoreLabel.text = [NSString stringWithFormat:@"NEW HIGH SCORE: %d",self.game.gameScore];
                        }
                        if (i<8) {
                            [self performSelector:@selector(modalView:) withObject:@(i) afterDelay:2.5];
                        }else{
                            [self performSelector:@selector(popSelf) withObject:nil afterDelay:2.5];
                        }
                        break;
                    }
                }
                if ([highscores count]==0) {
                    [highscores addObject:[NSString stringWithFormat:@"%d",self.game.gameScore]];
                    self.gameScoreLabel.text = [NSString stringWithFormat:@"NEW HIGH SCORE: %d",self.game.gameScore];
                    [self performSelector:@selector(modalView:) withObject:@(0) afterDelay:2.5];
                }
            }
            
            
        }else{
            
            [highscores addObject:[NSString stringWithFormat:@"%d",self.game.gameScore]];
            [self performSelector:@selector(modalView:) withObject:@(0) afterDelay:2.5];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

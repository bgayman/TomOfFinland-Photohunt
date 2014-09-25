//
//  NewScoreView.m
//  ToF Photo Hunt
//
//  Created by b.gay on 4/13/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import "NewScoreView.h"
#import "NewHighScoreViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation NewScoreView

#define ROUND_RECT_CORNER_RADIUS 12.0
#define IMAGE_INSET 10.0
#define INSET 10.0
#define STROKE_LINE_WIDTH 3.0
#define STROKE_FOUND 4.0
#define BLEND_MODE kCGBlendModeDarken
#define SCOREBOARD_FONT 0.030


-(void)setup
{
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = ROUND_RECT_CORNER_RADIUS; // if you like rounded corners
    self.layer.shadowOffset = CGSizeMake(2.0, 5.0);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    NSString *gameScore = [[NSString alloc]init];
    self.gameScore = gameScore;
}

-(void)awakeFromNib
{
    [self setup];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}


- (void)drawRect:(CGRect)rect
{
    NSLog(@"ScoreView Game Score %@",self.gameScore);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:ROUND_RECT_CORNER_RADIUS];
    [roundedRect addClip];
    
    [[UIColor colorWithPatternImage:[UIImage imageNamed:@"paper.png"]] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    CGRect imageRect = CGRectInset(self.bounds,
                                   IMAGE_INSET,
                                   IMAGE_INSET);
    UIBezierPath *roundedRectImage = [UIBezierPath bezierPathWithRoundedRect:imageRect
                                                                cornerRadius:ROUND_RECT_CORNER_RADIUS];
    
    [[UIColor blackColor] setStroke];
    roundedRectImage.lineWidth = STROKE_LINE_WIDTH;
    [roundedRectImage stroke];
    
    [roundedRectImage addClip];
    
    [[UIImage imageNamed:@"newScoreImage.png"] drawInRect:imageRect blendMode:BLEND_MODE alpha:1.0];
    
    UIFont *playerNameFont = [UIFont fontWithName:@"Arial-BoldMT" size:self.bounds.size.height * .025];
    
    UITextField *playerName = [[UITextField alloc]initWithFrame:CGRectMake(self.bounds.size.width*.5-self.bounds.size.width*.12, self.bounds.size.height*.08, self.bounds.size.width*.25, self.bounds.size.height*.03)];
    self.playerName = playerName;
    self.playerName.placeholder = @"PLAYER'S NAME";
    self.playerName.clearsOnBeginEditing = YES;
    //self.searchField.text = @"Search";
    //[self.searchField becomeFirstResponder];
    self.playerName.opaque = NO;
    self.playerName.textAlignment = NSTextAlignmentCenter;
    self.playerName.backgroundColor = [UIColor clearColor];
    self.playerName.font = playerNameFont;
    self.playerName.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    [self.playerName setAutocorrectionType:UITextAutocorrectionTypeNo];
    self.playerName.returnKeyType = UIReturnKeyDone;
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[NewHighScoreViewController class]])
        {
            self.playerName.delegate = (NewHighScoreViewController *)nextResponder;
        }
    }
    //self.searchField.delegate = [self superview];
    [self addSubview:self.playerName];
    
    UIFont *scoreBoardFont = [UIFont fontWithName:@"Arial-BoldMT" size:self.bounds.size.height *SCOREBOARD_FONT];
    [[UIColor blackColor]setFill];
    CGSize newHighScoreSize = [@"HIGH SCORE" sizeWithFont:scoreBoardFont];
    CGPoint newHighScorePoint = CGPointMake(self.bounds.size.width*.5-newHighScoreSize.width*.36, self.bounds.size.height*.75-newHighScoreSize.height*.5);
    [@"HIGH SCORE" drawAtPoint:newHighScorePoint withFont:scoreBoardFont];
    
    UIImage *badge = [UIImage imageNamed:@"photoHuntBadge.png"];
    CGRect badgeRect = CGRectMake(self.bounds.size.width*.5-newHighScoreSize.width*.36+newHighScoreSize.width*.5 - badge.size.width/2.0, self.bounds.size.height*.75+newHighScoreSize.height*.5+2.0, badge.size.width, badge.size.height);
    [badge drawInRect:badgeRect blendMode:BLEND_MODE alpha:1.0];
    
    UIFont *scoreFont = [UIFont fontWithName:@"Arial-BoldMT" size:self.bounds.size.height *.05];
    CGSize scoreSize = [self.gameScore sizeWithFont:scoreFont];
    CGPoint scorePoint = CGPointMake(self.bounds.size.width*.5-newHighScoreSize.width*.36+newHighScoreSize.width*.5 - scoreSize.width*.5, self.bounds.size.height*.75+newHighScoreSize.height*.5+2.0+badgeRect.size.height+2.0);
    [self.gameScore drawAtPoint:scorePoint withFont:scoreFont];
    
    UIBezierPath *playerNameRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.playerName.frame,-3.0,-3.0) cornerRadius:5.0];
    
    
    
    [playerNameRect addClip];
    [[UIColor colorWithPatternImage:[UIImage imageNamed:@"paper.png"]] setFill];
    UIRectFill(self.playerName.frame);
    playerNameRect.lineWidth = 2.0;
    [playerNameRect stroke];
}

-(void) setGameScore:(NSString *)gameScore
{
    _gameScore = gameScore;
    [self setNeedsDisplay];
}

@end

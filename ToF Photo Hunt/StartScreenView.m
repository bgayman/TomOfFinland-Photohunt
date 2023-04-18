//
//  StartScreenView.m
//  ToF Photo Hunt
//
//  Created by b.gay on 3/2/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import "StartScreenView.h"
#import <QuartzCore/QuartzCore.h>

@implementation StartScreenView
#define ROUND_RECT_CORNER_RADIUS 12.0
#define INSET 10.0
#define STROKE 2.0
#define SCOREBOARD_FONT 0.045
#define BLEND_MODE kCGBlendModeDarken


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:ROUND_RECT_CORNER_RADIUS];
    [roundedRect addClip];
    
    [[UIColor colorWithPatternImage:[UIImage imageNamed:@"paper.png"]] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if (!self.faceUp) {
        
        
        CGRect scoreboardRect = CGRectMake(0.0, 0.0, self.bounds.size.width/2.0, self.bounds.size.height*2.0/3.0);
        scoreboardRect = CGRectInset(scoreboardRect, INSET, INSET);
        UIBezierPath *scoreboardRoundedRect = [UIBezierPath bezierPathWithRoundedRect:scoreboardRect
                                                               cornerRadius:ROUND_RECT_CORNER_RADIUS];
        scoreboardRoundedRect.lineWidth = STROKE;
        [scoreboardRoundedRect stroke];
        UIImage *badge = [UIImage imageNamed:@"photoHuntBadge.png"];
        CGRect badgeRect = CGRectMake(self.bounds.size.width/4.0 - badge.size.width/2.0, INSET+2.0, badge.size.width, badge.size.height);
        [badge drawInRect:badgeRect blendMode:BLEND_MODE alpha:1.0];
        CGPoint middle = CGPointMake(self.bounds.size.width/4.0, INSET+14.0+badge.size.height);
        UIFont *scoreboardFont = [UIFont fontWithName:@"Arial-BoldMT" size:self.bounds.size.height * SCOREBOARD_FONT];
        NSString *highscore = @"HIGH SCORES";
        [[UIColor blackColor] setFill];
        CGSize highscoreSize = [highscore sizeWithFont:scoreboardFont];
        CGPoint highScorePoint = CGPointMake(middle.x-highscoreSize.width/2.0, middle.y+10.0-highscoreSize.height*4.0/5.0);
        
        [highscore drawAtPoint:highScorePoint withFont:scoreboardFont];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([[defaults objectForKey:@"highScore"] isKindOfClass:[NSMutableArray class]]){
            NSMutableArray *highscores = [[NSMutableArray alloc]initWithArray:[defaults arrayForKey:@"highScore"]];
            NSMutableArray *names = [[NSMutableArray alloc]initWithArray:[defaults arrayForKey:@"names"]];
            if ([highscores count]>0 && [names count]>0) {
                for (int i=0; i<[names count]; i++) {
                    if ([names objectAtIndex:i] && i<8) {
                        NSString *name = [[NSString alloc] initWithString:[names objectAtIndex:i]];
                       NSString *score = [[NSString alloc] initWithString:[highscores objectAtIndex:i]];
                        CGSize scoreSize = [score sizeWithFont:scoreboardFont];
                        //CGSize nameSize = [name sizeWithFont:scoreboardFont];
                        CGPoint scorePoint = CGPointMake(self.bounds.size.width/2.0-scoreSize.width-self.bounds.size.width*0.05, middle.y+18.0+(scoreSize.height+2.0)*i);
                        CGPoint namePoint = CGPointMake(self.bounds.size.width*0.07, middle.y+18.0+(scoreSize.height+2.0)*i);
                        [score drawAtPoint:scorePoint withFont:scoreboardFont];
                        [name drawAtPoint:namePoint withFont:scoreboardFont];
                    }
                }
            }
        
        }
        CGRect newGameRect = CGRectMake(0.0, self.bounds.size.height*2.0/3.0-10.0, self.bounds.size.width, self.bounds.size.height/3.0 + 10.0);
        newGameRect = CGRectInset(newGameRect, INSET, INSET);
        UIBezierPath *newGameRoundedRect = [UIBezierPath bezierPathWithRoundedRect:newGameRect
                                                                         cornerRadius:ROUND_RECT_CORNER_RADIUS];
        newGameRoundedRect.lineWidth =STROKE;
        [newGameRoundedRect stroke];
        UIImage *signature = [UIImage imageNamed:@"signature.png"];
        CGRect signatureRect = CGRectMake(self.bounds.size.width/2.0-signature.size.width/2.0+10.0, self.bounds.size.height*5.0/6.0-signature.size.height/2.0-25.0, signature.size.width, signature.size.height);
        if (self.traitCollection.horizontalSizeClass != UIUserInterfaceSizeClassCompact) {
            [signature drawInRect:signatureRect blendMode:BLEND_MODE alpha:1.0];
        }
        //CGPoint mid = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height*5.0/6.0+signature.size.height/2.0-20.0);
        //UIFont *newGameFont = [UIFont fontWithName:@"Arial-BoldMT" size:self.bounds.size.height * SCOREBOARD_FONT];
        //NSAttributedString *newGame = [[NSAttributedString alloc] initWithString:@"NEW GAME" attributes:@{ NSFontAttributeName : newGameFont }];
        //CGPoint gamePoint = CGPointMake(mid.x-newGame.size.width/2.0, mid.y-25.0);
        //[newGame drawAtPoint:gamePoint];

        
        CGRect imageRect = CGRectMake(self.bounds.size.width/2.0-5.0, 0.0,self.bounds.size.width/2.0+5.0, self.bounds.size.height*2.0/3.0);
        imageRect = CGRectInset(imageRect, INSET, INSET);
        UIBezierPath *imageRoundedRect = [UIBezierPath bezierPathWithRoundedRect:imageRect
                                                                      cornerRadius:ROUND_RECT_CORNER_RADIUS];
        imageRoundedRect.lineWidth = STROKE;
        [imageRoundedRect stroke];
        CGRect imageRect2 = CGRectInset(imageRect, 1.0, 1.0);
        UIBezierPath *imageRoundedRect2 = [UIBezierPath bezierPathWithRoundedRect:imageRect2
                                                                    cornerRadius:ROUND_RECT_CORNER_RADIUS];
        [imageRoundedRect2 addClip];
        imageRect = CGRectInset(imageRect, -2.0, -2.0);
        [[UIImage imageNamed:@"startScreenImage.png"] drawInRect:imageRect blendMode:BLEND_MODE alpha:1.0];
    }else{
        CGRect imageRect = CGRectInset(self.bounds,
                                       INSET,
                                       INSET);
        UIBezierPath *roundedRectImage = [UIBezierPath bezierPathWithRoundedRect:imageRect
                                                                    cornerRadius:ROUND_RECT_CORNER_RADIUS];
        
        [[UIColor blackColor] setStroke];
        roundedRectImage.lineWidth = STROKE;
        [roundedRectImage stroke];
        CGRect imageRect2 = CGRectInset(imageRect, 1.0, 1.0);
        UIBezierPath *imageRoundedRect2 = [UIBezierPath bezierPathWithRoundedRect:imageRect2
                                                                     cornerRadius:ROUND_RECT_CORNER_RADIUS];
        [imageRoundedRect2 addClip];
        
        [[UIImage imageNamed:@"startScreenBack.png"] drawInRect:imageRect blendMode:BLEND_MODE alpha:1.0];
    }
    
}

-(void)setNewGame
{
    /*CGRect newGameRect = CGRectMake(0.0, self.bounds.size.height*2.0/3.0-10.0, self.bounds.size.width, self.bounds.size.height/3.0 + 10.0);
    newGameRect = CGRectInset(newGameRect, INSET, INSET);
    UIBezierPath *newGameRoundedRect = [UIBezierPath bezierPathWithRoundedRect:newGameRect
                                                                  cornerRadius:ROUND_RECT_CORNER_RADIUS];
    [[UIColor whiteColor] setFill];
    UIRectFill(newGameRect);
    newGameRoundedRect.lineWidth =STROKE;
    [newGameRoundedRect stroke];
    
    
    UIImage *signature = [UIImage imageNamed:@"signature.png"];
    CGRect signatureRect = CGRectMake(self.bounds.size.width/2.0-signature.size.width/2.0+10.0, self.bounds.size.height*5.0/6.0-signature.size.height/2.0-25.0, signature.size.width, signature.size.height);
    [signature drawInRect:signatureRect];
    CGPoint mid = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height*5.0/6.0+signature.size.height/2.0-20.0);
    UIFont *newGameFont = [UIFont fontWithName:@"Arial-BoldMT" size:self.bounds.size.height * SCOREBOARD_FONT];
    NSAttributedString *newGame = [[NSAttributedString alloc] initWithString:@"NEW GAME" attributes:@{ NSFontAttributeName : newGameFont }];
    CGPoint gamePoint = CGPointMake(mid.x-newGame.size.width/2.0, mid.y-25.0);
    [newGame drawAtPoint:gamePoint];
    [self setNeedsDisplayInRect:newGameRect];*/
}

-(BOOL)tapNewGame:(CGPoint)tapLocation
{
    /*CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);*/
    CGRect newGameRect = CGRectMake(0.0, self.bounds.size.height*2.0/3.0-10.0, self.bounds.size.width+5.0, self.bounds.size.height/3.0 + 10.0);
    if (CGRectContainsPoint(newGameRect, tapLocation) && !self.faceUp) {
        /*CGRect newGameRect = CGRectMake(0.0, self.bounds.size.height*2.0/3.0-10.0, self.bounds.size.width, self.bounds.size.height/3.0 + 10.0);
        newGameRect = CGRectInset(newGameRect, INSET, INSET);
        UIBezierPath *newGameRoundedRect = [UIBezierPath bezierPathWithRoundedRect:newGameRect
                                                                      cornerRadius:ROUND_RECT_CORNER_RADIUS];
        newGameRoundedRect.lineWidth =STROKE;
        [newGameRoundedRect stroke];
        [newGameRoundedRect addClip];
        [[UIColor colorWithPatternImage:[UIImage imageNamed:@"blackGrad.png"]] setFill];
        UIRectFill(newGameRect);
        UIImage *signature = [UIImage imageNamed:@"signatureWhite.png"];
        CGRect signatureRect = CGRectMake(self.bounds.size.width/2.0-signature.size.width/2.0+10.0, self.bounds.size.height*5.0/6.0-signature.size.height/2.0-25.0, signature.size.width, signature.size.height);
        [signature drawInRect:signatureRect];
        CGPoint mid = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height*5.0/6.0+signature.size.height/2.0-20.0);
        UIFont *newGameFont = [UIFont fontWithName:@"Arial-BoldMT" size:self.bounds.size.height * SCOREBOARD_FONT];
        NSAttributedString *newGame = [[NSAttributedString alloc] initWithString:@"NEW GAME" attributes:@{ NSFontAttributeName : newGameFont }];
        CGPoint gamePoint = CGPointMake(mid.x-newGame.size.width/2.0, mid.y-25.0);
        [newGame drawAtPoint:gamePoint];
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
        [self setNeedsDisplayInRect:newGameRect];*/
        return TRUE;
    }
    return FALSE;
}

-(void) setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

-(void)setup
{
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = ROUND_RECT_CORNER_RADIUS; // if you like rounded corners
    self.layer.shadowOffset = CGSizeMake(2.0, 5.0);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    //self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:ROUND_RECT_CORNER_RADIUS].CGPath;
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

@end

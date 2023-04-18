//
//  ImagePlateView.m
//  PhotoHuntViewer
//
//  Created by b.gay on 3/1/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import "ImagePlateView.h"

@implementation ImagePlateView

#define ROUND_RECT_CORNER_RADIUS 12.0
#define IMAGE_INSET 10.0
#define STROKE_LINE_WIDTH 3.0
#define STROKE_FOUND 4.0
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
    if (self.faceUp) {
        CGRect imageRect = CGRectInset(self.bounds,
                                       IMAGE_INSET,
                                       IMAGE_INSET);
        UIBezierPath *roundedRectImage = [UIBezierPath bezierPathWithRoundedRect:imageRect
                                                               cornerRadius:ROUND_RECT_CORNER_RADIUS];

        [[UIColor blackColor] setStroke];
        roundedRectImage.lineWidth = STROKE_LINE_WIDTH;
        [roundedRectImage stroke];
        
        [roundedRectImage addClip];
        
        [self.image drawInRect:imageRect blendMode:BLEND_MODE alpha:1.0];

        if (self.difference1.isDifferenceFound) {
            [self circleDifference:self.difference1.differenceRect withColor:[UIColor blackColor]];
        }
        if (self.difference2.isDifferenceFound) {
            [self circleDifference:self.difference2.differenceRect withColor:[UIColor blackColor]];
        }
        if (self.difference3.isDifferenceFound) {
            [self circleDifference:self.difference3.differenceRect withColor:[UIColor blackColor]];
        }
        if (self.difference4.isDifferenceFound) {
            [self circleDifference:self.difference4.differenceRect withColor:[UIColor blackColor]];
        }
        if (self.difference5.isDifferenceFound) {
            [self circleDifference:self.difference5.differenceRect withColor:[UIColor blackColor]];
        }
        if (self.difference1.isDifferenceHinted) {
            [self circleDifference:self.difference1.differenceRect withColor:[UIColor redColor]];
        }
        if (self.difference2.isDifferenceHinted) {
            [self circleDifference:self.difference2.differenceRect withColor:[UIColor redColor]];

        }
        if (self.difference3.isDifferenceHinted) {
            [self circleDifference:self.difference3.differenceRect withColor:[UIColor redColor]];

        }
        if (self.difference4.isDifferenceHinted) {
            [self circleDifference:self.difference4.differenceRect withColor:[UIColor redColor]];

        }
        if (self.difference5.isDifferenceHinted) {
            [self circleDifference:self.difference5.differenceRect withColor:[UIColor redColor]];

        }
    }
    else{
        [[UIImage imageNamed:@"background.png"] drawInRect:self.bounds blendMode:BLEND_MODE alpha:1.0];
    }
    
}

-(void) circleDifference:(CGRect)rect withColor:(UIColor *)color
{
    [color setStroke];
    UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:rect];
    oval.lineWidth = STROKE_FOUND;
    [oval stroke];
}

#pragma mark -Initialization

-(void) setImage:(UIImage *)image
{
    _image = image;
    [self setNeedsDisplay];
}

-(void) setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

-(void) setDifference1:(Difference *)difference1
{
    _difference1 = difference1;
    [self setNeedsDisplayInRect:difference1.differenceRect];
}

-(void) setDifference2:(Difference *)difference2
{
    _difference2 = difference2;
    [self setNeedsDisplayInRect:difference2.differenceRect];
}

-(void) setDifference3:(Difference *)difference3
{
    _difference3 = difference3;
    [self setNeedsDisplayInRect:difference3.differenceRect];
}

-(void) setDifference4:(Difference *)difference4
{
    _difference4 = difference4;
    [self setNeedsDisplayInRect:difference4.differenceRect];
}

-(void) setDifference5:(Difference *)difference5
{
    _difference5 = difference5;
    [self setNeedsDisplayInRect:difference5.differenceRect];
}

-(void)setup
{
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = ROUND_RECT_CORNER_RADIUS; // if you like rounded corners
    self.layer.shadowOffset = CGSizeMake(2.0, 5.0);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}


@end

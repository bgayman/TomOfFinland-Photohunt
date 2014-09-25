//
//  ImagePlate.m
//  ToF Photo Hunt
//
//  Created by b.gay on 2/28/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import "ImagePlate.h"

@implementation ImagePlate
-(Difference *)difference1
{
    if(!_difference1) _difference1 = [[Difference alloc]init];
    return _difference1;
}

-(Difference *)difference2
{
    if(!_difference2) _difference2 = [[Difference alloc]init];
    return _difference2;
}

-(Difference *)difference3
{
    if(!_difference3) _difference3 = [[Difference alloc]init];
    return _difference3;
}

-(Difference *)difference4
{
    if(!_difference4) _difference4 = [[Difference alloc]init];
    return _difference4;
}

-(Difference *)difference5
{
    if(!_difference5) _difference5 = [[Difference alloc]init];
    return _difference5;
}


-(Difference *)touchedDifference:(CGPoint)tapLocation
{
    //NSLog(@"touchedDifference %f %f %f %f",self.difference1.differenceRect.origin.x,self.difference1.differenceRect.origin.y,self.difference1.differenceRect.size.width,self.difference1.differenceRect.size.height);
    if (CGRectContainsPoint(self.difference1.differenceRect, tapLocation)) {
        self.difference1.differenceFound = YES;
        return self.difference1;
    }
    if (CGRectContainsPoint(self.difference2.differenceRect, tapLocation)) {
        self.difference2.differenceFound = YES;
        return self.difference2;
    }
    if (CGRectContainsPoint(self.difference3.differenceRect, tapLocation)) {
        self.difference3.differenceFound = YES;
        return self.difference3;
    }
    if (CGRectContainsPoint(self.difference4.differenceRect, tapLocation)) {
        self.difference4.differenceFound = YES;
        return self.difference4;
    }
    if (CGRectContainsPoint(self.difference5.differenceRect, tapLocation)) {
        self.difference5.differenceFound = YES;
        return self.difference5;
    }
    return nil;
}


@end

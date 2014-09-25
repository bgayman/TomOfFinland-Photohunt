//
//  ImagePlate.h
//  ToF Photo Hunt
//
//  Created by b.gay on 2/28/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Difference.h"

@interface ImagePlate : NSObject

@property (strong, nonatomic) UIImage *imageA;
@property (strong, nonatomic) UIImage *imageB;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (strong, nonatomic) Difference *difference1;
@property (strong, nonatomic) Difference *difference2;
@property (strong, nonatomic) Difference *difference3;
@property (strong, nonatomic) Difference *difference4;
@property (strong, nonatomic) Difference *difference5;


-(Difference *)touchedDifference:(CGPoint)tapLocation;

@end

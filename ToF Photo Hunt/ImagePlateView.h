//
//  ImagePlateView.h
//  PhotoHuntViewer
//
//  Created by b.gay on 3/1/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Difference.h"

@interface ImagePlateView : UIView

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) Difference *difference1;
@property (strong, nonatomic) Difference *difference2;
@property (strong, nonatomic) Difference *difference3;
@property (strong, nonatomic) Difference *difference4;
@property (strong, nonatomic) Difference *difference5;

@property (nonatomic) BOOL faceUp;


@end

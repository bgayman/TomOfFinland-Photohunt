//
//  PhotoStack.h
//  ToF Photo Hunt
//
//  Created by b.gay on 2/28/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImagePlate.h"

@interface PhotoStack : NSObject
-(void)addImagePlate:(ImagePlate *)imagePlate atTop:(BOOL) atTop;
-(NSUInteger) count;
-(id)init;

-(ImagePlate *)drawRandomImagePlate;
@end

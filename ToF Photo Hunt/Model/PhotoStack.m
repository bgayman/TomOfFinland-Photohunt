//
//  PhotoStack.m
//  ToF Photo Hunt
//
//  Created by b.gay on 2/28/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import "PhotoStack.h"

@interface PhotoStack()
@property (strong,nonatomic) NSMutableArray *imagePlates;
@end

@implementation PhotoStack

-(NSMutableArray *)imagePlates
{
    if(!_imagePlates){
        _imagePlates=[[NSMutableArray alloc]init];
        
    }
    return _imagePlates;
}
#define X_AXIS_FUDGE 70.0
#define Y_AXIS_FUDGE 104.0
-(id)init
{
    self=[super init];
    NSLog(@"HERE");
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"ImagePlates" ofType:@"plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
    for (NSDictionary *dict in array) {
        ImagePlate *imagePlate= [[ImagePlate alloc]init];
        imagePlate.imageA = [UIImage imageNamed:[NSString stringWithFormat:@"A%@",[dict objectForKey:@"image"]]];
        imagePlate.imageB = [UIImage imageNamed:[NSString stringWithFormat:@"B%@",[dict objectForKey:@"image"]]];
        if (!imagePlate.imageA) {
            NSLog(@"%@",[dict objectForKey:@"image"]);
        }
        
        NSArray *rect = [[NSArray alloc] initWithArray:[[dict objectForKey:@"difference1"] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([rect count]==4) {
            imagePlate.difference1.differenceRect = CGRectMake([rect[0] floatValue]-X_AXIS_FUDGE, [rect[1] floatValue]-Y_AXIS_FUDGE, [rect[2] floatValue], [rect[3] floatValue]);
        }else{
            NSLog(@"B%@",[dict objectForKey:@"image"]);
        }
        
        NSArray *rect2 = [[NSArray alloc] initWithArray:[[dict objectForKey:@"difference2"] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([rect2 count]==4) {
            imagePlate.difference2.differenceRect = CGRectMake([rect2[0] floatValue]-X_AXIS_FUDGE, [rect2[1] floatValue]-Y_AXIS_FUDGE, [rect2[2] floatValue], [rect2[3] floatValue]);
        }else{
            NSLog(@"B%@",[dict objectForKey:@"image"]);
        }
        
        NSArray *rect3 = [[NSArray alloc] initWithArray:[[dict objectForKey:@"difference3"] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([rect3 count]==4) {
            imagePlate.difference3.differenceRect = CGRectMake([rect3[0] floatValue]-X_AXIS_FUDGE, [rect3[1] floatValue]-Y_AXIS_FUDGE, [rect3[2] floatValue], [rect3[3] floatValue]);
        }else{
            NSLog(@"B%@",[dict objectForKey:@"image"]);
        }
        
        NSArray *rect4 = [[NSArray alloc] initWithArray:[[dict objectForKey:@"difference4"] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([rect4 count]==4) {
            imagePlate.difference4.differenceRect = CGRectMake([rect4[0] floatValue]-X_AXIS_FUDGE, [rect4[1] floatValue]-Y_AXIS_FUDGE, [rect4[2] floatValue], [rect4[3] floatValue]);
        }else{
            NSLog(@"B%@",[dict objectForKey:@"image"]);
        }
        
        NSArray *rect5 = [[NSArray alloc] initWithArray:[[dict objectForKey:@"difference5"] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([rect5 count]==4) {
            imagePlate.difference5.differenceRect = CGRectMake([rect5[0] floatValue]-X_AXIS_FUDGE, [rect5[1] floatValue]-Y_AXIS_FUDGE, [rect5[2] floatValue], [rect5[3] floatValue]);
        }else{
            NSLog(@"B%@",[dict objectForKey:@"image"]);
        }
        [self.imagePlates addObject:imagePlate];
        
    }
    return self;
    
}

-(NSUInteger) count
{
    return [self.imagePlates count];
}

-(void)addImagePlate:(ImagePlate *)imagePlate atTop:(BOOL)atTop
{
    if (atTop) {
        [self.imagePlates insertObject:imagePlate atIndex:0];
    }else{
        [self.imagePlates addObject:imagePlate];
    }
}

-(ImagePlate *)drawRandomImagePlate
{
    ImagePlate *randomImagePlate=nil;
    if(self.imagePlates.count){
        unsigned index=arc4random()%self.imagePlates.count;
        randomImagePlate=self.imagePlates[index];
        [self.imagePlates removeObjectAtIndex:index];
    }
    return randomImagePlate;
}

@end

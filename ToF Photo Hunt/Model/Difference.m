//
//  Difference.m
//  ToF Photo Hunt
//
//  Created by b.gay on 3/1/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import "Difference.h"

@implementation Difference

-(id)initWithCGRect:(CGRect)rect
{
    self = [super init];
    if (self) {
        self.differenceRect = rect;
    }
    return self;
}

@end

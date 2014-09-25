//
//  Difference.h
//  ToF Photo Hunt
//
//  Created by b.gay on 3/1/13.
//  Copyright (c) 2013 b.gay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Difference : NSObject
@property (nonatomic) CGRect differenceRect;
@property (nonatomic, getter = isDifferenceFound) BOOL differenceFound;
@property (nonatomic, getter = isDifferenceHinted) BOOL differenceHinted;

-(id)initWithCGRect:(CGRect)rect;
@end

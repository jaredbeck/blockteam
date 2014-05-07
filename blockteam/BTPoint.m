//
//  BTPoint.m
//  blockteam
//
//  Created by Jared Beck on 5/6/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTPoint.h"

@implementation BTPoint

- (id)initWithX:(float)x Y:(float)y Z:(float)z {
    self = [super init];
    
    if (self) {
        [self setX: x];
        [self setY: y];
        [self setZ: z];
    }
    
    return self;
}

@end

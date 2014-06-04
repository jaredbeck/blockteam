//
//  BTCamera.h
//  blockteam
//
//  Created by Jared Beck on 6/3/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTPoint.h"

@interface BTCamera : NSObject

@property float radians;

- (id) initWithRadians: (float) radians;
- (void) moveClockwise;
- (void) moveCounterClockwise;
- (BTPoint*) position;

@end

//
//  BTCamera.m
//  blockteam
//
//  Created by Jared Beck on 6/3/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTCamera.h"
#import "BTPoint.h"

@implementation BTCamera

static float const kCameraElevation = 2.0;
static float const kCameraRadius = 3.0;
static float const kCameraSpeed = 0.1; // radians

- (id) initWithRadians: (float) radians {
    self = [super init];
    if (self) { [self setRadians: radians]; }
    return self;
}

- (void) moveClockwise {
    self.radians -= kCameraSpeed;
    if (self.radians < 0.0) { self.radians += 2 * M_PI; }
}

- (void) moveCounterClockwise {
	self.radians += kCameraSpeed;
	if (self.radians > 2 * M_PI) { self.radians -= 2 * M_PI; }
}

- (BTPoint*) position {
	const float x = kCameraRadius * cosf(self.radians);
	const float z = kCameraRadius * sinf(self.radians);
	return [[BTPoint alloc] initWithX: x Y: kCameraElevation Z: z];
}

@end

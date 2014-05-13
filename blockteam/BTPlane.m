//
//  BTPlane.m
//  blockteam
//
//  Created by Jared Beck on 5/12/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTPlane.h"

#import "BTColor.h"
#include <OpenGL/gl.h>

@implementation BTPlane

static float const kLength = 9.0;

- (id) initWithY: (float) y
{
    self = [super init];
    if (self) { [self setY: y]; }
    return self;
}

- (void) draw
{
    const float r = kLength / 2;
    glBegin(GL_QUADS);
    {
        [BTColor grey];
        glVertex3f(0.0 - r, self.y, 0.0 + r);
        glVertex3f(0.0 + r, self.y, 0.0 + r);
        glVertex3f(0.0 + r, self.y, 0.0 - r);
        glVertex3f(0.0 - r, self.y, 0.0 - r);
    }
    glEnd();
}

@end

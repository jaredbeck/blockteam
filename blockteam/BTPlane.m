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

- (id) initWithY: (float) y
{
    self = [super init];
    if (self) { [self setY: y]; }
    return self;
}

- (void) draw
{
    float size = 2.0;
    glBegin(GL_QUADS);
    {
        [BTColor grey];
        glVertex3f(0.0 - size, self.y, 0.0 + size);
        glVertex3f(0.0 + size, self.y, 0.0 + size);
        glVertex3f(0.0 + size, self.y, 0.0 - size);
        glVertex3f(0.0 - size, self.y, 0.0 - size);
    }
    glEnd();
}

@end

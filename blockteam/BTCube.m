//
//  BTCube.m
//  blockteam
//
//  Created by Jared Beck on 5/12/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTCube.h"

#import "BTColor.h"
#import <OpenGL/gl.h>

@implementation BTCube

static float const kLength = 1.0;

- (id) initWithCenter: (BTPoint*) center {
    self = [super init];
    if (self) { [self setCenter: center]; }
    return self;
}

/* "did you want to use lighting? If so, you're better off with GL_QUADS 
 or GL_TRIANGLES; stripping/fanning uses the same computed vertex colour 
 for each usage of a vertex by a triangle, and for a cube that's going to 
 look really bad." (http://bit.ly/1nBJZxN) 
 */
- (void) draw {
    const float r = kLength / 2;
    BTPoint* p = self.center;

    // sides of cube
    glBegin(GL_QUADS);
    {
        [BTColor red];

        // Fr.  011 111 101 001
        glVertex3f(p.x - r, p.y + r, p.z + r);
        glVertex3f(p.x + r, p.y + r, p.z + r);
        glVertex3f(p.x + r, p.y - r, p.z + r);
        glVertex3f(p.x - r, p.y - r, p.z + r);

        // Bk.  010 110 100 000
        glVertex3f(p.x - r, p.y + r, p.z - r);
        glVertex3f(p.x + r, p.y + r, p.z - r);
        glVertex3f(p.x + r, p.y - r, p.z - r);
        glVertex3f(p.x - r, p.y - r, p.z - r);

        // Rgt  111 110 100 101
        glVertex3f(p.x + r, p.y + r, p.z + r);
        glVertex3f(p.x + r, p.y + r, p.z - r);
        glVertex3f(p.x + r, p.y - r, p.z - r);
        glVertex3f(p.x + r, p.y - r, p.z + r);

        // Top  010 110 111 011
        glVertex3f(p.x - r, p.y + r, p.z - r);
        glVertex3f(p.x + r, p.y + r, p.z - r);
        glVertex3f(p.x + r, p.y + r, p.z + r);
        glVertex3f(p.x - r, p.y + r, p.z + r);

        // Lft  011 010 000 001
        glVertex3f(p.x - r, p.y + r, p.z + r);
        glVertex3f(p.x - r, p.y + r, p.z - r);
        glVertex3f(p.x - r, p.y - r, p.z - r);
        glVertex3f(p.x - r, p.y - r, p.z + r);

        // Bot  000 100 101 001
        glVertex3f(p.x - r, p.y - r, p.z - r);
        glVertex3f(p.x + r, p.y - r, p.z - r);
        glVertex3f(p.x + r, p.y - r, p.z + r);
        glVertex3f(p.x - r, p.y - r, p.z + r);
    }
    glEnd();
}

@end

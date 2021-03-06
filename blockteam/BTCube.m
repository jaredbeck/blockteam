//
//  BTCube.m
//  blockteam
//
//  Created by Jared Beck on 5/12/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTCube.h"

#import "BTMaterial.h"
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

    [BTMaterial red];

    glBegin(GL_QUADS);
    {

        // Front 011 001 101 111 counter-clockwise
        // Faces positive Z
        glNormal3f(0, 0, 1);
        glVertex3f(p.x - r, p.y + r, p.z + r);
        glVertex3f(p.x - r, p.y - r, p.z + r);
        glVertex3f(p.x + r, p.y - r, p.z + r);
        glVertex3f(p.x + r, p.y + r, p.z + r);

        // Back 010 110 100 000 clockwise
        // Faces negative Z
        glNormal3f(0, 0, -1);
        glVertex3f(p.x - r, p.y + r, p.z - r);
        glVertex3f(p.x + r, p.y + r, p.z - r);
        glVertex3f(p.x + r, p.y - r, p.z - r);
        glVertex3f(p.x - r, p.y - r, p.z - r);

        // Right 111 101 100 110 counter-clockwise
        // Faces positive X
        glNormal3f(1, 0, 0);
        glVertex3f(p.x + r, p.y + r, p.z + r);
        glVertex3f(p.x + r, p.y - r, p.z + r);
        glVertex3f(p.x + r, p.y - r, p.z - r);
        glVertex3f(p.x + r, p.y + r, p.z - r);

        // Top 010 011 111 110 counter-clockwise
        // Faces positive Y
        glNormal3f(0, 1, 0);
        glVertex3f(p.x - r, p.y + r, p.z - r);
        glVertex3f(p.x - r, p.y + r, p.z + r);
        glVertex3f(p.x + r, p.y + r, p.z + r);
        glVertex3f(p.x + r, p.y + r, p.z - r);

        // Left  011 010 000 001 clockwise
        // Faces negative X
        glNormal3f(-1, 0, 0);
        glVertex3f(p.x - r, p.y + r, p.z + r);
        glVertex3f(p.x - r, p.y + r, p.z - r);
        glVertex3f(p.x - r, p.y - r, p.z - r);
        glVertex3f(p.x - r, p.y - r, p.z + r);

        // Bot  000 100 101 001 clockwise
        // Faces negative Y
        /* Draw the bottom, even though it may always face away from the
        camera, depending on the design of the game, TBD. */
        glNormal3f(0, -1, 0);
        glVertex3f(p.x - r, p.y - r, p.z - r);
        glVertex3f(p.x + r, p.y - r, p.z - r);
        glVertex3f(p.x + r, p.y - r, p.z + r);
        glVertex3f(p.x - r, p.y - r, p.z + r);
    }
    glEnd();
}

@end

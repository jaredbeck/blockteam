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

- (void) draw {
    const float r = kLength / 2;
    BTPoint* p = self.center;

    // sides of cube
    glBegin(GL_QUAD_STRIP);
    {
        [BTColor red];
        glVertex3f( p.x + r, p.y + r, p.z + r);
        glVertex3f( p.x + r, p.y, p.z + r);
        
        glVertex3f( p.x + r, p.y + r, p.z);
        glVertex3f( p.x + r, p.y, p.z);
        
        glVertex3f( p.x, p.y + r, p.z);
        glVertex3f( p.x, p.y, p.z);
        
        glVertex3f( p.x, p.y + r, p.z + r);
        glVertex3f( p.x, p.y, p.z + r);
        
        glVertex3f( p.x + r, p.y + r, p.z + r);
        glVertex3f( p.x + r, p.y, p.z);
    }
    glEnd();
    
    // bottom of cube
    glBegin(GL_QUADS);
    {
        [BTColor red];
        glVertex3f(p.x, p.y, p.z);
        glVertex3f(p.x + r, p.y, p.z);
        glVertex3f(p.x + r, p.y, p.z + r);
        glVertex3f(p.x, p.y, p.z + r);
    }
    glEnd();
}

@end

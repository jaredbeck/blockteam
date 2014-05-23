//
//  BTPlayer.m
//  blockteam
//
//  Created by Jared Beck on 5/22/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTPlayer.h"
#import "BTMaterial.h"
#import <OpenGL/gl.h>
#import <OpenGL/glu.h>

@implementation BTPlayer

- (id) initWithCenter: (BTPoint*) center {
    self = [super init];
    if (self) { [self setCenter: center]; }
    return self;
}

- (void) draw {
    glTranslatef(self.center.x, self.center.y, self.center.z);
    [BTMaterial yellow];
    GLUquadric* quad = gluNewQuadric();
    GLdouble radius = 0.5;
    GLint slices = 20;
    GLint stacks = 20;
    gluSphere(quad, radius, slices, stacks);
}

@end

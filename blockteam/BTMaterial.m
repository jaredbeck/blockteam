//
//  BTMaterial.m
//  blockteam
//
//  Created by Jared Beck on 5/15/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTMaterial.h"
#import <OpenGL/gl.h>

@implementation BTMaterial

+ (void) blue {
    GLfloat blue[] = {0.0, 0.0, 0.5};
    glMaterialfv(GL_FRONT, GL_AMBIENT, blue);
    glMaterialfv(GL_FRONT, GL_DIFFUSE, blue);
}

+ (void) green {
    GLfloat green[] = {0.0, 0.5, 0.0};
    glMaterialfv(GL_FRONT, GL_AMBIENT, green);
    glMaterialfv(GL_FRONT, GL_DIFFUSE, green);
}

+ (void) grey {
    GLfloat grey[] = {0.5, 0.5, 0.5};
    glMaterialfv(GL_FRONT, GL_AMBIENT, grey);
    glMaterialfv(GL_FRONT, GL_DIFFUSE, grey);
}

+ (void) greyDark {
    GLfloat greyDark[] = {0.4, 0.4, 0.4};
    glMaterialfv(GL_FRONT, GL_AMBIENT, greyDark);
    glMaterialfv(GL_FRONT, GL_DIFFUSE, greyDark);
}

+ (void) red {
    GLfloat red[] = {0.5, 0.0, 0.0};
    glMaterialfv(GL_FRONT, GL_AMBIENT, red);
    glMaterialfv(GL_FRONT, GL_DIFFUSE, red);
}

+ (void) yellow {
    GLfloat yellow[] = {1.0, 1.0, 0.0};
    glMaterialfv(GL_FRONT, GL_AMBIENT, yellow);
    glMaterialfv(GL_FRONT, GL_DIFFUSE, yellow);
}

@end

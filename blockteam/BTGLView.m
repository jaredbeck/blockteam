//
//  BTGLView.m
//  blockteam
//
//  Created by Jared Beck on 5/6/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTGLView.h"
#import "BTPoint.h"
#include <OpenGL/gl.h>

@implementation BTGLView

-(void) drawTriangle
{
    glColor3f(1.0f, 0.85f, 0.35f);
    glBegin(GL_TRIANGLES);
    {
        glVertex3f(  0.0,  0.6, 0.0);
        glVertex3f( -0.2, -0.3, 0.0);
        glVertex3f(  0.2, -0.3 ,0.0);
    }
    glEnd();
}

-(void) drawCube: (BTPoint*) p Length: (float) l
{
    NSLog(@"drawCube((%f, %f, %f), %f)", p.x, p.y, p.z, l);
    float r = l / 2; // length / 2 is sort of the "radius" of the cube ..
    
    // sides of cube
	glBegin(GL_QUAD_STRIP);
	{
		glColor3f(0.0f,1.0f,0.0f); // green
		glVertex3f( 1.0f, 1.0f, 1.0f);
		glVertex3f( 1.0f, 0.0f, 1.0f);
		glColor3f(0.0f,0.0f,1.0f); // blue
		glVertex3f( 1.0f, 1.0f, 0.0f);
		glVertex3f( 1.0f, 0.0f, 0.0f);
		glColor3f(1.0f,1.0f,0.0f); // yellow
		glVertex3f( 0.0f, 1.0f, 0.0f);
		glVertex3f( 0.0f, 0.0f, 0.0f);
		glColor3f(0.0f,1.0f,0.0f); // green
		glVertex3f( 0.0f, 1.0f, 1.0f);
		glVertex3f( 0.0f, 0.0f, 1.0f);
		glColor3f(0.0f,0.0f,0.0f); // white
		glVertex3f( 1.0f, 1.0f, 1.0f);
		glVertex3f( 1.0f, 0.0f, 1.0f);
	}
	glEnd();
	
	// bottom of cube
	glBegin(GL_QUADS);
	{
		glColor3f(1.0f,0.0f,0.0f);                	// set color to red
		glVertex3f( 0.0f, 0.0f, 0.0f); // 5
		glVertex3f( 1.0f, 0.0f, 0.0f); // 3
		glVertex3f( 1.0f, 0.0f, 1.0f); // 1
		glVertex3f( 0.0f, 0.0f, 1.0f); // 7
	}
	glEnd();
}

-(void) drawRect: (NSRect) bounds
{
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    [self drawTriangle];
    
    BTPoint *p = [[BTPoint alloc] initWithX: 0.0f Y: 0.0f Z: 0.0f];
    [self drawCube: p Length: 1.0f];
    
    glFlush();
}

@end

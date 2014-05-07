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
		glVertex3f( p.x + r, p.y + r, p.z + r);
		glVertex3f( p.x + r, p.y, p.z + r);
		glColor3f(0.0f,0.0f,1.0f); // blue
		glVertex3f( p.x + r, p.y + r, p.z);
		glVertex3f( p.x + r, p.y, p.z);
		glColor3f(1.0f,1.0f,0.0f); // yellow
		glVertex3f( p.x, p.y + r, p.z);
		glVertex3f( p.x, p.y, p.z);
		glColor3f(0.0f,1.0f,0.0f); // green
		glVertex3f( p.x, p.y + r, p.z + r);
		glVertex3f( p.x, p.y, p.z + r);
		glColor3f(0.0f,0.0f,0.0f); // white
		glVertex3f( p.x + r, p.y + r, p.z + r);
		glVertex3f( p.x + r, p.y, p.z);
	}
	glEnd();
	
	// bottom of cube
	glBegin(GL_QUADS);
	{
		glColor3f(1.0f,0.0f,0.0f); // red
		glVertex3f(p.x, p.y, p.z);
		glVertex3f(p.x + r, p.y, p.z);
		glVertex3f(p.x + r, p.y, p.z + r);
		glVertex3f(p.x, p.y, p.z + r);
	}
	glEnd();
}

-(void) drawRect: (NSRect) bounds
{
	glClearColor(0, 0, 0, 0);
	glClear(GL_COLOR_BUFFER_BIT);
	[self drawTriangle];
	BTPoint *p = [[BTPoint alloc] initWithX: -0.5f Y: 0.0f Z: 0.0f];
	[self drawCube: p Length: 1.0f];
	glFlush();
}

@end

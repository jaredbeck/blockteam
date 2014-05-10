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
#include <OpenGL/glu.h>

@implementation BTGLView

-(void) gold	{ glColor3f(1.0f, 0.85f, 0.35f); }
-(void) red		{ glColor3f(1.0f, 0.0f, 0.0f); }
-(void) green	{ glColor3f(0.0f, 1.0f, 0.0f); }
-(void) blue	{ glColor3f(0.0f, 0.0f, 1.0f); }
-(void) yellow	{ glColor3f(1.0f, 1.0f, 0.0f); }
-(void) white	{ glColor3f(0.0f, 0.0f, 0.0f); }

-(void) drawTriangle
{
	[self gold];
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
		[self red];
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
		[self red];
		glVertex3f(p.x, p.y, p.z);
		glVertex3f(p.x + r, p.y, p.z);
		glVertex3f(p.x + r, p.y, p.z + r);
		glVertex3f(p.x, p.y, p.z + r);
	}
	glEnd();
}

-(void) placeCamera: (BTPoint*) loc
{
	/* The arguments for `gluLookAt` indicate where the camera (or
	eye position) is placed, where it is aimed, and which way is up. */
	gluLookAt (loc.x, loc.y, loc.z, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
	glViewport (0, 0, (GLsizei) 400, (GLsizei) 400);
	glMatrixMode (GL_PROJECTION);
	glLoadIdentity ();
	glFrustum (-1.0, 1.0, -1.0, 1.0, 1.5, 20.0);
	glMatrixMode (GL_MODELVIEW);
}

-(void) drawRect: (NSRect) bounds
{
	glClearColor(0, 0, 0, 0);
	glShadeModel(GL_FLAT);
	glClear(GL_COLOR_BUFFER_BIT);
	glLoadIdentity(); /* clear the matrix */
	[self placeCamera: [[BTPoint new] initWithX: 0.0 Y: 0.0 Z: 3.0]];
	[self drawTriangle];
	BTPoint *p = [[BTPoint alloc] initWithX: -0.5f Y: 0.0f Z: 0.0f];
	[self drawCube: p Length: 1.0f];
	glFlush();
}

@end

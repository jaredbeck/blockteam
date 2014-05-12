//
//  BTGLView.m
//  blockteam
//
//  Created by Jared Beck on 5/6/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTGLView.h"

#import "BTColor.h"
#import "BTLog.h"
#import "BTPlane.h"
#import "BTPoint.h"
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>

@implementation BTGLView {
	float cameraRadians;
	BTPoint* cameraLoc;
}

- (BOOL) acceptsFirstResponder { return YES; }

-(void) drawTriangle
{
	[BTColor gold];
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

-(void) placeCamera: (BTPoint*) loc
{
	float cameraElevation = 2.0;
	/* The arguments for `gluLookAt` indicate where the camera (or
	eye position) is placed, where it is aimed, and which way is up. */
	gluLookAt (loc.x, loc.y + cameraElevation, loc.z, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
	glViewport (0, 0, (GLsizei) 400, (GLsizei) 400);
	glMatrixMode (GL_PROJECTION);
	glLoadIdentity ();
	glFrustum (-1.0, 1.0, -1.0, 1.0, 1.5, 20.0);
	glMatrixMode (GL_MODELVIEW);
}

/* Seems like maybe there's no `init`.
 (http://www.idevgames.com/forums/thread-7621.html)
 Who knows when or how often drawRect gets called..
 */
-(void) drawRect: (NSRect) bounds
{
	[BTLog logNSRect: bounds];
	if (cameraLoc == nil) {
		cameraLoc = [[BTPoint new] initWithX: 0.0 Y: 0.0 Z: 3.0];
	}
	glClearColor(0, 0, 0, 0);
	glShadeModel(GL_FLAT);
	glClear(GL_COLOR_BUFFER_BIT);
	glLoadIdentity(); /* clear the matrix */
	[self placeCamera: cameraLoc];
	[[[BTPlane new] initWithY: 0.0] draw];
	[self drawTriangle];
	BTPoint *p = [[BTPoint alloc] initWithX: -0.5f Y: 0.0f Z: 0.0f];
	[self drawCube: p Length: 1.0f];
	glFlush();
}

- (void) rotateCameraToRadians: (float) radians Radius:(float) radius
{
	cameraLoc.x = radius * cosf(radians);
	cameraLoc.z = radius * sinf(radians);
	[self setNeedsDisplay: YES];
}

-(void)keyUp:(NSEvent*)event
{
	NSLog(@"Key released");
}

-(void)keyDown:(NSEvent*)event
{
	float cameraRadius = 3.0;
	float cameraSpeed = 0.1; // radians
	NSString* chars = [event characters];
	if ([chars isEqualToString: @"a"]) {
		NSLog(@"Move camera clockwise");
		cameraRadians -= cameraSpeed;
		if (cameraRadians < 0.0) { cameraRadians += 2 * M_PI; }
		[self rotateCameraToRadians: cameraRadians Radius: cameraRadius];
	} else if ([chars isEqualToString: @"d"]) {
		NSLog(@"Move camera counter-clockwise");
		cameraRadians += cameraSpeed;
		if (cameraRadians > 2 * M_PI) { cameraRadians -= 2 * M_PI; }
		[self rotateCameraToRadians: cameraRadians Radius: cameraRadius];
	}
}

@end

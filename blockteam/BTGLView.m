//
//  BTGLView.m
//  blockteam
//
//  Created by Jared Beck on 5/6/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTGLView.h"

#import "BTColor.h"
#import "BTCube.h"
#import "BTLog.h"
#import "BTPlane.h"
#import "BTPoint.h"
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>

@implementation BTGLView {
	float cameraRadians; // initial value of 0.0 is intentional
}

static float const kCameraElevation = 2.0;
static float const kCameraRadius = 3.0;
static float const kCameraSpeed = 0.1; // radians

- (BOOL) acceptsFirstResponder { return YES; }

-(void) drawTriangle {
	[BTColor gold];
	glBegin(GL_TRIANGLES);
	{
		glVertex3f(  0.0,  0.6, 0.0);
		glVertex3f( -0.2, -0.3, 0.0);
		glVertex3f(  0.2, -0.3 ,0.0);
	}
	glEnd();
}

- (BTPoint*) getCameraPosition {
	const float x = kCameraRadius * cosf(cameraRadians);
	const float z = kCameraRadius * sinf(cameraRadians);
	return [[BTPoint alloc] initWithX: x Y: kCameraElevation Z: z];
}

-(void) placeCamera {
	BTPoint* loc = [self getCameraPosition];
	/* The arguments for `gluLookAt` indicate where the camera (or
	eye position) is placed, where it is aimed, and which way is up. */
	gluLookAt (loc.x, loc.y, loc.z, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
	glViewport (0, 0, (GLsizei) 400, (GLsizei) 400);
	glMatrixMode (GL_PROJECTION);
	glLoadIdentity ();
	glFrustum (-1.0, 1.0, -1.0, 1.0, 1.5, 20.0);
	glMatrixMode (GL_MODELVIEW);
}

- (void) drawCubes {
	BTPoint* center = [[BTPoint alloc] initWithX: -0.5f Y: 0.0f Z: 0.0f];
	BTCube* cube = [[BTCube alloc] initWithCenter: center];
	[cube draw];
}

/* Seems like maybe there's no `init`.
 (http://www.idevgames.com/forums/thread-7621.html)
 Who knows when or how often drawRect gets called..
 */
-(void) drawRect: (NSRect) bounds {
	glClearColor(0, 0, 0, 0);
	glShadeModel(GL_FLAT);
	glClear(GL_COLOR_BUFFER_BIT);
	glLoadIdentity(); /* clear the matrix */
	[self placeCamera];
	[[[BTPlane alloc] initWithY: 0.0] draw];
	[self drawTriangle];
	[self drawCubes];
	glFlush();
}

- (void) moveCameraClockwise {
	cameraRadians -= kCameraSpeed;
	if (cameraRadians < 0.0) { cameraRadians += 2 * M_PI; }
	[self setNeedsDisplay: YES];
}

- (void) moveCameraCounterClockwise {
	cameraRadians += kCameraSpeed;
	if (cameraRadians > 2 * M_PI) { cameraRadians -= 2 * M_PI; }
	[self setNeedsDisplay: YES];
}

-(void)keyUp:(NSEvent*)event {
	// noop. placeholder.
}

-(void)keyDown:(NSEvent*)event {
	NSString* chars = [event characters];
	if ([chars isEqualToString: @"a"]) {
		[self moveCameraClockwise];
	} else if ([chars isEqualToString: @"d"]) {
		[self moveCameraCounterClockwise];
	}
}

@end

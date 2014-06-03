//
//  BTGLView.m
//  blockteam
//
//  Created by Jared Beck on 5/6/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTGLView.h"

#import "BTCube.h"
#import "BTLog.h"
#import "BTMaterial.h"
#import "BTPlane.h"
#import "BTPlayer.h"
#import "BTPoint.h"
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>

@implementation BTGLView {
	float cameraRadians;
}

static float const kCameraElevation = 2.0;
static float const kCameraRadius = 3.0;
static float const kCameraSpeed = 0.1; // radians

/* Public */

- (BOOL) acceptsFirstResponder { return YES; }

- (void) drawRect: (NSRect) bounds {
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	[self projection];
	[self modelview];
	glFlush();
}

- (void) keyUp:(NSEvent*)event {
	// noop. placeholder.
}

- (void) keyDown:(NSEvent*)event {
	NSString* chars = [event characters];
	if ([chars isEqualToString: @"a"]) {
		[self moveCameraClockwise];
	} else if ([chars isEqualToString: @"d"]) {
		[self moveCameraCounterClockwise];
	}
}

- (void) prepareOpenGL {
	cameraRadians = 1.5 * M_PI;
	glClearColor(0, 0, 0, 0);
	glShadeModel(GL_SMOOTH);
	glEnable(GL_CULL_FACE); // hide polygons that face away from the camera
	glEnable(GL_DEPTH_TEST); // clip ploygons in the back of the scene
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT1);
}

/* Private */

- (void) drawCubes {
	BTPoint* center = [[BTPoint alloc] initWithX: 0.0 Y: 0.5 Z: 0.0];
	BTCube* cube = [[BTCube alloc] initWithCenter: center];
	[cube draw];
}

- (void) drawTriangle {
	const float z = 1.1;
	[BTMaterial yellow];
	glBegin(GL_TRIANGLES);
	{
		glVertex3f( 0.0, 1.0, z);
		glVertex3f( 0.5, 0.0, z);
		glVertex3f(-0.5, 0.0, z);
	}
	glEnd();
}

- (BTPoint*) getCameraPosition {
	const float x = kCameraRadius * cosf(cameraRadians);
	const float z = kCameraRadius * sinf(cameraRadians);
	return [[BTPoint alloc] initWithX: x Y: kCameraElevation Z: z];
}

/* The GL_MODELVIEW matrix, as its name implies, should contain
 modeling and viewing transformations, which transform object
 space coordinates into eye space coordinates. Remember to place
 the camera transformations on the GL_MODELVIEW matrix and never
 on the GL_PROJECTION matrix.
 http://www.opengl.org/archives/resources/faq/technical/viewing.htm
 */
- (void) modelview {
	glMatrixMode(GL_MODELVIEW);

	BTPoint* loc = [self getCameraPosition];
	gluLookAt(loc.x, loc.y, loc.z, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
	glViewport(0, 0, (GLsizei) 400, (GLsizei) 400);

	GLfloat ambient[]= { 0.5f, 0.5f, 0.5f, 1.0f };
	glLightfv(GL_LIGHT1, GL_AMBIENT, ambient);
	GLfloat diffuse[]= { 1.0f, 1.0f, 1.0f, 1.0f };
	glLightfv(GL_LIGHT1, GL_DIFFUSE, diffuse);
	GLfloat position[]= { 0.0f, 2.0f, 2.0f, 1.0f };
	glLightfv(GL_LIGHT1, GL_POSITION, position);

	[[[BTPlane alloc] initWithY: 0.0] draw];
	[self drawCubes];
	BTPoint* center = [[BTPoint alloc] initWithX: 1.0 Y: 0.5 Z: 0.0];
	BTPlayer* player = [[BTPlayer alloc] initWithCenter: center];
	[player draw];
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

/* The GL_PROJECTION matrix should contain only the projection
 transformation calls it needs to transform eye space coordinates
 into clip coordinates.
 http://www.opengl.org/archives/resources/faq/technical/viewing.htm
 */
- (void) projection {
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	// Frustum: Lft, Rgt, Bot, Top, Near, Far
	glFrustum(-1.0, 1.0, -1.0, 1.0, 1.5, 20.0);
}

@end

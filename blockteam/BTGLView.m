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

- (void) modelview {
	glMatrixMode(GL_MODELVIEW);
	[[[BTPlane alloc] initWithY: 0.0] draw];
	[self drawCubes];
	[self drawTriangle];
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

- (void) projection {
	BTPoint* loc = [self getCameraPosition];
	gluLookAt(loc.x, loc.y, loc.z, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
	glViewport(0, 0, (GLsizei) 400, (GLsizei) 400);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glFrustum (-1.0, 1.0, -1.0, 1.0, 1.5, 20.0);
	GLfloat LightAmbient[]= { 0.5f, 0.5f, 0.5f, 1.0f };
	glLightfv(GL_LIGHT1, GL_AMBIENT, LightAmbient);
	GLfloat LightDiffuse[]= { 1.0f, 1.0f, 1.0f, 1.0f };
	glLightfv(GL_LIGHT1, GL_DIFFUSE, LightDiffuse);
	GLfloat LightPosition[]= { 0.0f, 2.0f, 2.0f, 1.0f };
	glLightfv(GL_LIGHT1, GL_POSITION, LightPosition);
	glEnable(GL_LIGHT1);
	glEnable(GL_LIGHTING);
}

@end

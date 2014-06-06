//
//  BTGLView.m
//  blockteam
//
//  Created by Jared Beck on 5/6/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTGLView.h"

#import "BTCamera.h"
#import "BTCube.h"
#import "BTLog.h"
#import "BTMaterial.h"
#import "BTPlane.h"
#import "BTPlayer.h"
#import "BTPoint.h"
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>

@implementation BTGLView

/* Public */

- (BOOL) acceptsFirstResponder { return YES; }

- (void) drawRect: (NSRect) bounds {
	[BTLog logNSRect: bounds];
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
		[self.camera moveClockwise];
	} else if ([chars isEqualToString: @"d"]) {
		[self.camera moveCounterClockwise];
	}
	[self setNeedsDisplay: YES];
}

- (void) prepareOpenGL {
	BTCamera *camera = [[BTCamera alloc] initWithRadians: 1.5 * M_PI];
	[self setCamera: camera];
	glClearColor(0, 0, 0, 0);
	glShadeModel(GL_SMOOTH);
	glEnable(GL_CULL_FACE); // hide polygons that face away from the camera
	glEnable(GL_DEPTH_TEST); // clip ploygons in the back of the scene
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT1);
}

/* `reshape` - Called by Cocoa when the view's visible
rectangle or bounds change. */
- (void) reshape {
	NSRect windowFrame = [[[self window] contentView] frame];
	NSSize windowFrameSize = windowFrame.size;
	float w = windowFrameSize.width;
	float h = windowFrameSize.height;
	NSLog(@"window reshape: (%f, %f)", w, h);

    float x = [self frame].origin.x;
    float y = [self frame].origin.y;
	NSLog(@"frame origin (%.02f %.02f)", x, y);

	self.viewportSize = windowFrameSize;
	[self setFrameSize: windowFrameSize];
	NSPoint origin = {0, 0};
	[self setFrameOrigin: origin];

	[self setNeedsDisplay: YES]; // necessary?
}

/* `update` - Called by Cocoa when the view’s window moves or
when the view itself moves or is resized. */
- (void) update {
	NSLog(@"view update");
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

/* The GL_MODELVIEW matrix, as its name implies, should contain
 modeling and viewing transformations, which transform object
 space coordinates into eye space coordinates. Remember to place
 the camera transformations on the GL_MODELVIEW matrix and never
 on the GL_PROJECTION matrix.
 http://www.opengl.org/archives/resources/faq/technical/viewing.htm
 */
- (void) modelview {
	glMatrixMode(GL_MODELVIEW);

	BTPoint* loc = [self.camera position];
	gluLookAt(loc.x, loc.y, loc.z, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
	CGFloat vpSzW = self.viewportSize.width;
	CGFloat vpSzH = self.viewportSize.height;
	NSLog(@"set viewport size to (%f, %f)", vpSzW, vpSzH);
	glViewport(0, 0, (GLsizei) vpSzW, (GLsizei) vpSzH);

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

/* The GL_PROJECTION matrix should contain only the projection
 transformation calls it needs to transform eye space coordinates
 into clip coordinates.
 http://www.opengl.org/archives/resources/faq/technical/viewing.htm
 */
- (void) projection {
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();

	/* The "world size" at the beginning is 2.0 "units" wide by
	 2.0 high, centered on the origin, giving 1.0 "units" on each
	 side of the origin.  As the viewport changes size, the world
	 size should chnage proportionally. */
	float worldWidth = self.viewportSize.width / 220.0;
	float worldHeight = self.viewportSize.height / 220.0;

	// Frustum: Lft, Rgt, Bot, Top, Near, Far
	float lft = -1 * worldWidth / 2;
	float rgt = worldWidth / 2;
	float bot = -1 * worldHeight / 2;
	float top = worldHeight / 2;
	glFrustum(lft, rgt, bot, top, 1.5, 20.0);
}

@end

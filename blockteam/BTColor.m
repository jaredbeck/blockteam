//
//  BTColor.m
//  blockteam
//
//  Created by Jared Beck on 5/12/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTColor.h"
#include <OpenGL/gl.h>

@implementation BTColor

+ (void) gold	{ glColor3f(1.0f, 0.85f, 0.35f); }
+ (void) red	{ glColor3f(1.0f, 0.0f, 0.0f); }
+ (void) green	{ glColor3f(0.0f, 1.0f, 0.0f); }
+ (void) grey	{ glColor3f(0.5f, 0.5f, 0.5f); }
+ (void) blue	{ glColor3f(0.0f, 0.0f, 1.0f); }
+ (void) yellow	{ glColor3f(1.0f, 1.0f, 0.0f); }
+ (void) white	{ glColor3f(0.0f, 0.0f, 0.0f); }

@end

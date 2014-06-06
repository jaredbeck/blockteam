//
//  BTGLView.h
//  blockteam
//
//  Created by Jared Beck on 5/6/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BTCamera.h"

@interface BTGLView : NSOpenGLView

@property BTCamera *camera;
@property NSSize viewportSize;

@end

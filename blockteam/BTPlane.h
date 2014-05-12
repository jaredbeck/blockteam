//
//  BTPlane.h
//  blockteam
//
//  Created by Jared Beck on 5/12/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPlane : NSObject

@property float y;

- (id) initWithY: (float) y;
- (void) draw;

@end

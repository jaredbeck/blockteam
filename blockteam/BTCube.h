//
//  BTCube.h
//  blockteam
//
//  Created by Jared Beck on 5/12/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTPoint.h"

@interface BTCube : NSObject

@property BTPoint* center;

- (id) initWithCenter: (BTPoint*) center;
- (void) draw;

@end

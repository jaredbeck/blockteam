//
//  BTPlayer.h
//  blockteam
//
//  Created by Jared Beck on 5/22/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTPoint.h"

@interface BTPlayer : NSObject

@property BTPoint* center;

- (id) initWithCenter: (BTPoint*) center;
- (void) draw;

@end

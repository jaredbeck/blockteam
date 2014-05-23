//
//  BTPoint.h
//  blockteam
//
//  Created by Jared Beck on 5/6/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPoint : NSObject

@property float x;
@property float y;
@property float z;

- (id) initWithX:(float)x Y:(float)y Z:(float)z;
- (void) log;

@end

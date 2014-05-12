//
//  BTLog.m
//  blockteam
//
//  Created by Jared Beck on 5/12/14.
//  Copyright (c) 2014 blockteam. All rights reserved.
//

#import "BTLog.h"

@implementation BTLog

+ (void) logNSRect: (NSRect) rect
{
	NSLog(@"%@", CGRectCreateDictionaryRepresentation(rect));
}

@end

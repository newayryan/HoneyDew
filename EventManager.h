//
//  EventManager.h
//  HoneyDew
//
//  Created by Wei Liu on 6/25/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface EventManager : NSObject

+ (EventManager *) sharedManager;
- (NSArray *)eventsArray;
- (void)addEvent:(Event*)event;

@end

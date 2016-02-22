//
//  EventManager.m
//  HoneyDew
//
//  Created by Wei Liu on 6/25/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "EventManager.h"

@interface EventManager ()
@property (nonatomic) NSMutableArray *events;
@end

@implementation EventManager

+ (EventManager *) sharedManager
{
  static dispatch_once_t pred;
  __strong static id sharedInstance = nil;
  dispatch_once(&pred, ^{
    sharedInstance = [[EventManager alloc] init];
  });
  return sharedInstance;
}

- (id)init {
  if (self = [super init]) {
    _events = [NSMutableArray array];
    
    // TODO: create the dummy event data
    Event *event1 = [[Event alloc] initEventWithTitle:@"Lunch with Jason" andEventDetail:@"Santouka Ramen" andDateTime:[NSDate date] andPartySize:2 andIsPublicEvent:NO];
    Event *event2 = [[Event alloc] initEventWithTitle:@"Lunch with Aaron, Mike" andEventDetail:@"Orenchi Ramen" andDateTime:[NSDate date] andPartySize:3 andIsPublicEvent:NO];
    Event *event3 = [[Event alloc] initEventWithTitle:@"Dinner with mom and dad" andEventDetail:@"Red Lobster" andDateTime:[NSDate date] andPartySize:3 andIsPublicEvent:NO];
    Event *event4 = [[Event alloc] initEventWithTitle:@"Breakfast" andEventDetail:@"Peet's coffee" andDateTime:[NSDate date] andPartySize:5 andIsPublicEvent:YES];
    Event *event5 = [[Event alloc] initEventWithTitle:@"Afternoon tea" andEventDetail:@"Korean Tofu house" andDateTime:[NSDate date] andPartySize:4 andIsPublicEvent:YES];
    [self.events addObject:event1];
    [self.events addObject:event2];
    [self.events addObject:event3];
    [self.events addObject:event4];
    [self.events addObject:event5];
  }
  return self;
}

- (NSArray*)eventsArray {
  return self.events;
}

- (void)addEvent:(Event *)event {
  [self.events addObject:event];
}
@end

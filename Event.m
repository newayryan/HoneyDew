//
//  Event.m
//  HoneyDew
//
//  Created by Wei Liu on 6/25/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "Event.h"

@implementation Event

- (id)initEventWithTitle:(NSString*)title
          andEventDetail:(NSString*)detail
             andDateTime:(NSDate*)dateTime
            andPartySize:(NSInteger)size
        andIsPublicEvent:(BOOL)public {
  if (self = [super init]) {
    _eventTitle = title;
    _eventDetail = detail;
    _eventDateTime = dateTime;
    _eventPartySize = size;
    _isPublicEvent = public;
  }
  return self;
}

+ (NSInteger)numberOfEventProperties {
  return 5;
}

@end

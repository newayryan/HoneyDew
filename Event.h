//
//  Event.h
//  HoneyDew
//
//  Created by Wei Liu on 6/25/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic) NSString *eventTitle;
@property (nonatomic) NSString *eventDetail;
@property (nonatomic) NSDate *eventDateTime;
@property (nonatomic) NSInteger eventPartySize;
@property (nonatomic) BOOL isPublicEvent;

- (id)initEventWithTitle:(NSString*)title
          andEventDetail:(NSString*)detail
             andDateTime:(NSDate*)dateTime
            andPartySize:(NSInteger)size
        andIsPublicEvent:(BOOL)public;
+ (NSInteger)numberOfEventProperties;
@end

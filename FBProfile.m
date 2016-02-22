//
//  Profile.m
//  HoneyDew
//
//  Created by Wei Liu on 7/6/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "FBProfile.h"

@implementation FBProfile

- (id)initWithDict:(NSDictionary*)dict {
  if (self = [super init]) {
    _email = [dict objectForKey:@"email"];
    _firstName = [dict objectForKey:@"first_name"];
    _lastName = [dict objectForKey:@"last_name"];
    _fbPage = [dict objectForKey:@"link"];
    _isMale = [[dict objectForKey:@"gender"] isEqualToString:@"male"];
    _name = [dict objectForKey:@"name"];
    _id = [dict objectForKey:@"id"];
    
    NSDictionary *pictureData = [dict objectForKey:@"picture"];
    if (pictureData) {
      NSDictionary *data = [pictureData objectForKey:@"data"];
      _pictureURLString = [data objectForKey:@"url"];
    }
    
    if (_fbPage && _fbPage.length > 0) {
      _isUser = YES;
    } else {
      _isUser = NO;
    }
  }
  return self;
}
@end

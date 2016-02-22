//
//  ProfileManager.m
//  HoneyDew
//
//  Created by Wei Liu on 7/7/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "ProfileManager.h"

@implementation ProfileManager

+ (ProfileManager *) sharedManager {
  static dispatch_once_t pred;
  __strong static id sharedInstance = nil;
  dispatch_once(&pred, ^{
    sharedInstance = [[ProfileManager alloc] init];
  });
  return sharedInstance;
}

@end

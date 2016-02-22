//
//  HDProfile.m
//  HoneyDew
//
//  Created by Wei Liu on 7/7/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDProfile.h"

@implementation HDProfile

- (id)initWithEmail:(NSString *)email
           withName:(NSString*)name
       withPassword:(NSString*)pwd
            withJob:(NSString*)job
       withLocation:(NSString*)location
            withOrg:(NSString*)organization
     withFoodFlavor:(NSString*)foodFlavor {
  if (self = [super init]) {
    _email = email;
    _name = name;
    _pwd = pwd;
    _jobDescription = job;
    _location = location;
    _organization = organization;
    _foodFlavor = foodFlavor;
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_email forKey:@"email"];
  [aCoder encodeObject:_name forKey:@"name"];
  [aCoder encodeObject:_pwd forKey:@"password"];
  [aCoder encodeObject:_jobDescription forKey:@"jobDescription"];
  [aCoder encodeObject:_location forKey:@"location"];
  [aCoder encodeObject:_organization forKey:@"organization"];
  [aCoder encodeObject:_foodFlavor forKey:@"foodFlavor"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super init]) {
    _email = [aDecoder decodeObjectForKey:@"email"];
    _name = [aDecoder decodeObjectForKey:@"name"];
    _pwd = [aDecoder decodeObjectForKey:@"password"];
    _jobDescription = [aDecoder decodeObjectForKey:@"jobDescription"];
    _location = [aDecoder decodeObjectForKey:@"location"];
    _organization = [aDecoder decodeObjectForKey:@"organization"];
    _foodFlavor = [aDecoder decodeObjectForKey:@"foodFlavor"];
  }
  return self;
}

@end

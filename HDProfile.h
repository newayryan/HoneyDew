//
//  HDProfile.h
//  HoneyDew
//
//  Created by Wei Liu on 7/7/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDProfile : NSObject <NSCoding>

@property (nonatomic) NSString *email;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *pwd;
@property (nonatomic) NSString *jobDescription;
@property (nonatomic) NSString *location;
@property (nonatomic) NSString *organization;
@property (nonatomic) NSString *foodFlavor;

- (id)initWithEmail:(NSString *)email
           withName:(NSString*)name
       withPassword:(NSString*)pwd
            withJob:(NSString*)job
       withLocation:(NSString*)location
            withOrg:(NSString*)organization
     withFoodFlavor:(NSString*)foodFlavor;


@end

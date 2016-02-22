//
//  ProfileManager.h
//  HoneyDew
//
//  Created by Wei Liu on 7/7/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBProfile.h"
#import "HDProfile.h"

@interface ProfileManager : NSObject

@property (nonatomic) FBProfile *userProfile;
@property (nonatomic) HDProfile *appProfile;
@property (nonatomic) NSArray *friendsArray;

+ (ProfileManager *) sharedManager;

@end

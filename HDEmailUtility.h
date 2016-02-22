//
//  HDEmailUtility.h
//  HoneyDew
//
//  Created by Song Wang on 9/19/15.
//  Copyright © 2015 Song Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDEmailUtility : NSObject

+ (BOOL)isValidEmailAddress:(NSString *)emailAddress ;

+ (BOOL) validateEmail:(NSString*) emailAddress ;

@end

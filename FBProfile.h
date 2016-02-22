//
//  Profile.h
//  HoneyDew
//
//  Created by Wei Liu on 7/6/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FBProfile : NSObject

@property (nonatomic) BOOL isUser;
@property (nonatomic) NSString *email;
@property (nonatomic) BOOL isMale;
@property (nonatomic) NSString *fbPage;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) UIImage  *profileImage;
@property (nonatomic) NSDictionary *friendsDict;

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *id;
@property (nonatomic) NSString *pictureURLString;

- (id)initWithDict:(NSDictionary*)dict;

@end

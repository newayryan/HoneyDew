//
//  UIControlManager.h
//  HoneyDew
//
//  Created by Wei Liu on 7/5/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HDControlManager : NSObject

+ (HDControlManager *) sharedManager;
- (void)replaceRootViewControllerWithViewController:(UIViewController *)vc;
- (void)replaceRootViewControllerWithTabController;
- (void)popToRootLoginViewController;
@end

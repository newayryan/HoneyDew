//
//  HDTabBarController.m
//  HoneyDew
//
//  Created by Wei Liu on 8/23/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDTabBarController.h"
#import "iOSMacro.h"
#import "UIColor+Utilities.h"

@implementation HDTabBarController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tabBar.barTintColor = UIColorFromRGB(PRIM_WHITE_COLOR);
  self.tabBar.tintColor = UIColorFromRGB(PRIM_RED_COLOR);
}

@end

//
//  UIControlManager.m
//  HoneyDew
//
//  Created by Wei Liu on 7/5/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDControlManager.h"
#import "HDTabBarController.h"
#import "iOSMacro.h"
#import "UIColor+Utilities.h"
#import "HDEvtViewController.h"
#import "HDInfoViewController.h"
#import "AppDelegate.h"
#import "HDRootFBLoginViewController.h"

@implementation HDControlManager

+ (HDControlManager *) sharedManager {
  static dispatch_once_t pred;
  __strong static id sharedInstance = nil;
  dispatch_once(&pred, ^{
    sharedInstance = [[HDControlManager alloc] init];
  });
  return sharedInstance;
}

- (id)init {
  if (self  = [super init]) {
    [self initGlobalUIAppearance];
  }
  return self;
}

- (void)initGlobalUIAppearance {
  // status bar
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  // navigation bar
  [[UINavigationBar appearance] setTintColor:UIColorFromRGB(PRIM_WHITE_COLOR)];
  [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(PRIM_RED_COLOR)];
  [[UINavigationBar appearance] setTitleTextAttributes:@{
                     NSForegroundColorAttributeName:UIColorFromRGB(PRIM_WHITE_COLOR),     NSFontAttributeName:HelNeueFontOfSize(18)}];
  // tab bar
  [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:HelNeueFontOfSize(11)} forState:UIControlStateNormal];
}

- (void)replaceRootViewControllerWithViewController:(UIViewController*)vc {
  AppDelegate *delegate = [UIApplication sharedApplication].delegate;
  delegate.window.rootViewController = vc;

}

- (void)replaceRootViewControllerWithTabController {
  AppDelegate *delegate = [UIApplication sharedApplication].delegate;
  
  // create sub-tab navigation controller
  HDEvtViewController *hdEvtViewController = [[HDEvtViewController alloc] init];
  UINavigationController *hdEvtNavigationController = [[UINavigationController alloc] initWithRootViewController:hdEvtViewController];
  hdEvtNavigationController.title = @"Events";
  hdEvtNavigationController.tabBarItem.image = [UIImage imageNamed:@"events.png"];
  HDInfoViewController *hdInfoViewController = [[HDInfoViewController alloc] init];
  UINavigationController *hdInfoNavigationController = [[UINavigationController alloc] initWithRootViewController:hdInfoViewController];
  hdInfoNavigationController.title = @"Info";
  hdInfoNavigationController.tabBarItem.image = [UIImage imageNamed:@"info.png"];
  
  delegate.tabBarController = [[HDTabBarController alloc] init];
  delegate.tabBarController.viewControllers = @[hdEvtNavigationController, hdInfoNavigationController];
  delegate.window.rootViewController = delegate.tabBarController;
}

- (void)popToRootLoginViewController {
  AppDelegate *delegate = [UIApplication sharedApplication].delegate;
  HDRootFBLoginViewController *hdRootFBLoginViewController = [[HDRootFBLoginViewController alloc] init];
  delegate.window.rootViewController = hdRootFBLoginViewController;
}
@end

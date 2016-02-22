//
//  AppDelegate.m
//  HoneyDew
//
//  Created by Song Wang on 4/14/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

//FB login code from :http://www.appcoda.com/ios-programming-facebook-login-sdk/

#import "AppDelegate.h"
#import "HDTabBarController.h"
#import "ViewController.h"
#import "ProfileManager.h"
#import "HomeScreenViewController.h"
#import "PublicEventsViewController.h"
#import "SettingsViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "HDEvtViewController.h"
#import "HDInfoViewController.h"
#import "HDRootFBLoginViewController.h"
#import "HDControlManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
  [HDControlManager sharedManager];
  
  // get user profile
  NSData *userProfileData = (NSData *)[[NSUserDefaults standardUserDefaults] objectForKey:@"userProfile"];
  if (userProfileData) {
    [[ProfileManager sharedManager] setAppProfile:[NSKeyedUnarchiver unarchiveObjectWithData:userProfileData]];
  }

  // create sub-tab navigation controller
  HDEvtViewController *hdEvtViewController = [[HDEvtViewController alloc] init];
  UINavigationController *hdEvtNavigationController = [[UINavigationController alloc] initWithRootViewController:hdEvtViewController];
  hdEvtNavigationController.title = @"Events";
  hdEvtNavigationController.tabBarItem.image = [UIImage imageNamed:@"events.png"];
  HDInfoViewController *hdInfoViewController = [[HDInfoViewController alloc] init];
  UINavigationController *hdInfoNavigationController = [[UINavigationController alloc] initWithRootViewController:hdInfoViewController];
  hdInfoNavigationController.title = @"Info";
  hdInfoNavigationController.tabBarItem.image = [UIImage imageNamed:@"info.png"];
  
  self.tabBarController = [[HDTabBarController alloc] init];
  self.tabBarController.viewControllers = @[hdEvtNavigationController, hdInfoNavigationController];
  
  // test facebook
  HDRootFBLoginViewController *hdRootFBLoginViewController = [[HDRootFBLoginViewController alloc] init];
  self.window.rootViewController = hdRootFBLoginViewController;

  return YES;
  
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
  return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

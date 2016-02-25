//
//  HDRootFBLoginViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/30/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDRootFBLoginViewController.h"
#import "HDRootInputInfoViewController.h"
#import "HDControlManager.h"
#import "ProfileManager.h"
#import "FBProfile.h"
#import "UIView+Position.h"
#import "UIColor+Utilities.h"
#import "iOSMacro.h"

#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface HDRootFBLoginViewController ()
@property (nonatomic) UILabel *loginTitle;
@property (nonatomic) FBSDKProfilePictureView *fbProfileImageView;
@property (nonatomic) FBSDKLoginButton *loginButton;
@end

@implementation HDRootFBLoginViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self manuallyLayoutSubviews];
  
  // register notification
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
  
  [self checkFBLogin];
  
  if (![ProfileManager sharedManager].appProfile) {
    HDRootInputInfoViewController *hdRootInputInfoViewController = [[HDRootInputInfoViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:hdRootInputInfoViewController];
    hdRootInputInfoViewController.title = @"Please input your information";
    [self presentViewController:navi animated:YES completion:nil];
  } else {
    
    [[HDControlManager sharedManager] replaceRootViewControllerWithTabController];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];

}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)checkFBLogin {
  // TODO: currently comment this out
  return;
  
  if ([FBSDKAccessToken currentAccessToken]) {
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
      if (!error) {
        NSDictionary *profileDict = (NSDictionary*)result;
        FBProfile *profile = [[FBProfile alloc] initWithDict:profileDict];
        [[ProfileManager sharedManager] setUserProfile:profile];
      }
    }];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/taggable_friends" parameters:nil] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
      if (!error) {
        NSArray *items = [(NSDictionary*)result objectForKey:@"data"];
        NSMutableArray *friendsArray = [NSMutableArray array];
        for (int i = 0; i < items.count; i++) {
          FBProfile *friend = [[FBProfile alloc] initWithDict:items[i]];
          [friendsArray addObject:friend];
        }
        [[ProfileManager sharedManager] setFriendsArray:friendsArray];
      }
    }];
    
    if (![ProfileManager sharedManager].appProfile) {
      HDRootInputInfoViewController *hdRootInputInfoViewController = [[HDRootInputInfoViewController alloc] init];
      UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:hdRootInputInfoViewController];
      hdRootInputInfoViewController.title = @"Please input your information";
      [self presentViewController:navi animated:YES completion:nil];
    } else {
      
      [[HDControlManager sharedManager] replaceRootViewControllerWithTabController];
    }
  }
}

- (void)commonInit {
  self.view.backgroundColor = [UIColor whiteColor];
  _loginTitle = [[UILabel alloc] init];
  _loginTitle.text = @"Log in with your Facebook Account";
  _loginTitle.font = LightHelNeueFontOfSize(18);
  _loginTitle.textColor = UIColorFromRGB(PRIM_BLACK_COLOR);
  _loginTitle.backgroundColor = [UIColor clearColor];
  [self.view addSubview:_loginTitle];
  
  _loginButton = [[FBSDKLoginButton alloc] init];
  _loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
  [self.view addSubview:_loginButton];
  
  _fbProfileImageView = [[FBSDKProfilePictureView alloc] init];
  _fbProfileImageView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:_fbProfileImageView];
}

- (void)manuallyLayoutSubviews {
  _loginTitle.frame = CGRectMake(0, 150, 300, 40);
  [_loginTitle centerHorizontally];
  
  _loginButton.frame = CGRectMake(0, _loginTitle.frameBottomY + 40, 300, 50);
  [_loginButton centerHorizontally];
  
  _fbProfileImageView.frame = CGRectMake(0, _loginButton.frameBottomY + 20, 250, 250);
  [_fbProfileImageView centerHorizontally];
}

- (void)appDidBecomeActive:(NSNotification*)notification {
  [self checkFBLogin];
}
@end

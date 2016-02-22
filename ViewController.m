//
//  ViewController.m
//  HoneyDew
//
//  Created by Song Wang on 4/14/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self toggleHiddenState:YES];
  self.lblLoginStatus.text = @"";
  
  self.loginButton.delegate = self;
  self.loginButton.readPermissions = @[@"public_profile", @"email"];
  
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Private method implementation

-(void)toggleHiddenState:(BOOL)shouldHide{
  self.lblUsername.hidden = shouldHide;
  self.lblEmail.hidden = shouldHide;
  self.profilePicture.hidden = shouldHide;
}


#pragma mark - FBLoginView Delegate method implementation

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
  self.lblLoginStatus.text = @"You are logged in.";
  
  [self toggleHiddenState:NO];
}


-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
  NSLog(@"%@", user);
  self.profilePicture.profileID = user.objectID;
  self.lblUsername.text = user.name;
  self.lblEmail.text = [user objectForKey:@"email"];
}


-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
  self.lblLoginStatus.text = @"You are logged out";
  
  [self toggleHiddenState:YES];
}


-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
  NSLog(@"%@", [error localizedDescription]);
}


@end

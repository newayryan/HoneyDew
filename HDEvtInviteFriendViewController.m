//
//  HDEvtInviteFriendViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/24/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDEvtInviteFriendViewController.h"
#import "ProfileManager.h"
#import "HDEvtInviteFriendViewCell.h"
#import "UIView+Position.h"
#import "UIColor+Utilities.h"
#import "iOSMacro.h"

#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface HDEvtInviteFriendViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *friendsTableView;
@property (nonatomic) NSMutableSet *selectedFriends;
@property (nonatomic) FBSDKShareButton *rightButton;
@end

@implementation HDEvtInviteFriendViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  _selectedFriends = [NSMutableSet set];
  [self updateRightNavigationBarButton];
  [self manuallyLayoutSubviews];
  FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
  NSURL *contentURL = [[NSURL alloc] initWithString:
                       @"http://en.wikipedia.org/wiki/Facebook"];
  
  NSURL *imageURL =
  [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Facebook_Headquarters_Menlo_Park.jpg/2880px-Facebook_Headquarters_Menlo_Park.jpg"];
  content.contentURL = contentURL;
  content.contentTitle = @"My Share Title";
  content.contentDescription = @"Lorem ipsum dolor sit amet.";
  content.imageURL = imageURL;
  content.peopleIDs = @[@"1561082740838259"];
  content.ref = @"myRefId";
  content.placeID = @"166793820034304";
  
  FBSDKShareButton *button = [[FBSDKShareButton alloc] init];
  button.shareContent = content;
  button.center = self.view.center;
  [self.view addSubview:button];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [_selectedFriends removeAllObjects];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

#pragma mark - Table view datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [HDEvtInviteFriendViewCell defaultHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[ProfileManager sharedManager].friendsArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *eventCellIdentifier = @"EventCellIdentifier";
  HDEvtInviteFriendViewCell *cell = (HDEvtInviteFriendViewCell*)[tableView dequeueReusableCellWithIdentifier:eventCellIdentifier];
  if (!cell) {
    cell = [[HDEvtInviteFriendViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellIdentifier];
  }
  
  FBProfile *friend = [[ProfileManager sharedManager].friendsArray objectAtIndex:indexPath.row];
  if ([self.selectedFriends containsObject:friend]) {
    [cell updateSelectedState:YES];
  } else {
    [cell updateSelectedState:NO];
  }
  cell.userName.text = friend.name;
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self updateCellAccessoryViewForIndexPath:indexPath];
  [self updateRightNavigationBarButton];
}

- (void)updateCellAccessoryViewForIndexPath:(NSIndexPath*)indexPath {
  HDEvtInviteFriendViewCell *cell = (HDEvtInviteFriendViewCell*)[self.friendsTableView cellForRowAtIndexPath:indexPath];
  FBProfile *friend = [[ProfileManager sharedManager].friendsArray objectAtIndex:indexPath.row];
  if ([self.selectedFriends containsObject:friend]) {
    [self.selectedFriends removeObject:friend];
    [cell updateSelectedState:NO];
  } else {
    [self.selectedFriends addObject:friend];
    [cell updateSelectedState:YES];
  }
}

#pragma mark - Private methods

- (void)updateRightNavigationBarButton {
  if (!self.rightButton) {
    _rightButton = [[FBSDKShareButton alloc] init];

    _rightButton.frameSize = CGSizeMake(100, 44);
//    _rightButton.titleLabel.font = HelNeueFontOfSize(17);
//    [_rightButton setTitleColor:UIColorFromRGB(PRIM_WHITE_COLOR) forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    UIBarButtonItem *marginItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    marginItem.width = -25;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:marginItem, barButtonItem, nil];
  }
//  
//  NSString *buttonTitle = [NSString stringWithFormat:@"Invite (%lu)", (unsigned long)self.selectedFriends.count];
//  [_rightButton setTitle:buttonTitle forState:UIControlStateNormal];
  self.rightButton.hidden = self.selectedFriends.count == 0;
}

- (void)inviteBtnAction:(id)sender {
  
  FBProfile *testProfile = [self.selectedFriends anyObject];
  FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
  content.peopleIDs = [NSArray arrayWithObjects:testProfile.id, nil];
  content.contentURL = [[NSURL alloc] initWithString:@"http://www.google.com"];
  content.contentTitle = @"Test messenger, if you receive it please let me know, wei";
  content.contentDescription = @"Content description";
  content.placeID = @"166793820034304";
  content.ref = @"MyRefId";
  content.imageURL = nil;
  self.rightButton.shareContent = content;
//  [FBSDKMessageDialog showWithContent:content delegate:nil];

}

- (void)commonInit {
  self.view.backgroundColor = [UIColor whiteColor];
  _friendsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  _friendsTableView.delegate = self;
  _friendsTableView.dataSource = self;
  [self.view addSubview:_friendsTableView];
}

- (void)manuallyLayoutSubviews {
  _friendsTableView.frame = self.view.bounds;
}

@end

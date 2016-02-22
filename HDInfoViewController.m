//
//  HDInfoViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/20/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDInfoViewController.h"
#import "HDControlManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ProfileManager.h"
#import "HDInfoListCell.h"
#import "UIColor+Utilities.h"
#import "iOSMacro.h"
#import "UIView+Position.h"
#import "HDInfoKeyboardAssistView.h"
#import "HDEmailUtility.h"

#define FBButtonTag 100

@interface HDInfoViewController () <KeyboardAssistDelegate>
@property (nonatomic) UITableView *infoTableView;
@property (nonatomic) NSMutableArray *dataModel;
@property (nonatomic) UIBarButtonItem *btnEdit;
@property (nonatomic) UIBarButtonItem *btnDone;
@end

@implementation HDInfoViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self loadUserInfo];
  [self manuallyLayoutSubviews];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

#pragma mark - keyboard notifications

- (void)keyboardWillShow:(NSNotification*)notification {
  CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.infoTableView.contentInset.top, 0.0, keyboardSize.height + kToolbarAssistViewHeight, 0.0);
  self.infoTableView.contentInset = contentInsets;
  self.infoTableView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification *)notification {
  UIEdgeInsets tableViewInsets = UIEdgeInsetsMake(self.infoTableView.contentInset.top, 0, 0, 0);
  self.infoTableView.contentInset = tableViewInsets;
  self.infoTableView.scrollIndicatorInsets = tableViewInsets;
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.dataModel count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[self.dataModel objectAtIndex:section] allKeys] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *eventCellIdentifier = @"InfoCellIdentifier";
  HDInfoListCell *cell = (HDInfoListCell*)[tableView dequeueReusableCellWithIdentifier:eventCellIdentifier];
  if (!cell) {
    cell = [[HDInfoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellIdentifier];
    HDInfoKeyboardAssistView *assistView = [[HDInfoKeyboardAssistView alloc] initWithFrame:CGRectMake(0, 0, self.view.frameWidth, kToolbarAssistViewHeight)];
    assistView.delegate = self;
    cell.cellTF.inputAccessoryView = assistView;
  }

  NSDictionary *sectionData = [self.dataModel objectAtIndex:indexPath.section];
  NSString *cellString = [[sectionData allKeys] objectAtIndex:indexPath.row];
  cell.cellLabel.text = cellString;
  NSString* input = [sectionData objectForKey:cellString];
  cell.cellTF.text = input;
    
//  if ([cellString isEqualToString:@"Email Address"]) {
//    if ([HDEmailUtility validateEmail:input]) {
//        cell.cellTF.text = input;
//    }
//    else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Alert"
//                                                        message:@"You have entered an invalid Email address"
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
//  }
//  else if ([cellString isEqualToString:@"Name"]) {
//    if (![input isEqualToString:@""]) {
//        cell.cellTF.text = input;
//    }
//  }
//  else if ([cellString isEqualToString:@"Password"]) {
//    cell.cellTF.secureTextEntry = !cell.cellTF.secureTextEntry;
//    cell.cellTF.text = input;
//  }
//  else if ([cellString isEqualToString:@"Food Flavor"]) {
//    if (![input isEqualToString:@""]){
//        cell.cellTF.text =input;
//    }
//  }
//  else  {
//    cell.cellTF.text = input;
//  }
//  NSLog(@"the current input text is:%@", cell.cellTF.text);
    
  return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [HDInfoListCell defaultHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  if (section == self.dataModel.count - 1) {
    return 60;
  } else {
    return 0;
  }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  if (section == self.dataModel.count - 1) {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.infoTableView.frameWidth, 50)];
    containerView.backgroundColor = [UIColor clearColor];
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(0, 20, self.infoTableView.frameWidth, 40);
    logoutButton.backgroundColor = UIColorFromRGB(PRIM_RED_COLOR);
    [logoutButton setTitle:@"Sign Out" forState:UIControlStateNormal];
    [logoutButton.titleLabel setFont:MediumHelNeueFontOfSize(15)];
    [logoutButton setTitleColor:UIColorFromRGB(PRIM_WHITE_COLOR) forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logOutFB:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:logoutButton];
    [logoutButton centerHorizontally];
    return containerView;
  } else {
    return nil;
  }
}

#pragma mark - KeyboardAssistDelegate

- (void)previousBtnAction {
  NSMutableArray *cells = [NSMutableArray array];
  for (NSInteger j = [self.infoTableView numberOfSections] - 1; j >= 0; --j) {
    for (NSInteger i = [self.infoTableView numberOfRowsInSection:j] - 1; i >= 0 ; --i) {
      HDInfoListCell *cell = (HDInfoListCell*)[self.infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
      if (cell)
        [cells addObject:[self.infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]]];
    }
  }
  BOOL findFirstResponder = NO;
  for (HDInfoListCell *cell in cells) {
    if (findFirstResponder) {
      [cell.cellTF becomeFirstResponder];
      return;
    }
    if ([cell.cellTF isFirstResponder]) {
      findFirstResponder = YES;
    }
  }
  if (findFirstResponder) {
    HDInfoListCell *cell = (HDInfoListCell*)[cells objectAtIndex:0];
    [cell.cellTF becomeFirstResponder];
  }
}

- (void)nextBtnAction {
  NSMutableArray *cells = [NSMutableArray array];
  for (NSInteger j = 0; j < [self.infoTableView numberOfSections]; ++j) {
    for (NSInteger i = 0; i < [self.infoTableView numberOfRowsInSection:j]; ++i) {
      HDInfoListCell *cell = (HDInfoListCell*)[self.infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
      if (cell)
        [cells addObject:cell];
    }
  }
  BOOL findFirstResponder = NO;
  for (HDInfoListCell *cell in cells) {
    if (findFirstResponder) {
      [cell.cellTF becomeFirstResponder];
      return;
    }
    if ([cell.cellTF isFirstResponder]) {
      findFirstResponder = YES;
    }
  }
  if (findFirstResponder) {
    HDInfoListCell *cell = (HDInfoListCell*)[cells objectAtIndex:0];
    [cell.cellTF becomeFirstResponder];
  }
}

- (void)doneBtnAction {
  [self.view endEditing:YES];
  [self setNavigationBarButtonItem:[self createButtonEdit]];
}

#pragma mark - Private methods

- (void)logOutFB:(id)sender {
  [[FBSDKLoginManager new] logOut];
  // back to login screen
  [[HDControlManager sharedManager] popToRootLoginViewController];
}

- (void)commonInit {
  _infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  _infoTableView.allowsSelection = NO;
  _infoTableView.delegate = self;
  _infoTableView.dataSource = self;
  
  _infoTableView.backgroundColor = UIColorFromRGB(ACCENT_1_WHITE_COLOR);
  self.view.backgroundColor = UIColorFromRGB(ACCENT_1_WHITE_COLOR);
  [self.view addSubview:_infoTableView];
  
  _dataModel = [NSMutableArray array];
}

- (void)loadUserInfo {
  [_dataModel removeAllObjects];
  HDProfile *appProfile = [ProfileManager sharedManager].appProfile;
  
  NSDictionary *personInfo = @{@"Email Address":appProfile.email, @"Name":appProfile.name, @"Password":appProfile.pwd};
  NSDictionary *jobInfo = @{@"Title":appProfile.jobDescription, @"Location":appProfile.location, @"Organization":appProfile.organization};
  NSDictionary *foodInfo = @{@"Food Flavor":appProfile.foodFlavor};
  
  [_dataModel addObject:personInfo];
  [_dataModel addObject:jobInfo];
  [_dataModel addObject:foodInfo];
}

- (void)manuallyLayoutSubviews {
  [self setTitle:@"Info"];
  UIEdgeInsets tableViewInsets = UIEdgeInsetsMake(0, 10, 0, 10);
  _infoTableView.frame = UIEdgeInsetsInsetRect(self.view.bounds, tableViewInsets);
  [self setNavigationBarButtonItem:[self createButtonEdit]];
}

-(void)setNavigationBarButtonItem:(UIBarButtonItem*)button
{
    self.navigationItem.rightBarButtonItem = button;
}

-(UIBarButtonItem*)createButtonEdit
{
    if (!self.btnEdit) {
        self.btnEdit = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                        style:UIBarButtonItemStyleBordered
                                                       target:self
                                                       action:@selector(editButtonTapped:)];
    }
    return self.btnEdit;
}

-(UIBarButtonItem*)createButtonDone {
    if (!self.btnDone) {
        self.btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                        style:UIBarButtonItemStyleBordered
                                                       target:self
                                                       action:@selector(doneButtonTapped:)];
    }
    return self.btnDone;
}


- (void)editButtonTapped:(id)sender {
    //jump to the first cell
    HDInfoListCell *cell = (HDInfoListCell*)[self.infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.cellTF becomeFirstResponder];
    [self setNavigationBarButtonItem:[self createButtonDone]];
}

- (void)doneButtonTapped:(id)sender {
    [self setNavigationBarButtonItem:[self createButtonEdit]];
    [self.view endEditing:YES];
}


@end

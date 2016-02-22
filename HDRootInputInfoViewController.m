//
//  HDRootInputInfoViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 7/1/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDRootInputInfoViewController.h"
#import "HDControlManager.h"
#import "ProfileManager.h"
#import "HDProfile.h"
#import "UIView+Position.h"
#import "UIColor+Utilities.h"
#import "iOSMacro.h"
#import "HDEvtCreateViewCell.h"

@interface HDRootInputInfoViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *infoTableView;
@property (nonatomic) NSArray *placeHolderArray;
@property (nonatomic) UITextField *activeTF;
@property (nonatomic) CGFloat keyboardHeight;
@end

@implementation HDRootInputInfoViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if ([ProfileManager sharedManager].appProfile) {
    [[HDControlManager sharedManager] replaceRootViewControllerWithTabController];
  }
  [self addObservers];
  [self manuallyLayoutSubviews];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self removeObservers];
  [self.infoTableView endEditing:YES];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

#pragma mark - UITableView delegate

#pragma mark - UITableView datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [HDEvtCreateViewCell defaultHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_placeHolderArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *eventCellIdentifier = @"InputInfoCellIdentifier";
  HDEvtCreateViewCell *cell = (HDEvtCreateViewCell*)[tableView dequeueReusableCellWithIdentifier:eventCellIdentifier];
  if (!cell) {
    cell = [[HDEvtCreateViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellIdentifier];
  }
  cell.cellTF.placeholder = [self.placeHolderArray objectAtIndex:indexPath.row];
  cell.cellTF.delegate = self;
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.infoTableView.frameWidth, 50)];
  containerView.backgroundColor = [UIColor clearColor];
  UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  createBtn.frame = CGRectMake(0, 20, self.infoTableView.frameWidth, 40);
  createBtn.backgroundColor = UIColorFromRGB(PRIM_GREEN_COLOR);
  [createBtn setTitle:@"Confirm" forState:UIControlStateNormal];
  [createBtn.titleLabel setFont:MediumHelNeueFontOfSize(15)];
  [createBtn setTitleColor:UIColorFromRGB(PRIM_WHITE_COLOR) forState:UIControlStateNormal];
  [createBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
  [containerView addSubview:createBtn];
  [createBtn centerHorizontally];
  return containerView;
}

- (void)confirmAction:(id)sender {
  NSMutableArray *resultArray = [NSMutableArray array];
  for (int i = 0; i < [self.placeHolderArray count]; i++) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
    HDEvtCreateViewCell *cell = (HDEvtCreateViewCell*)[self.infoTableView cellForRowAtIndexPath:indexPath];
    NSString *result = cell.cellTF.text;
    [resultArray addObject:result];
  }
  
  HDProfile *profile = [[HDProfile alloc] initWithEmail:resultArray[0] withName:resultArray[1] withPassword:resultArray[2] withJob:resultArray[3] withLocation:resultArray[4] withOrg:resultArray[5] withFoodFlavor:resultArray[6]];
  [[ProfileManager sharedManager] setAppProfile:profile];
  [self.view endEditing:YES];
  // save it to user default
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:profile];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userProfile"];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
  [[HDControlManager sharedManager] replaceRootViewControllerWithTabController];
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  _activeTF = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  _activeTF = nil;
}

#pragma mark - Private methods

- (void)addObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeObservers {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardDidShow:(NSNotification*)notification {
  NSDictionary *info = [notification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  self.keyboardHeight = kbSize.height;
  
  UIEdgeInsets contentInsets = self.infoTableView.contentInset;
  contentInsets.bottom = kbSize.height;
  self.infoTableView.contentInset = contentInsets;
  self.infoTableView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification*)notification {
  UIEdgeInsets contentInsets = self.infoTableView.contentInset;
  self.keyboardHeight = 0;
  contentInsets.bottom = 0;
  self.infoTableView.contentInset = contentInsets;
  self.infoTableView.scrollIndicatorInsets = contentInsets;
}

- (void)commonInit {
  _placeHolderArray = @[@"Email address", @"Name", @"Password", @"Job", @"Location", @"Organization", @"Food flavor"];
  _infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  _infoTableView.backgroundColor = [UIColor clearColor];
  _infoTableView.delegate = self;
  _infoTableView.dataSource = self;
  [self.view addSubview:_infoTableView];
  
  self.view.backgroundColor = UIColorFromRGB(ACCENT_1_WHITE_COLOR);
}

- (void)manuallyLayoutSubviews {
  _infoTableView.frame = UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(0, 10, self.keyboardHeight, 10));
}

@end

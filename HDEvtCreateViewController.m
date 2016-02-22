//
//  HDEvtCreateViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/21/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDEvtCreateViewController.h"
#import "HDEvtInviteFriendViewController.h"
#import "UIView+Position.h"
#import "EventManager.h"
#import "HDEvtCreateViewCell.h"
#import "HDEvtCreateViewIsPublicCell.h"
#import "UIColor+Utilities.h"
#import "iOSMacro.h"

#define kOFFSET_FOR_KEYBOARD  80.0

@interface HDEvtCreateViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITextField *currentTextField;

@property (nonatomic) UIDatePicker *eventDateTimePicker;

@property (nonatomic) UILabel *eventPartySizeLabel;
@property (nonatomic) UITextField *eventPartySizeTF;
@property (nonatomic) UIPickerView *eventPartySizePickerView;

@property (nonatomic) UILabel *eventPublicSwitchLabel;
@property (nonatomic) UISwitch *isPubSwitch;

@property (nonatomic) UIButton *inviteFriendButton;

@property (nonatomic) NSArray *partySizeArray;


@property (nonatomic) NSDate *selectedDate;
@property (nonatomic) NSInteger selectedSize;

@property (nonatomic) UITableView *evtTableView;
@property (nonatomic) NSArray *evtPlaceHolderArray;
@end

@implementation HDEvtCreateViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self manuallyLayoutSubviews];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"Create Event";
  
  [self addNotifications];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableView delegate

#pragma mark - UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return [self.evtPlaceHolderArray count];
  }
  else return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    static NSString *eventCellIdentifier = @"CreateEventCellIdentifier";
    HDEvtCreateViewCell *cell = (HDEvtCreateViewCell*)[tableView dequeueReusableCellWithIdentifier:eventCellIdentifier];
    if (!cell) {
      cell = [[HDEvtCreateViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellIdentifier];
    }
    cell.cellTF.placeholder = [self.evtPlaceHolderArray objectAtIndex:indexPath.row];
    cell.cellTF.delegate = self;
    if (indexPath.row == 1) {
      cell.cellTF.inputView = self.eventDateTimePicker;
    } else if (indexPath.row == 2) {
      cell.cellTF.inputView = self.eventPartySizePickerView;
    } else {
      cell.cellTF.inputView = nil;
    }
    return cell;
  } else {
    static NSString *eventCellPublicIdentifier = @"CreateEventCellPublicIdentifier";
    HDEvtCreateViewIsPublicCell *cell = (HDEvtCreateViewIsPublicCell*)[tableView dequeueReusableCellWithIdentifier:eventCellPublicIdentifier];
    if (!cell) {
      cell = [[HDEvtCreateViewIsPublicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellPublicIdentifier];
    }
    cell.cellTitle.text = @"Is this a public event?";
    return cell;
  }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  if (section == 1) {
    return 60;
  } else {
    return 0;
  }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  if (section == 1) {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.evtTableView.frameWidth, 50)];
    containerView.backgroundColor = [UIColor clearColor];
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    createBtn.frame = CGRectMake(0, 20, self.evtTableView.frameWidth, 40);
    createBtn.backgroundColor = UIColorFromRGB(PRIM_GREEN_COLOR);
    [createBtn setTitle:@"Create event and Invite friends" forState:UIControlStateNormal];
    [createBtn.titleLabel setFont:MediumHelNeueFontOfSize(15)];
    [createBtn setTitleColor:UIColorFromRGB(PRIM_WHITE_COLOR) forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createAndInvite:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:createBtn];
    [createBtn centerHorizontally];
    return containerView;
  } else {
    return nil;
  }
}

- (void)createAndInvite:(id)sender {
//  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//  NSString *evtName = ((HDEvtCreateViewCell*)[self.evtTableView cellForRowAtIndexPath:indexPath]).cellTF.text;
//  indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//  NSString *evtDT = ((HDEvtCreateViewCell*)[self.evtTableView cellForRowAtIndexPath:indexPath]).cellTF.text;
//  indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
//  NSString *evtSize = ((HDEvtCreateViewCell*)[self.evtTableView cellForRowAtIndexPath:indexPath]).cellTF.text;
//  indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//  BOOL isPublic = ((HDEvtCreateViewIsPublicCell*)[self.evtTableView cellForRowAtIndexPath:indexPath]).cellIsPublicSwitch.isOn;
//  
//  if ([evtName isEqualToString:@""] || [evtDT isEqualToString:@""] || [evtSize isEqualToString:@""]) {
//    return;
//  }
//  
//  // create event
//  
//  Event *newEvent = [[Event alloc] initEventWithTitle:evtName andEventDetail:@"no detail" andDateTime:self.selectedDate andPartySize:self.selectedSize andIsPublicEvent:isPublic];
//  [[EventManager sharedManager] addEvent:newEvent];
  
  HDEvtInviteFriendViewController *hdEvtInviteFriendViewController = [[HDEvtInviteFriendViewController alloc] init];
  [self.navigationController pushViewController:hdEvtInviteFriendViewController animated:YES];
}

#pragma mark - UIPickerView data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return [self.partySizeArray count];;
}

#pragma mark - UIPickerView delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  NSInteger selectedRow = [pickerView selectedRowInComponent:component];
  NSString *selectedPickerRow = [self.partySizeArray objectAtIndex:selectedRow];
  self.currentTextField.text = selectedPickerRow;
  self.selectedSize = row + 1;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return (NSString*)[self.partySizeArray objectAtIndex:row];
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  self.currentTextField = textField;
  
  // prefill
  if (textField.text.length == 0) {
    if (textField.inputView == self.eventDateTimePicker) {
      self.currentTextField.text = [self formatDate: self.eventDateTimePicker.date];
      self.selectedDate = self.eventDateTimePicker.date;
    } else if (textField.inputView == self.eventPartySizePickerView) {
      NSString *selectedPickerRow = [self.partySizeArray objectAtIndex:0];
      self.currentTextField.text = selectedPickerRow;
      self.selectedSize = 0 + 1;
    }
  }
}


#pragma mark - Private methods

- (void)addNotifications {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)commonInit {
  self.view.backgroundColor = UIColorFromRGB(ACCENT_1_WHITE_COLOR);
  
  _evtTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  _evtTableView.delegate = self;
  _evtTableView.dataSource = self;
  _evtTableView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:_evtTableView];
  
  _evtPlaceHolderArray = @[@"Event name:", @"Event time:", @"Party size"];
  
  _eventDateTimePicker = [[UIDatePicker alloc] init];
  [_eventDateTimePicker setDatePickerMode:UIDatePickerModeDateAndTime];
  [_eventDateTimePicker addTarget:self action:@selector(updateDateTimeTF:) forControlEvents:UIControlEventValueChanged];
  
  _eventPartySizeLabel = [[UILabel alloc] init];
  _eventPartySizeLabel.text = @"Party size:";
  _eventPartySizeLabel.backgroundColor = [UIColor clearColor];
  _eventPartySizeLabel.textColor = [UIColor blackColor];
  _eventPartySizePickerView = [[UIPickerView alloc] init];
  _eventPartySizePickerView.dataSource = self;
  _eventPartySizePickerView.delegate = self;
  _eventPartySizePickerView.showsSelectionIndicator = YES;
  _eventPartySizeTF = [[UITextField alloc] init];
  _eventPartySizeTF.borderStyle = UITextBorderStyleLine;
  _eventPartySizeTF.inputView = _eventPartySizePickerView;
  
  _eventPublicSwitchLabel = [[UILabel alloc] init];
  _eventPublicSwitchLabel.text = @"Is this Public Event?";
  _eventPublicSwitchLabel.backgroundColor = [UIColor clearColor];
  _eventPublicSwitchLabel.textColor = [UIColor blackColor];
  _isPubSwitch = [[UISwitch alloc] init];
  
  _partySizeArray = @[@"just myself", @"you and me", @"three guys", @"four brothers", @"five dudes", @"more than six"];
}

- (void)manuallyLayoutSubviews {
  _evtTableView.frame = UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(10, 10, 10, 10));
}

- (void)updateDateTimeTF:(id)sender {
  
  self.currentTextField.text = [self formatDate: _eventDateTimePicker.date];
  self.selectedDate = _eventDateTimePicker.date;
}

- (NSString*)formatDate:(NSDate*)date {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterShortStyle];
  [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
  NSString *formattedDateTime = [dateFormatter stringFromDate:date];
  return formattedDateTime;
}

#pragma mark - Keyboard notification

- (void)keyboardWillShow:(NSNotification *)n {

}

- (void)keyboardWillHide:(NSNotification *)n {

}
@end

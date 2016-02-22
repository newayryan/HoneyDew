//
//  HDEvtDetailViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/24/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDEvtDetailViewController.h"
#import "UIView+Position.h"
#import "iOSMacro.h"
#import "HDInfoListCell.h"
#import "UIColor+Utilities.h"

@interface HDEvtDetailViewController ()

@property (nonatomic) Event *event;

@property (nonatomic) UITableView *evtDetailTableView;
@end

@implementation HDEvtDetailViewController

- (id)initWithEvent:(Event *)event {
  if (self = [super init]) {
    _event = event;
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
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [Event numberOfEventProperties];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [HDInfoListCell defaultHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *eventCellIdentifier = @"InfoCellIdentifier";
  HDInfoListCell *cell = (HDInfoListCell*)[tableView dequeueReusableCellWithIdentifier:eventCellIdentifier];
  if (!cell) {
    cell = [[HDInfoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellIdentifier];
  }
  
  [self configureCell:cell forIndex:indexPath];
  
  return cell;
}

- (void)configureCell:(HDInfoListCell*)cell forIndex:(NSIndexPath*)index {
  switch (index.row) {
    case 0:
    {
      cell.cellLabel.text = @"Event name";
      cell.cellTF.text = [self.event eventTitle];
    }
      break;
    case 1:
    {
      cell.cellLabel.text = @"Event detail";
      cell.cellTF.text = [self.event eventDetail];
    }
      break;
    case 2:
    {
      NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
      [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
      cell.cellLabel.text = @"Event time";
      cell.cellTF.text = [formatter stringFromDate:self.event.eventDateTime];
    }
      break;
    case 3:
    {
      cell.cellLabel.text = @"Party size";
      cell.cellTF.text = [NSString stringWithFormat:@"%ld", (long)self.event.eventPartySize];
    }
      break;
    case 4:
    {
      cell.cellLabel.text = @"Is Public";
      cell.cellTF.text = self.event.isPublicEvent ? @"YES" : @"NO";
    }
      break;
    default:
      break;
  }
  cell.cellTF.userInteractionEnabled = NO;
}

#pragma mark - Private methods

- (void)commonInit {
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"Event Detail";
  
  _evtDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  _evtDetailTableView.allowsSelection = NO;
  _evtDetailTableView.delegate = self;
  _evtDetailTableView.dataSource = self;
  
  _evtDetailTableView.backgroundColor = UIColorFromRGB(ACCENT_1_WHITE_COLOR);
  self.view.backgroundColor = UIColorFromRGB(ACCENT_1_WHITE_COLOR);
  [self.view addSubview:_evtDetailTableView];
}

- (void)manuallyLayoutSubviews {
  UIEdgeInsets tableViewInsets = UIEdgeInsetsMake(0, 10, 0, 10);
  _evtDetailTableView.frame = UIEdgeInsetsInsetRect(self.view.bounds, tableViewInsets);
  
}

@end

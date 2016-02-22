//
//  HDEvtViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/20/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDEvtViewController.h"
#import "HDEvtCreateViewController.h"
#import "HDEvtDetailViewController.h"
#import "HDEvtListCell.h"
#import "EventManager.h"

@interface HDEvtViewController ()
@property (nonatomic) UITableView *eventTableView;
@end

@implementation HDEvtViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self.eventTableView reloadData];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self manuallyLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[EventManager sharedManager].eventsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [HDEvtListCell defaultHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *eventCellIdentifier = @"EventCellIdentifier";
  HDEvtListCell *cell = (HDEvtListCell*)[tableView dequeueReusableCellWithIdentifier:eventCellIdentifier];
  if (!cell) {
    cell = [[HDEvtListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventCellIdentifier];
  }
  
  Event *currentEvent = [[EventManager sharedManager].eventsArray objectAtIndex:indexPath.row];
  
  // TODO: configure the cell
  cell.evtName.text = currentEvent.eventTitle;
  cell.evtDetail.text = currentEvent.eventDetail;
  cell.evtPublicLabel.text = currentEvent.isPublicEvent ? @"Public" : @"Private";
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  HDEvtDetailViewController *hdEvtDetailViewController = [[HDEvtDetailViewController alloc] initWithEvent:[[EventManager sharedManager].eventsArray objectAtIndex:indexPath.row]];
  [self.navigationController pushViewController:hdEvtDetailViewController animated:YES];
}


#pragma mark - Private methods

- (void)commonInit {
  _eventTableView = [[UITableView alloc] init];
  _eventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  _eventTableView.delegate = self;
  _eventTableView.dataSource = self;
  [self.view addSubview:_eventTableView];
}

- (void)manuallyLayoutSubviews {
  [self setTitle:@"Events"];
  _eventTableView.frame = self.view.bounds;
  
  // create right bar item
  UIBarButtonItem *add=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createButtonTapped:)];
  self.navigationItem.rightBarButtonItem = add;
}

- (void)createButtonTapped:(id)sender {
  HDEvtCreateViewController *hdEvtCreateViewController = [[HDEvtCreateViewController alloc] init];
  [self.navigationController pushViewController:hdEvtCreateViewController animated:YES];
}

@end

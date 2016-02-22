//
//  RsrtMoreViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/6/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "RsrtMoreViewController.h"

@interface RsrtMoreViewController ()
@property (nonatomic) UITableView *moreTableView;
@property (nonatomic) NSDictionary *moreDataDict;
@end

@implementation RsrtMoreViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [self manuallyLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self.moreDataDict allKeys] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *moreCellIdentifier = @"MoreCellIdentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:moreCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  
  NSString *key = [[self.moreDataDict allKeys] objectAtIndex:indexPath.row];
  cell.textLabel.text = key;
  cell.detailTextLabel.text = [self.moreDataDict objectForKey:key];
  
  return cell;
}

- (void)commonInit {
  _moreTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  _moreTableView.delegate = self;
  _moreTableView.dataSource = self;
  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:_moreTableView];
  
  _moreDataDict = @{@"Menu":@"http://www.jxcuisine.com/menu.asp",
                    @"Hours":@"Mon-Sun 11 am - 10 pm",
                    @"Website":@"http://www.jxcuisine.com",
                    @"Takes Reservations":@"No",
                    @"Delivery":@"No",
                    @"Take-out":@"Yes",
                    @"Outdoor Seating":@"Yes",
                    @"Ambience":@"Casual",
                    @"Noise Level":@"Average",
                    @"Attire":@"Casual",
                    @"Good for Groups":@"Yes",
                    @"Good for Kids":@"Yes",
                    @"Accepts Credit Cards":@"Yes",
                    @"Parking":@"Private Lot, Street",
                    @"Wi-Fi":@"Free"};
}

- (void)manuallyLayoutSubviews {
  _moreTableView.frame = self.view.bounds;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  RsrtDishViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 6/3/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "RsrtDishViewController.h"
#import "DishTableViewCell.h"

@interface RsrtDishViewController ()
@property (nonatomic) UITableView *dishesTableView;
@end

@implementation RsrtDishViewController

- (id)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
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
  return 10;
}

- (void)commonInit {
  _dishesTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  _dishesTableView.dataSource = self;
  _dishesTableView.delegate = self;
  _dishesTableView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:_dishesTableView];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *detailCellIdentifier = @"DetailCellIdentifier";
  DishTableViewCell *cell = (DishTableViewCell*)[tableView dequeueReusableCellWithIdentifier:detailCellIdentifier];
  if (cell == nil) {
    cell = [[DishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellIdentifier];
  }
  
  // update cell content -- this should be done in the view
  cell.dishView.image = [UIImage imageNamed:@"dish.png"];
  cell.dishPrice.text = @"$10.00";
  cell.dishLabel.text = @"Boiled Fish Fillet in Hot Sauce";
  cell.dishDescription.text = @"Boiled Fish Fillet in Hot Sauce , very expansive and spicy";
  return cell;
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80;
}

- (void)manuallyLayoutSubviews {
  self.dishesTableView.frame = self.view.bounds;
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

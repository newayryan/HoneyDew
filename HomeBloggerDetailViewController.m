//
//  HomeBloggerDetailViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 5/5/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HomeBloggerDetailViewController.h"
#import "BloggerDetailTableViewCell.h"
#import "RsrtDishViewController.h"
#import "RsrtMoreViewController.h"
#import "BloggerMapViewController.h"
#import "RsrtImagesTableViewCell.h"

const static CGFloat kBorderLRMargin = 10;
const static CGFloat kRatingStarMargin = 5;
const static CGFloat kBorderTopMargin = 20;

@interface HomeBloggerDetailViewController () <BloggerCellDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *ratingReviewBgView;
@property (nonatomic, strong) NSMutableArray *ratingStarArray;
@property (nonatomic, strong) UILabel *ratingReviewLabel;
@property (nonatomic, strong) UILabel *rstrtNameLabel;
@property (nonatomic, strong) UILabel *rstrtSummaryLabel;
@property (nonatomic, strong) UILabel *openHourLabel;
@property (nonatomic, strong) UITableView *detailTableView;
@property (nonatomic, strong) CLLocation *currentLocation;
@end

@implementation HomeBloggerDetailViewController

- (id)init {
  if (self = [super init]) {
    [self createUI];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self updateUIWithData];
  [self manuallyLayoutSubviews];
  
  self.locationManager = [[CLLocationManager alloc]init];
  self.locationManager.delegate = self;
  self.locationManager.distanceFilter = kCLDistanceFilterNone;
  self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  [self.locationManager startUpdatingLocation];
  
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    [self.locationManager requestWhenInUseAuthorization];
  
  [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - location delegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
  NSLog(@"didFailWithError: %@", error);
  UIAlertView *errorAlert = [[UIAlertView alloc]
                             initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
  self.currentLocation = newLocation;
}

#pragma mark - Blogger cell delegate
- (void)mapCellTappedAtRegion:(MKCoordinateRegion)region{
  BloggerMapViewController *mapViewController = [[BloggerMapViewController alloc] initWithRegion:region];
  mapViewController.view.frame = self.view.bounds;
  [self.navigationController pushViewController:mapViewController animated:YES];
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  switch (indexPath.section) {
    case BloggerCellSectionTypeMap:
    {
      [self selectMapSectionRow:indexPath.row];
    }
      break;
    case BloggerCellSectionTypeInfo:
    {
      [self selectInfoSectionRow:indexPath.row + 3];
    }
      break;
    case BloggerCellSectionImage:
    {
      [self selectImageSectionRow:indexPath.row + 7];
    }
      break;
    default:
      break;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == BloggerCellSectionImage) {
    return [RsrtImagesTableViewCell heightOfImageCell];
  }
  return [BloggerDetailTableViewCell heightForCellWithType:indexPath.row atSection:indexPath.section];
}

- (void)selectMapSectionRow:(NSInteger)row {
  switch (row) {
    case BloggerDetailCellTypeMapView:
    {
      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:BloggerDetailCellTypeMapView inSection:BloggerCellSectionTypeMap];
      BloggerDetailTableViewCell *detailCell = (BloggerDetailTableViewCell *)[self.detailTableView cellForRowAtIndexPath:indexPath];
      [detailCell mapTapped];
    }
      break;
    case BloggerDetailCellTypeMapDirection:
    {
      // this uses an address for the destination.  can use lat/long, too with %f,%f format
      MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: self.currentLocation.coordinate addressDictionary: nil];
      MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
      destination.name = @"1133 Lawrence Expy, Sunnyvale, CA 94089";
      NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
      NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
                               MKLaunchOptionsDirectionsModeDriving,
                               MKLaunchOptionsDirectionsModeKey, nil];
      [MKMapItem openMapsWithItems: items launchOptions: options];
    }
      break;
    case BloggerDetailCellTypeMapText:
    {
      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:BloggerDetailCellTypeMapView inSection:BloggerCellSectionTypeMap];
      BloggerDetailTableViewCell *detailCell = (BloggerDetailTableViewCell *)[self.detailTableView cellForRowAtIndexPath:indexPath];
      [detailCell mapTapped];
    }
      break;
    default:
      break;
  }
}

- (void)selectInfoSectionRow:(NSInteger)row {
  switch (row) {
    case BloggerDetailCellTypeCall:
    {
      // TODO: need test it on real device
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://2135554321"]];
    }
      break;
    case BloggerDetailCellTypeMainMenu:
    {
      RsrtDishViewController *rsrtDishViewController = [[RsrtDishViewController alloc] init];
      [self.navigationController pushViewController:rsrtDishViewController animated:YES];
    }
      break;
    case BloggerDetailCellTypeMore:
    {
      RsrtMoreViewController *rsrtMoreViewController = [[RsrtMoreViewController alloc] init];
      [self.navigationController pushViewController:rsrtMoreViewController animated:YES];
    }
      break;
    case BloggerDetailCellTypePrice:
    {
      
    }
      break;
    default:
      break;
  }
}

- (void)selectImageSectionRow:(NSInteger)row {
  
}

#pragma mark - UITableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case BloggerCellSectionTypeMap:
      return 3;
      break;
    case BloggerCellSectionTypeInfo:
      return 4;
      break;
    case BloggerCellSectionImage:
      return 1;
    default:
      break;
  }
  return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.section == BloggerCellSectionImage) {
    static NSString *imagesCellIdentifier = @"ImagesCellIdentifier";
    RsrtImagesTableViewCell *cell = (RsrtImagesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:imagesCellIdentifier];
    if (cell == nil) {
      cell = [[RsrtImagesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imagesCellIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
  }
  
  static NSString *detailCellIdentifier = @"DetailCellIdentifier";
  BloggerDetailTableViewCell *cell = (BloggerDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:detailCellIdentifier];
  if (cell == nil) {
    cell = [[BloggerDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellIdentifier];
    cell.delegate = self;
  }
  
  switch (indexPath.section) {
    case BloggerCellSectionTypeMap:
    {
      [cell configureMapCellForType:indexPath.row];
    }
      break;
    case BloggerCellSectionTypeInfo:
    {
      [cell configureInfoCellForType:indexPath.row + 3];
    }
      break;
    default:
      break;
  }
  
  cell.backgroundColor = [UIColor whiteColor];
  return cell;
}

#pragma mark - private methods
- (void)createUI {
  _mainScrollView = [[UIScrollView alloc] init];
  _mainScrollView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
  
  _rstrtNameLabel = [[UILabel alloc] init];
  _rstrtNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"  size:25];
  _rstrtNameLabel.textColor = [UIColor blackColor];
  _rstrtNameLabel.backgroundColor = [UIColor clearColor];
  _rstrtSummaryLabel = [[UILabel alloc] init];
  _rstrtSummaryLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"  size:20];
  _rstrtSummaryLabel.textColor = [UIColor darkGrayColor];
  _rstrtSummaryLabel.backgroundColor = [UIColor clearColor];
  _ratingReviewBgView = [[UIView alloc] init];
  _ratingReviewBgView.backgroundColor = [UIColor clearColor];
  if (!_ratingStarArray) _ratingStarArray = [NSMutableArray array];
  for (int i = 0; i < 5; i++) {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rating_0.png"]];
    [_ratingStarArray addObject:imageView];
    [_ratingReviewBgView addSubview:imageView];
  }
  _ratingReviewLabel = [[UILabel alloc] init];
  _ratingReviewLabel.textColor = [UIColor blackColor];
  _ratingReviewLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"  size:15];
  [_ratingReviewBgView addSubview:_ratingReviewLabel];
  
  _openHourLabel = [[UILabel alloc] init];
  _openHourLabel.textColor = [UIColor blackColor];
  _openHourLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"  size:15];
  
  _detailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  _detailTableView.delegate = self;
  _detailTableView.dataSource = self;
  _detailTableView.backgroundColor = [UIColor clearColor];
  
  [self.view addSubview:_mainScrollView];
  [_mainScrollView addSubview:_rstrtNameLabel];
  [_mainScrollView addSubview:_rstrtSummaryLabel];
  [_mainScrollView addSubview:_ratingReviewBgView];
  [_mainScrollView addSubview:_openHourLabel];
  [_mainScrollView addSubview:_detailTableView];
  
  //[_detailTableView registerClass:[HomeBloggerDetailViewController class] forCellReuseIdentifier:@"DetailCellIdentifier"];
}

- (void)updateUIWithData {
  self.rstrtNameLabel.text = @"Saigon Seafood Harbor Restaurant";
  self.rstrtSummaryLabel.text = @"Seafood, Dim Sum";
  int reviewCount = 1196;
  self.ratingReviewLabel.text = [NSString stringWithFormat:@"%d Reviews", reviewCount];
  self.openHourLabel.text = @"Hours Today: 11:00 AM - 3:00 PM";
}

- (void)manuallyLayoutSubviews {
  self.mainScrollView.frame = self.view.bounds;
  self.rstrtNameLabel.frame = CGRectMake(kBorderLRMargin, kBorderTopMargin, self.view.frame.size.width - kBorderLRMargin * 2, self.rstrtNameLabel.font.lineHeight + 2);
  self.rstrtSummaryLabel.frame = CGRectMake(kBorderLRMargin, kBorderTopMargin + self.rstrtNameLabel.frame.size.height + kBorderLRMargin, self.view.frame.size.width - kBorderLRMargin * 2, self.rstrtSummaryLabel.font.lineHeight + 2);
 
  self.ratingReviewBgView.frame = CGRectMake(kBorderLRMargin, self.rstrtSummaryLabel.frame.origin.y + self.rstrtSummaryLabel.frame.size.height + kBorderLRMargin, self.rstrtSummaryLabel.frame.size.width, 30);
  UIImageView *imgView;
  for (int i = 0; i < 5; i++) {
    imgView = (UIImageView *)[self.ratingStarArray objectAtIndex:i];
    imgView.image = [UIImage imageNamed:@"rating_1.png"];
    imgView.frame = CGRectMake(i * (25 + kRatingStarMargin), 2, 25, 25);
  }
  self.ratingReviewLabel.frame = CGRectMake(imgView.frame.origin.x + imgView.frame.size.width + kBorderLRMargin, 5, 100, 20);
  self.openHourLabel.frame = CGRectMake(kBorderLRMargin, self.ratingReviewBgView.frame.origin.y + self.ratingReviewBgView.frame.size.height + kBorderLRMargin, self.view.frame.size.width - kBorderLRMargin * 2, self.openHourLabel.font.lineHeight + 2);
  
  self.detailTableView.frame = CGRectMake(0, self.openHourLabel.frame.origin.y + self.openHourLabel.frame.size.height, self.view.frame.size.width, 600);
  self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.detailTableView.frame.size.height + self.detailTableView.frame.origin.y);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)
status {
  [self.locationManager requestWhenInUseAuthorization];
}
@end

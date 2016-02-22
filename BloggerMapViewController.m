//
//  BloggerMapViewController.m
//  HoneyDew
//
//  Created by Wei Liu on 5/21/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "BloggerMapViewController.h"

@interface BloggerMapViewController ()
@property (nonatomic) MKMapView *mapView;
@end

@implementation BloggerMapViewController

- (id)initWithRegion:(MKCoordinateRegion)region {
  if (self = [super init]) {
    _currentRegion = region;
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
  [_mapView setRegion:self.currentRegion];
  MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
  [annotation setCoordinate:self.currentRegion.center];
  [_mapView addAnnotation:annotation];
  [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

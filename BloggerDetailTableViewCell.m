//
//  BloggerDetailTableViewCell.m
//  HoneyDew
//
//  Created by Wei Liu on 5/8/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "BloggerDetailTableViewCell.h"
const static CGFloat kBloggerCellMargin = 15;
const static CGFloat kCellIconSide = 30;
const static CGFloat kCellTextWidth = 250;

@implementation BloggerDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _cellIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    _mainText = [[UILabel alloc] initWithFrame:CGRectZero];
    _mainText.textColor = [UIColor blackColor];
    _mainText.font = [UIFont systemFontOfSize:18];
    _detailText = [[UILabel alloc] initWithFrame:CGRectZero];
    _detailText.textColor = [UIColor blackColor];
    _detailText.lineBreakMode = NSLineBreakByTruncatingTail;
    _detailText.font = [UIFont systemFontOfSize:12];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self addSubview:_cellIcon];
    [self addSubview:_mainText];
    [self addSubview:_detailText];
  }
  return self;
}

- (void)configureMapCellForType:(NSUInteger)type {
  _cellIcon.hidden = NO;
  _mainText.hidden = NO;
  _detailText.hidden = NO;
  switch (type) {
    case BloggerDetailCellTypeMapView:
    {
      _currentType = BloggerDetailCellTypeMapView;
      _cellIcon.hidden = YES;
      _mainText.hidden = YES;
      _detailText.hidden = YES;
      if (!_mapView) {
        
        _mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapped:)];
        [self addSubview:_mapView];
        [self addGestureRecognizer:tapGesture];
        NSString *address = @"1133 Lawrence Expy, Sunnyvale, CA 94089";
//        CLLocationCoordinate2D location = [self geoCodeUsingAddress:address];
//        MKCoordinateSpan span = MKCoordinateSpanMake(0.01 , 0.01);
//        MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
//        _mapView.region = region;
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
          if (placemarks && placemarks.count > 0) {
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
            MKCoordinateRegion region = self.mapView.region;
            region.center = [(CLCircularRegion*)placemark.region center];
            region.span = MKCoordinateSpanMake(0.02, 0.02);
            [_mapView setRegion:region animated:NO];
            self.currentRegion = region;
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            [annotation setCoordinate:region.center];
            [_mapView addAnnotation:annotation];
          }
        }];
      }
      //_mapView.delegate = self;
      _mapView.zoomEnabled = NO;
      _mapView.scrollEnabled = NO;
      _mapView.mapType = MKMapTypeStandard;
    }
      break;
    case BloggerDetailCellTypeMapText:
    {
      _mapView = nil;
      _currentType = BloggerDetailCellTypeMapText;
      _cellIcon.hidden = YES;
      _detailText.hidden = YES;
      _mainText.text = @"1135 Lawrence Expy Sunnyvale, CA 94089";
    }
      break;
    case BloggerDetailCellTypeMapDirection:
    {
      _mapView = nil;
      _currentType = BloggerDetailCellTypeMapDirection;
      _cellIcon.image = [UIImage imageNamed:@"direction.png"];
      _mainText.text = @"Directions";
      _detailText.text = @"8 min drive";
    }
      break;
    default:
      break;
  }
}

- (void)configureInfoCellForType:(NSUInteger)type {
  _detailText.numberOfLines = 1;
  _cellIcon.hidden = NO;
  _mainText.hidden = NO;
  _detailText.hidden = NO;
  switch (type) {
    case BloggerDetailCellTypeMainMenu:
    {
      _mapView = nil;
      _currentType = BloggerDetailCellTypeMainMenu;
      _cellIcon.image = [UIImage imageNamed:@"menu.png"];
      _mainText.text = @"Menu";
      _detailText.numberOfLines = 1;
      _detailText.text = @"Roasted Duck, Beef Chow Fun, Sweet & Sour Pork, Soya Duck";
    }
      break;
    case BloggerDetailCellTypeMore:
    {
      _mapView = nil;
      _currentType = BloggerDetailCellTypeMore;
      _cellIcon.image = [UIImage imageNamed:@"more.png"];
      _mainText.text = @"More";
      _detailText.text = @"Website, Ambience, Noise Level";
    }
      break;
    case BloggerDetailCellTypePrice:
    {
      _mapView = nil;
      _currentType = BloggerDetailCellTypePrice;
      _cellIcon.image = [UIImage imageNamed:@"price.png"];
      _mainText.text = @"Price $$(10~50)";
      _detailText.hidden = YES;
    }
      break;
    case BloggerDetailCellTypeCall:
    {
      _mapView = nil;
      _currentType = BloggerDetailCellTypeCall;
      _cellIcon.image = [UIImage imageNamed:@"call.png"];
      _mainText.text = @"Call (123) 456-7890";
      _detailText.hidden = YES;
    }
      break;
    default:
      break;
  }
}

+ (CGFloat)heightForCellWithType:(NSUInteger)type atSection:(NSUInteger)section {
  CGFloat ret = 44;
  switch (section) {
    case BloggerCellSectionTypeMap:
    {
      switch (type) {
        case BloggerDetailCellTypeMapView:
        {
          ret = 120;
        }
          break;
        case BloggerDetailCellTypeMapText:
        {
          ret = 50;
        }
          break;
        case BloggerDetailCellTypeMapDirection:
        {
          ret = 50;
        }
          break;
        default:
          break;
      }
    }
      break;
    case BloggerCellSectionTypeInfo:
    {
      type += 3;
      switch (type) {
        case BloggerDetailCellTypeMainMenu:
        {
          ret = 50;
        }
          break;
        case BloggerDetailCellTypeMore:
        {
          ret = 50;
        }
          break;
        case BloggerDetailCellTypePrice:
        {
          ret = 50;
        }
          break;
        case BloggerDetailCellTypeCall:
        {
          ret = 50;
        }
        default:
          break;
      }

    }
    default:
      break;
  }
  
  return ret;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  switch (_currentType) {
    case BloggerDetailCellTypeMapView:
    {
      _mapView.frame = self.bounds;
    }
      break;
    case BloggerDetailCellTypeMapText:
    {
      _mainText.frame = CGRectMake(kBloggerCellMargin, 10, self.frame.size.width - kBloggerCellMargin - 40, 30);
    }
      break;
    case BloggerDetailCellTypeMapDirection:
    {
      _cellIcon.frame = CGRectMake(kBloggerCellMargin, 10, kCellIconSide, kCellIconSide);
      _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 10, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 40, 30);
    }
      break;
    case BloggerDetailCellTypeMainMenu:
    {
      _cellIcon.frame = CGRectMake(kBloggerCellMargin, 10, kCellIconSide, kCellIconSide);
      _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 7, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 40, 20);
      _detailText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 28, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 40, 15);
    }
      break;
    case BloggerDetailCellTypePrice:
    {
      _cellIcon.frame = CGRectMake(kBloggerCellMargin, 10, kCellIconSide, kCellIconSide);
      _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 10, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 40, 30);
    }
      break;
    case BloggerDetailCellTypeMore:
    {
      _cellIcon.frame = CGRectMake(kBloggerCellMargin, 10, kCellIconSide, kCellIconSide);
      _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 7, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 40, 20);
      _detailText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 28, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 40, 15);
    }
      break;
    case BloggerDetailCellTypeCall:
    {
      _cellIcon.frame = CGRectMake(kBloggerCellMargin, 10, kCellIconSide, kCellIconSide);
      _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 10, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 40, 30);
    }
      break;
    default:
    {
      _cellIcon.frame = CGRectMake(kBloggerCellMargin, 10, kCellIconSide, kCellIconSide);
      _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 7, kCellTextWidth, 20);
      _detailText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 28, kCellTextWidth, 15);
    }
      break;
  }

}

- (void)mapTapped {
  [self mapTapped:nil];
}

- (void)mapTapped:(UIGestureRecognizer*)recognizer {
  [self.delegate mapCellTappedAtRegion:self.currentRegion];
}

#pragma mark - location
//
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//  static NSString *AnnotationIdentifier = @"AnnotationIdentifier";
//  MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
//  if (annotationView == nil) {
//    annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
//  }
//  annotationView.enabled = NO;
//  annotationView.canShowCallout = NO;
//  return annotationView;
//}

@end

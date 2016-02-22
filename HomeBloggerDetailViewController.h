//
//  HomeBloggerDetailViewController.h
//  HoneyDew
//
//  Created by Wei Liu on 5/5/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeBloggerDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong)  CLLocationManager *locationManager;
@end

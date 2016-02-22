//
//  BloggerMapViewController.h
//  HoneyDew
//
//  Created by Wei Liu on 5/21/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BloggerMapViewController : UIViewController
@property (nonatomic) MKCoordinateRegion currentRegion;

- (id)initWithRegion:(MKCoordinateRegion)region;
@end

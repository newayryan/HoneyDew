//
//  HDEvtDetailViewController.h
//  HoneyDew
//
//  Created by Wei Liu on 6/24/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface HDEvtDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initWithEvent:(Event*)event;

@end

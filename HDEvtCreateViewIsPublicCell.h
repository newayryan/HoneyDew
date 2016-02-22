//
//  HDEvtCreateViewIsPublicCell.h
//  HoneyDew
//
//  Created by Wei Liu on 8/29/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDEvtCreateViewIsPublicCell : UITableViewCell

@property (nonatomic) UILabel *cellTitle;
@property (nonatomic) UISwitch *cellIsPublicSwitch;

+ (CGFloat)defaultHeight;

@end

//
//  HDEvtListCell.h
//  HoneyDew
//
//  Created by Wei Liu on 8/23/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDEvtListCell : UITableViewCell
@property (nonatomic) UIImageView *evtAvatar;
@property (nonatomic) UILabel *evtName;
@property (nonatomic) UILabel *evtDetail;
@property (nonatomic) UILabel *evtPublicLabel;
@property (nonatomic) UILabel *evtTime;

+ (CGFloat)defaultHeight;
@end

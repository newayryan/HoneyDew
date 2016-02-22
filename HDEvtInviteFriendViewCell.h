//
//  HDEvtInviteFriendViewCell.h
//  HoneyDew
//
//  Created by Wei Liu on 8/30/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDEvtInviteFriendViewCell : UITableViewCell

@property (nonatomic) UIImageView *userAvatar;
@property (nonatomic) UILabel *userName;
@property (nonatomic) UIImageView *userAccessoryView;

+ (CGFloat)defaultHeight;
- (void)updateSelectedState:(BOOL)selected;
@end

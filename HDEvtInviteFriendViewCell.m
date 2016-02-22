//
//  HDEvtInviteFriendViewCell.m
//  HoneyDew
//
//  Created by Wei Liu on 8/30/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDEvtInviteFriendViewCell.h"
#import "UIColor+Utilities.h"
#import "UIView+Position.h"
#import "iOSMacro.h"

static const CGFloat kAvatarMargin = 10;
static const CGFloat kAccessoryViewSide = 30;
static const CGFloat kAvatarSide = 40;
static const CGFloat kAvatarVertMargin = 5;

@implementation HDEvtInviteFriendViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _userAvatar = [[UIImageView alloc] initWithFrame:CGRectZero];
    _userAvatar.image = [UIImage imageNamed:@"default_user"];
    _userName = [[UILabel alloc] initWithFrame:CGRectZero];
    _userName.font = LightHelNeueFontOfSize(18);
    _userName.textColor = UIColorFromRGB(PRIM_BLACK_COLOR);
    _userAccessoryView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _userAccessoryView.image = [UIImage imageNamed:@"unselect"];
    
    [self.contentView addSubview:_userAvatar];
    [self.contentView addSubview:_userName];
    [self.contentView addSubview:_userAccessoryView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _userAvatar.frame = CGRectMake(kAvatarMargin, kAvatarVertMargin, kAvatarSide, kAvatarSide);
  _userName.frame = CGRectMake(_userAvatar.frameRightX + kAvatarMargin, kAvatarVertMargin, self.contentView.frameWidth - _userAvatar.frameRightX - kAvatarMargin * 3 - kAccessoryViewSide, kAvatarSide);
  _userAccessoryView.frame = CGRectMake(self.contentView.frameWidth - kAccessoryViewSide - kAvatarMargin, kAvatarMargin, kAccessoryViewSide, kAccessoryViewSide);
}

+ (CGFloat)defaultHeight {
  return 50;
}

- (void)updateSelectedState:(BOOL)selected {
  if (selected) {
    _userAccessoryView.image = [UIImage imageNamed:@"select"];
  } else {
    _userAccessoryView.image = [UIImage imageNamed:@"unselect"];
  }
}
@end

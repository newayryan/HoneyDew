//
//  HDEvtListCell.m
//  HoneyDew
//
//  Created by Wei Liu on 8/23/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDEvtListCell.h"
#import "UIColor+Utilities.h"
#import "UIView+Position.h"
#import "iOSMacro.h"

const static CGFloat kAvatarMargin = 10;
const static CGFloat kCellSubViewMargin = 5;
const static CGFloat kAvatarSide = 50;
const static CGFloat kPublicLabelWidth = 40;
const static CGFloat kPublicLabelHeight = 15;
const static CGFloat kNameLabelHeight = 25;

@interface HDEvtListCell ()

@end

@implementation HDEvtListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    [self initSubViews];
  }
  return self;
}

- (void)initSubViews {
  _evtAvatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"event_default.jpg"]];
  _evtName = [[UILabel alloc] initWithFrame:CGRectZero];
  _evtName.font = LightHelNeueFontOfSize(18);
  _evtName.textColor = UIColorFromRGB(PRIM_BLACK_COLOR);
  [self.contentView addSubview:_evtAvatar];
  [self.contentView addSubview:_evtName];
  
  _evtDetail = [[UILabel alloc] initWithFrame:CGRectZero];
  _evtDetail.font = LightHelNeueFontOfSize(14);
  _evtDetail.textColor = UIColorFromRGB(ACCENT_1_BLACK_COLOR);
  [self.contentView addSubview:_evtDetail];
  
  _evtPublicLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _evtPublicLabel.font = LightHelNeueFontOfSize(11);
  _evtPublicLabel.backgroundColor = UIColorFromRGB(ACCENT_1_GREEN_COLOR);
  _evtPublicLabel.textColor = UIColorFromRGB(ACCENT_1_WHITE_COLOR);
  _evtPublicLabel.textAlignment = NSTextAlignmentCenter;
  [self.contentView addSubview:_evtPublicLabel];
  
  _evtTime = [[UILabel alloc] initWithFrame:CGRectZero];
  _evtTime.font = LightHelNeueFontOfSize(11);
  _evtTime.textColor = UIColorFromRGB(ACCENT_1_BLACK_COLOR);
  [self.contentView addSubview:_evtTime];
}

+ (CGFloat)defaultHeight; {
  return 75;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat frameX = self.contentView.frameWidth;
  CGFloat frameWith = self.contentView.frameWidth;
  
  _evtAvatar.frame = CGRectMake(kAvatarMargin, kAvatarMargin, kAvatarSide, kAvatarSide);
  
  frameX -= (kPublicLabelWidth + kCellSubViewMargin);
  _evtPublicLabel.frame = CGRectMake(frameX, _evtAvatar.frameY, kPublicLabelWidth, kPublicLabelHeight);
  
  frameX = _evtAvatar.frameRightX + kCellSubViewMargin * 2;
  frameWith = _evtPublicLabel.frameX - kCellSubViewMargin - frameX;
  _evtName.frame = CGRectMake(frameX, _evtAvatar.frameY, frameWith, kNameLabelHeight);
  
  frameX = self.contentView.frameWidth - kCellSubViewMargin - kPublicLabelWidth * 2;
  _evtTime.frame = CGRectMake(frameX, _evtName.frameBottomY + kCellSubViewMargin, kPublicLabelWidth * 2, kPublicLabelHeight);
  
  frameWith = _evtTime.frameX - _evtAvatar.frameRightX - 2 * kCellSubViewMargin;
  _evtDetail.frame = CGRectMake(_evtName.frameX, _evtName.frameBottomY + kCellSubViewMargin, frameWith, kNameLabelHeight + kCellSubViewMargin);
}

@end

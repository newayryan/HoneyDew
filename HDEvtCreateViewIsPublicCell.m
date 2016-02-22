//
//  HDEvtCreateViewIsPublicCell.m
//  HoneyDew
//
//  Created by Wei Liu on 8/29/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDEvtCreateViewIsPublicCell.h"
#import "UIView+Position.h"
#import "UIColor+Utilities.h"
#import "iOSMacro.h"

static const CGFloat kSwitchWidth = 60;

@implementation HDEvtCreateViewIsPublicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _cellTitle = [[UILabel alloc] init];
    _cellTitle.font = LightHelNeueFontOfSize(18);
    _cellTitle.textColor = UIColorFromRGB(PRIM_BLACK_COLOR);
    [self.contentView addSubview:_cellTitle];
    
    _cellIsPublicSwitch = [[UISwitch alloc] init];
    [self.contentView addSubview:_cellIsPublicSwitch];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _cellTitle.frame = CGRectMake(10, 0, self.contentView.frameWidth - 10 * 2 - kSwitchWidth, self.contentView.frameHeight);
  _cellIsPublicSwitch.frame = CGRectMake(self.contentView.frameWidth - kSwitchWidth, 0, kSwitchWidth, self.contentView.frameHeight);
  [_cellIsPublicSwitch centerVertically];
}

+ (CGFloat)defaultHeight {
  return 40;
}

@end

//
//  HDInfoListCell.m
//  HoneyDew
//
//  Created by Wei Liu on 8/25/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDInfoListCell.h"
#import "UIView+Position.h"
#import "iOSMacro.h"
#import "UIColor+Utilities.h"

static const CGFloat kCellMargin = 5;
static const CGFloat kTitleHeight = 15;
static const CGFloat kContentHeight = 20;

@implementation HDInfoListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    [self initSubViews];
  }
  return self;
}

- (void)initSubViews {
  _cellLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _cellLabel.font = LightHelNeueFontOfSize(14);
  _cellLabel.textColor = UIColorFromRGB(ACCENT_1_BLACK_COLOR);
  _cellTF = [[UITextField alloc] initWithFrame:CGRectZero];
  _cellTF.textAlignment = NSTextAlignmentLeft;
  _cellTF.textColor = UIColorFromRGB(PRIM_BLACK_COLOR);
  _cellTF.font = LightHelNeueFontOfSize(18);
  [_cellTF setBorderStyle:UITextBorderStyleNone];
  [self.contentView addSubview:_cellLabel];
  [self.contentView addSubview:_cellTF];
}

+ (CGFloat)defaultHeight {
  return 50;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  _cellLabel.frame = CGRectMake(kCellMargin * 2, kCellMargin, self.contentView.frameWidth - 2 * kCellMargin, kTitleHeight);
  _cellTF.frame = CGRectMake(kCellMargin * 2, _cellLabel.frameBottomY + kCellMargin, _cellLabel.frameWidth, kContentHeight);
}
@end

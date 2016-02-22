//
//  HDEvtCreateViewCell.m
//  HoneyDew
//
//  Created by Wei Liu on 8/27/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDEvtCreateViewCell.h"
#import "iOSMacro.h"
#import "UIColor+Utilities.h"

@implementation HDEvtCreateViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _cellTF = [[UITextField alloc] init];
    _cellTF.font = HelNeueFontOfSize(18);
    _cellTF.textColor = UIColorFromRGB(PRIM_BLACK_COLOR);
    [self.contentView addSubview:_cellTF];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _cellTF.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, UIEdgeInsetsMake(0, 10, 0, 10));
}

+ (CGFloat)defaultHeight {
  return 40;
}

@end

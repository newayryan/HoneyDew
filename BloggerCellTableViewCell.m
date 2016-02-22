//
//  BloggerCellTableViewCell.m
//  HoneyDew
//
//  Created by Wei Liu on 5/3/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "BloggerCellTableViewCell.h"

@implementation BloggerCellTableViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
  [self addSubview:_imageView];
  return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
  
}

- (void)setThumbnail:(UIImage *)thumbnail {
  if (_thumbnail != thumbnail) {
    _thumbnail = thumbnail;
  }
  self.imageView.image = _thumbnail;
}

@end

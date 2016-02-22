//
//  RsrtImagesTableViewCell.m
//  HoneyDew
//
//  Created by Wei Liu on 6/6/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "RsrtImagesTableViewCell.h"

const static CGFloat imageWidth = 100;

@implementation RsrtImagesTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    [self commonInit];
  }
  return self;
}


+ (CGFloat)heightOfImageCell {
  return 120;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)commonInit {
  _imagesScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  _imagesArray = @[@"baicai_thumb", @"kuai_thumb", @"rousi_thumb", @"sitou_thumb", @"tang_thumb", @"yu_thumb", @"yukuai_thumb"];
}

- (void)layoutSubviews {
  _imagesScrollView.frame = self.bounds;
  _imagesScrollView.contentSize = CGSizeMake(self.imagesArray.count * imageWidth, self.frame.size.height);
}
@end

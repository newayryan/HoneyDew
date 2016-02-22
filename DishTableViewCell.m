//
//  DishTableViewCell.m
//  HoneyDew
//
//  Created by Wei Liu on 6/3/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "DishTableViewCell.h"
const static CGFloat kDishCellMargin = 15;
const static CGFloat kDishCellPriceWidth = 40;

@implementation DishTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _dishView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _dishLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _dishDescription = [[UILabel alloc] initWithFrame:CGRectZero];
    _dishPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    
    _dishLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"  size:20];
    _dishDescription.font = [UIFont fontWithName:@"HelveticaNeue-Light"  size:12];
    _dishDescription.numberOfLines = 2;
    _dishPrice.font = [UIFont fontWithName:@"HelveticaNeue-Light"  size:12];
    _dishPrice.textAlignment = NSTextAlignmentRight;
    [self addSubview:_dishView];
    [self addSubview:_dishLabel];
    [self addSubview:_dishDescription];
    [self addSubview:_dishPrice];
  }
  return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  _dishView.frame = CGRectMake(kDishCellMargin, kDishCellMargin, 50, 50);
  _dishLabel.frame = CGRectMake(_dishView.frame.size.width + kDishCellMargin * 2, 8, self.frame.size.width - _dishView.frame.size.width - kDishCellPriceWidth - kDishCellMargin * 4, 30);
  _dishDescription.frame = CGRectMake(_dishLabel.frame.origin.x, _dishLabel.frame.size.height + 10, _dishLabel.frame.size.width, 35);
  _dishPrice.frame = CGRectMake(self.frame.size.width - kDishCellMargin * 2 - kDishCellPriceWidth, _dishLabel.frame.origin.y, kDishCellPriceWidth, 15);
}

@end

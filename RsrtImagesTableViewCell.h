//
//  RsrtImagesTableViewCell.h
//  HoneyDew
//
//  Created by Wei Liu on 6/6/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RsrtImagesTableViewCell : UITableViewCell
@property (nonatomic) UIScrollView *imagesScrollView;
@property (nonatomic) NSArray *imagesArray;
+ (CGFloat)heightOfImageCell;
@end

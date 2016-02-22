//
//  HDInfoListCell.h
//  HoneyDew
//
//  Created by Wei Liu on 8/25/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDInfoListCell : UITableViewCell

@property (nonatomic) UILabel *cellLabel;
@property (nonatomic) UITextField *cellTF;

+ (CGFloat)defaultHeight;
@end
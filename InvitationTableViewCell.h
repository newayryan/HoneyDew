//
//  InvitationTableViewCell.h
//  HoneyDew
//
//  Created by Song Wang on 5/8/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitationTableViewCell : UITableViewCell

//nameLabel stores the name of the receipt or sender
@property (nonatomic, strong) UILabel *nameLabel;
//dataLabel stores the date of the invitation being sent
@property (nonatomic, strong) UILabel *dateLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

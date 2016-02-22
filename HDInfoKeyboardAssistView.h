//
//  HDInfoKeyboardAssistView.h
//  HoneyDew
//
//  Created by Wei Liu on 9/13/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kToolbarAssistViewHeight = 35;

@protocol KeyboardAssistDelegate <NSObject>

- (void)doneBtnAction;
- (void)previousBtnAction;
- (void)nextBtnAction;

@end

@interface HDInfoKeyboardAssistView : UIView

@property (nonatomic) id<KeyboardAssistDelegate> delegate;

@end

//
//  HDInfoKeyboardAssistView.m
//  HoneyDew
//
//  Created by Wei Liu on 9/13/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "HDInfoKeyboardAssistView.h"
#import "UIColor+Utilities.h"
#import "UIView+Position.h"
#import "iOSMacro.h"

static const CGFloat sBtnMargin = 10;
static const CGSize btnSize = {.width = 70, .height = 35};

@interface HDInfoKeyboardAssistView ()

@property (nonatomic) UIButton *previousBtn;
@property (nonatomic) UIButton *nextBtn;
@property (nonatomic) UIButton *doneBtn;

@end

@implementation HDInfoKeyboardAssistView

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  self.backgroundColor = UIColorFromRGB(ACCENT_2_RED_COLOR);
  
  _previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  _previousBtn.frameSize = btnSize;
  [_previousBtn setTitle:@"Previous" forState:UIControlStateNormal];
  _previousBtn.titleLabel.font = MediumHelNeueFontOfSize(15);
  [_previousBtn setTitleColor:UIColorFromRGB(PRIM_WHITE_COLOR) forState:UIControlStateNormal];
  _previousBtn.backgroundColor = [UIColor clearColor];
  [_previousBtn addTarget:self action:@selector(previousBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  
  _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  _nextBtn.frameSize = btnSize;
  [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
  [_nextBtn setTitleColor:UIColorFromRGB(PRIM_WHITE_COLOR) forState:UIControlStateNormal];
  _nextBtn.backgroundColor = [UIColor clearColor];
  _nextBtn.titleLabel.font = MediumHelNeueFontOfSize(15);
  [_nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  
  _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  _doneBtn.frameSize = btnSize;
  [_doneBtn setTitle:@"Done" forState:UIControlStateNormal];
  [_doneBtn setTitleColor:UIColorFromRGB(PRIM_WHITE_COLOR) forState:UIControlStateNormal];
  _doneBtn.backgroundColor = [UIColor clearColor];
  _doneBtn.titleLabel.font = MediumHelNeueFontOfSize(15);
  [_doneBtn addTarget:self action:@selector(doneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  
  [self addSubview:_previousBtn];
  [self addSubview:_nextBtn];
  [self addSubview:_doneBtn];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  _previousBtn.frameOrigin = CGPointMake(sBtnMargin, 0);
  _nextBtn.frameOrigin = CGPointMake(_previousBtn.frameRightX + sBtnMargin, 0);
  _doneBtn.frameOrigin = CGPointMake(self.frameWidth - _doneBtn.frameWidth - sBtnMargin, 0);
}

- (void)previousBtnAction:(id)sender {
  [self.delegate previousBtnAction];
}

- (void)nextBtnAction:(id)sender {
  [self.delegate nextBtnAction];
}

- (void)doneBtnAction:(id)sender {
  [self.delegate doneBtnAction];
}

@end

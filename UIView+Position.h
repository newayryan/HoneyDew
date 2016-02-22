//
//  UIView+Position.h
//  HoneyDew
//
//  Created by Wei Liu on 6/15/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

// resizing
const static UIViewAutoresizing UIViewAutoresizingAllHorizontal = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin);
const static UIViewAutoresizing UIViewAutoresizingAllVertical = (UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin);
const static UIViewAutoresizing UIViewAutoresizingAllMargins = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin);
const static UIViewAutoresizing UIViewAutoresizingAllSize = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
const static UIViewAutoresizing UIViewAutoresizingAll = (UIViewAutoresizingAllHorizontal|UIViewAutoresizingAllVertical);

const static CGFloat iOSMinTouchSize = 44.0f;
#define iOSDefaultAnimationTime (UIApplication.sharedApplication.statusBarOrientationAnimationDuration)


@interface UIView (Position)

@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGPoint frameOrigin;
@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;

@property (nonatomic) CGSize  frameSize;
@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

@property (nonatomic) CGPoint frameTopRightOrigin;
@property (nonatomic) CGPoint frameBottomLeftOrigin;
@property (nonatomic) CGPoint frameBottomRightOrigin;
@property (nonatomic) CGFloat frameBottomY;
@property (nonatomic) CGFloat frameRightX;

@property (nonatomic) CGSize boundsSize;
@property (nonatomic) CGFloat boundsWidth;
@property (nonatomic) CGFloat boundsHeight;

- (void) centerSelfRelativeTo:(CGRect)frame;
- (void) centerHorizontallyRelativeTo:(CGRect)frame;
- (void) centerVerticallyRelativeTo:(CGRect)frame;

- (void) centerSelf; //needs to have a superview
- (void) centerHorizontallyWithOffset:(CGFloat)offset; //needs to have a superview
- (void) centerVerticallyWithOffset:(CGFloat)offset; //needs to have a superview
- (void) centerHorizontally; //needs to have a superview
- (void) centerVertically; //needs to have a superview
@end

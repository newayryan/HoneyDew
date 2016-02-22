//
//  UIView+Position.m
//  HoneyDew
//
//  Created by Wei Liu on 6/15/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "UIView+Position.h"



@implementation UIView (Position)
#pragma mark - Centering

- (void) centerSelfRelativeTo:(CGRect)frame {
  //We round so we avoid fractional points that can cause aliasing by iOS's animation system
  CGPoint p = CGPointMake(roundf(frame.size.width/2.0)+frame.origin.x,
                          roundf(frame.size.height/2.0)+frame.origin.y);
  self.center = p;
}

- (void) centerHorizontallyRelativeTo:(CGRect)frame {
  //We round so we avoid fractional points that can cause aliasing by iOS's animation system
  CGPoint p = CGPointMake(roundf(frame.size.width/2.0)+frame.origin.x, self.center.y);
  self.center = p;
}

- (void) centerVerticallyRelativeTo:(CGRect)frame {
  //We round so we avoid fractional points that can cause aliasing by iOS's animation system
  CGPoint p = CGPointMake(self.center.x, roundf(frame.size.height/2.0)+frame.origin.y);
  self.center = p;
}

- (void) centerSelf {
  if (self.superview)
    [self centerSelfRelativeTo:self.superview.bounds];
}

- (void) centerHorizontallyWithOffset:(CGFloat)offset {
  if (self.superview) {
    CGRect bounds = self.superview.bounds;
    bounds.origin.x += offset;
    [self centerHorizontallyRelativeTo:bounds];
  }
}

- (void) centerVerticallyWithOffset:(CGFloat)offset {
  if (self.superview) {
    CGRect bounds = self.superview.bounds;
    bounds.origin.y += offset;
    [self centerVerticallyRelativeTo:bounds];
  }
}

- (void) centerHorizontally {
  if (self.superview)
    [self centerHorizontallyRelativeTo:self.superview.bounds];
}

- (void) centerVertically {
  if (self.superview)
    [self centerVerticallyRelativeTo:self.superview.bounds];
}

- (CGFloat) centerY {
  return self.center.y;
}

- (CGFloat) centerX {
  return self.center.x;
}

- (void) setCenterY:(CGFloat) y {
  CGPoint cen = self.center;
  cen.y = y;
  self.center = cen;
}

- (void) setCenterX:(CGFloat) x {
  CGPoint cen = self.center;
  cen.x = x;
  self.center = cen;
}

#pragma mark - Origin
- (CGPoint) frameOrigin {
  return self.frame.origin;
}

- (void) setFrameOrigin:(CGPoint)frameOrigin {
  CGRect fr = self.frame;
  fr.origin = frameOrigin;
  self.frame = fr;
}

- (CGFloat) frameX {
  return self.frame.origin.x;
}

- (void) setFrameX:(CGFloat)frameX {
  CGRect fr = self.frame;
  fr.origin.x = frameX;
  self.frame = fr;
}

- (CGFloat) frameY {
  return self.frame.origin.y;
}

- (void) setFrameY:(CGFloat)frameY {
  CGRect fr = self.frame;
  fr.origin.y = frameY;
  self.frame = fr;
}

#pragma mark - Size

- (CGSize) frameSize {
  return self.frame.size;
}

- (void) setFrameSize:(CGSize)frameSize {
  CGRect fr = self.frame;
  fr.size = frameSize;
  self.frame = fr;
}

- (CGFloat) frameWidth {
  return self.frame.size.width;
}

- (void) setFrameWidth:(CGFloat)frameWidth {
  CGRect fr = self.frame;
  fr.size.width = frameWidth;
  self.frame = fr;
}

- (CGFloat) frameHeight {
  return self.frame.size.height;
}

- (void) setFrameHeight:(CGFloat)frameHeight {
  CGRect fr = self.frame;
  fr.size.height = frameHeight;
  self.frame = fr;
}

#pragma mark - Bottom Right Origin

/// Returns the bottom right corner point of the view square.
- (CGPoint) frameBottomRightOrigin {
  CGPoint o = self.frame.origin;
  o.x += self.frame.size.width;
  o.y += self.frame.size.height;
  return o;
}

/// Sets the view origin relative to the bottom right corner point of the view square.
- (void) setFrameBottomRightOrigin:(CGPoint)frameBottomRightOrigin {
  frameBottomRightOrigin.x -= self.frame.size.width;
  frameBottomRightOrigin.y -= self.frame.size.height;
  self.frameOrigin = frameBottomRightOrigin;
}

/// Returns the right edge x value of the view square.
- (CGFloat) frameRightX {
  return self.frame.origin.x + self.frame.size.width;
}

/// Sets the view x value relative to the right edge x value of the view square.
- (void) setFrameRightX:(CGFloat)frameRightX {
  CGRect fr = self.frame;
  fr.origin.x = frameRightX - self.frame.size.width;
  self.frame = fr;
}

/// Returns the bottom edge y value of the view square.
- (CGFloat) frameBottomY {
  return self.frame.origin.y + self.frame.size.height;
}

/// Sets the view y value relative to the bottom edge y value of the view square.
- (void) setFrameBottomY:(CGFloat)frameBottomY {
  CGRect fr = self.frame;
  fr.origin.y = frameBottomY - self.frame.size.height;
  self.frame = fr;
}

#pragma mark - Bounds

- (CGSize)boundsSize
{
  return self.bounds.size;
}

- (void)setBoundsSize:(CGSize)boundsSize
{
  CGRect newBounds = self.bounds;
  newBounds.size = boundsSize;
  self.bounds = newBounds;
}

- (CGFloat)boundsWidth
{
  return self.bounds.size.width;
}

- (void)setBoundsWidth:(CGFloat)boundsWidth
{
  CGRect newBounds = self.bounds;
  newBounds.size.width = boundsWidth;
  self.bounds = newBounds;
}

- (CGFloat)boundsHeight
{
  return self.bounds.size.height;
}

- (void)setBoundsHeight:(CGFloat)boundsHeight
{
  CGRect newBounds = self.bounds;
  newBounds.size.height = boundsHeight;
  self.bounds = newBounds;
}


#pragma mark - Other Origins

- (CGPoint) frameTopRightOrigin {
  CGPoint o = self.frame.origin;
  o.x += self.frame.size.width;
  return o;
}

- (CGPoint) frameBottomLeftOrigin {
  CGPoint o = self.frame.origin;
  o.y += self.frame.size.height;
  return o;
}

- (void) setFrameTopRightOrigin:(CGPoint)frameTopRightOrigin {
  frameTopRightOrigin.x -= self.frame.size.width;
  self.frameOrigin = frameTopRightOrigin;
}

- (void) setFrameBottomLeftOrigin:(CGPoint)frameBottomLeftOrigin {
  frameBottomLeftOrigin.y -= self.frame.size.height;
  self.frameOrigin = frameBottomLeftOrigin;
}

@end

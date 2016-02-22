//
//  UIColor+Utilities.h
//  HoneyDew
//
//  Created by Wei Liu on 8/20/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utilities)

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed: ((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:        ((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:         ((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromARGBValue(argbValue) [UIColor \
colorWithRed: (float)((argbValue >> 16) & 0xFF) / 255.0 \
green:        (float)((argbValue >>  8) & 0xFF) / 255.0 \
blue:         (float)((argbValue      ) & 0xFF) / 255.0 \
alpha:        (float)((argbValue >> 24) & 0xFF) / 255.0]

#define UIColorFromRGBWithOpacity(rgbValue, opacity) [UIColor \
colorWithRed: ((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:        ((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:         ((float)(rgbValue & 0xFF))/255.0 alpha:opacity]

#define UIColorFromRGBA(r, g, b, a) \
[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@end

//
//  iOSMacro.h
//  HoneyDew
//
//  Created by Wei Liu on 6/15/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#ifndef HoneyDew_iOSMacro_h
#define HoneyDew_iOSMacro_h

#define NSFormatString(formatString, ...) ([NSString stringWithFormat:formatString, __VA_ARGS__])
#define IS_CURRENT_LANG_EN ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"en"])

// Frame
#define ROOTVIEW_BOUNDS ([UIApplication sharedApplication].keyWindow.rootViewController.view.bounds)
#define ROOTVIEW_WIDTH (ROOTVIEW_BOUNDS.size.width)
#define ROOTVIEW_HEIGHT (ROOTVIEW_BOUNDS.size.height)

#define KEYWINDOW_BOUNDS ([UIApplication keyWindowBounds])
#define KEYWINDOW_WIDTH (KEYWINDOW_BOUNDS.size.width)
#define KEYWINDOW_HEIGHT (KEYWINDOW_BOUNDS.size.height)

// Font
#define HelNeueFontOfSize(s) [UIFont fontWithName:@"HelveticaNeue" size: (s)]
#define BoldHelNeueFontOfSize(s) [UIFont fontWithName:@"HelveticaNeue-Bold" size: (s)]
#define LightHelNeueFontOfSize(s) [UIFont fontWithName:@"HelveticaNeue-Light" size: (s)]
#define LightHelItalicNeueFontOfSize(s) [UIFont fontWithName:@"HelveticaNeue-LightItalic" size: (s)]
#define MediumHelNeueFontOfSize(s) [UIFont fontWithName:@"HelveticaNeue-Medium" size: (s)]
#define ItalicHelNeueFontOfSize(s) [UIFont fontWithName:@"HelveticaNeue-Italic" size: (s)]

// Common used fonts
#define LIGHT_MAIN_TEXT_FONT     LightHelNeueFontOfSize(18)
#define LIGHT_DETAIL_TEXT_FONT   LightHelNeueFontOfSize(14)
#define LIGHT_MARK_TEXT_FONT     LightHelNeueFontOfSize(11)
#define MEDIUM_LABEL_FONT        MediumHelNeueFontOfSize(15)
#define MEDIUM_SMALL_FONT        MediumHelNeueFontOfSize(11)
#define REGULAR_TITLE_FONT      HelNeueFontOfSize(18)
#define REGULAR_SMALL_FONT      HelNeueFontOfSize(11)

// Color
#define PRIM_RED_COLOR      0xF44336
#define ACCENT_1_RED_COLOR   0xEF5350
#define ACCENT_2_RED_COLOR   0xC62828
#define PRIM_GREEN_COLOR     0x4CAF50
#define ACCENT_1_GREEN_COLOR  0x81C784
#define ACCENT_2_GREEN_COLOR  0x388E3C
#define PRIM_WHITE_COLOR      0xFAFAFA
#define PRIM_BLACK_COLOR      0x212121
#define ACCENT_1_WHITE_COLOR  0xEEEEEE
#define ACCENT_1_BLACK_COLOR  0x757575
#define PRIM_GRAY_COLOR       0xBDBDBD

#endif

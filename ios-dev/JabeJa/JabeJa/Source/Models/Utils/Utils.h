//
//  Utils.h
//  MuslimLib
//
//  Created by Mohammad Ali Yektaie on 8/4/16.
//  Copyright © 2016 YekiSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define INT(x) [[response objectForKey:x] intValue]
#define BOOLEAN(x) [[response objectForKey:x] boolValue]
#define STRING(x) [response objectForKey:x]

@interface Utils : NSObject

+ (BOOL)isTablet;

+ (NSArray*)readTextFileLinesFromResource:(NSString*)path;

+ (UIColor*)colorFromRed: (int)red Green:(int)green Blue:(int)blue;
+ (NSString*) formatNumber:(int) number;
+ (NSString*)formatDigitsAccordingToLanguage:(NSString*) input;
+ (NSTextAlignment)getDefaultTextAlignment;
+ (NSTextAlignment)getDefaultCounterTextAlignment;
+ (UIFont*) createDefaultFont: (float)size;
+ (UIFont*) createDefaultBoldFont: (float)size;
+ (UIFont*) createDefaultArabicFont: (float)size;
+ (UIFont*) createDefaultArabicBoldFont: (float)size;

+ (BOOL)isIPhone5;

+ (UIViewController*)createViewControllerFromStoryboard:(NSString*)identifier;

+ (void)setupApp;
+ (void)reloadNavigationTitleFonts;
@end

//
//  Utils.m
//  MuslimLib
//
//  Created by Mohammad Ali Yektaie on 8/4/16.
//  Copyright © 2016 YekiSoft. All rights reserved.
//

#import "Utils.h"
#import "Theme.h"
#import "LanguageStrings.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation Utils
static double fontSizeCoefficient;

+ (void)initializeUtils {
    fontSizeCoefficient = 1;//[Settings getFontSizeCoefficient];
}

+ (double)getFontSizeCoefficient {
    return fontSizeCoefficient;
}


+ (BOOL)isTablet {
    return [UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone;
}

+ (NSArray*)readTextFileLinesFromResource:(NSString*)path {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* pathOfFile = [bundle pathForResource:path ofType:@"txt"];

    NSString* content = [NSString stringWithContentsOfFile:pathOfFile
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];

    NSArray* result = [content componentsSeparatedByString:@"\n"];
    return result;

}

+ (UIColor*)colorFromRed: (int)red Green:(int)green Blue:(int)blue {
    float r = red * 1.0f / 255;
    float g = green * 1.0f / 255;
    float b = blue * 1.0f / 255;

    if (r>1)
        r = 1;
    if (g>1)
        g = 1;
    if (b>1)
        b = 1;

    return [[UIColor alloc] initWithRed:r green:g blue:b alpha:1];
}

+ (void)setupApp {
    [FBSDKLoginButton class];
    [Utils initializeUtils];

    [Utils reloadNavigationTitleFonts];
}

+ (void)reloadNavigationTitleFonts {
//    [[UITabBar appearance] setTintColor:[Theme instance].navigationBarTintColor];
//    if ([[LanguageStrings instance] shouldChangeTabItemTitleFont]) {
//        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:L(@"TabBarItemTitleFont") size:[[LanguageStrings instance] getTabItemTitleFontSize]], NSFontAttributeName, nil] forState:UIControlStateNormal];
//        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:L(@"TabBarItemTitleFont")
//                                                                                                                size:[[LanguageStrings instance] getTabItemTitleFontSize]], NSFontAttributeName, nil] forState:UIControlStateSelected];
//    }
//
//    [[UINavigationBar appearance] setTintColor:[Theme instance].navigationBarTintColor];
//    if ([[LanguageStrings instance].name isEqualToString:@"Persian"]) {
//        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:L(@"DefaultBoldFont") size:16], NSFontAttributeName, nil]];
//    }
}

+ (NSString*) formatNumber:(int) number
{
    NSString* str = [NSString stringWithFormat:@"%d", number];

    if (number < 1000) {
        return [Utils formatDigitsAccordingToLanguage:str];
    }

    NSString* result = @"";
    NSRange range;
    range.length = 1;

    int done = 0;
    for (int i = (int)[str length] - 1; i >= 0; i--) {
        if (done > 0 && done % 3 == 0) {
            result = [@"," stringByAppendingString:result];
        }

        range.location = i;
        result= [[str substringWithRange:range] stringByAppendingString:result];
        done++;
    }

    return [Utils formatDigitsAccordingToLanguage:result];
}

+ (NSString*)formatDigitsAccordingToLanguage:(NSString*) input
{
    if ([[LanguageStrings instance] usePersianDigits]) {
        NSString* mapper = @"۰۱۲۳۴۵۶۷۸۹";
        NSString* result = @"";
        NSRange range;
        range.length = 1;

        for (int i = 0; i < [input length]; i++) {
            int ch = (int)[input characterAtIndex:i];

            if (ch >= 48 && ch <= 57) {
                ch = ch - 48;
                range.location = ch;
                NSString* tCh = [mapper substringWithRange:range];
                result = [result stringByAppendingString:tCh];
            } else {
                range.location = i;
                NSString* tCh = [input substringWithRange:range];
                result = [result stringByAppendingString:tCh];
            }
        }

        return result;
    }

    return input;
}

+ (NSTextAlignment)getDefaultTextAlignment {
    NSTextAlignment result = NSTextAlignmentCenter;

    if ([[LanguageStrings instance] isRightToLeft]) {
        result = NSTextAlignmentRight;
    } else {
        result = NSTextAlignmentLeft;
    }

    return result;
    
}

+ (NSTextAlignment)getDefaultCounterTextAlignment {
    NSTextAlignment result = NSTextAlignmentCenter;

    if ([[LanguageStrings instance] isRightToLeft]) {
        result = NSTextAlignmentLeft;
    } else {
        result = NSTextAlignmentRight;
    }

    return result;
    
}

+(UIFont*) createDefaultFont: (float)size {
    size = size * fontSizeCoefficient;
    return [UIFont fontWithName:L(@"DefaultFont") size:size];
}

+(UIFont*) createDefaultBoldFont: (float)size {
    size = size * fontSizeCoefficient;
    return [UIFont fontWithName:L(@"DefaultBoldFont") size:size];
}

+(UIFont*) createDefaultArabicFont: (float)size {
    size = size * fontSizeCoefficient;
    return [UIFont fontWithName:@"KFGQPCUthmanTahaNaskh" size:size];
}

+(UIFont*) createDefaultArabicBoldFont: (float)size {
    size = size * fontSizeCoefficient;
    return [UIFont fontWithName:@"KFGQPCUthmanTahaNaskh-Bold" size:size];
}

+ (UIViewController*)createViewControllerFromStoryboard:(NSString*)identifier {
    UIViewController* vc = [[UIStoryboard storyboardWithName:@"Main"
                            bundle:NULL] instantiateViewControllerWithIdentifier:identifier];
    
    return vc;

}

#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )

+ (BOOL)isIPhone5 {
    return IS_IPHONE_5;
}


@end

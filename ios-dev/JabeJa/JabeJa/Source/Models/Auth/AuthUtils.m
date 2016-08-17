//
//  AuthUtils.m
//  JabeJa
//
//  Created by Mohammad Ali Yektaie on 8/17/16.
//  Copyright © 2016 Mohammad Ali Yektaie. All rights reserved.
//

#import "AuthUtils.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation AuthUtils

static AuthUtils* _instance;

- (instancetype)init {
    self = [super init];

    if (self) {

    }

    return self;
}

+ (AuthUtils*)instance {
    if (_instance == nil) {
        _instance = [[AuthUtils alloc] init];
    }

    return _instance;
}

- (BOOL)isSignedIn {
    return self.isFacebook || self.isGooglePlus;
}

- (BOOL)isFacebook {
    BOOL hasToken = [Settings getFacebookAccessToken] != nil;

    if (hasToken) {
        hasToken = [FBSDKAccessToken currentAccessToken] != nil;
    }

    return hasToken;
}

- (BOOL)isGooglePlus {
    return [Settings getGooglePlusAccessToken] != nil;
}

@end

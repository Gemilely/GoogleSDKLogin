//
//  AppDelegate.m
//  GoogleSDKLogin
//
//  Created by n01186 on 3/23/16.
//  Copyright © 2016 n01186. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSError *configureError;
    
    [[GGLContext sharedInstance] configureWithError: &configureError];
    
    NSAssert(!configureError, @"Error configuring Google Services: %@", configureError);
    
    [GIDSignIn sharedInstance].delegate =self;
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSString *userId = user.userID;
    NSString *idToken = user.authentication.idToken;
    NSString *name = user.profile.name;
    NSString *email = user.profile.email;
    
    NSDictionary *statusText = @{@"statusText":
                                     [NSString stringWithFormat:@"User ID: %@\nName: %@\nEmail: %@",userId, name, email]};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ToggleAuthUINotification" object:nil userInfo:statusText];
    
    NSLog(@"Customer details: %@ %@ %@ %@",userId, idToken, name, email);
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSDictionary *statusText = @{@"statusText": @"Disconnected user"};
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ToggleAuthUINotification" object:nil userInfo:statusText];
}

@end

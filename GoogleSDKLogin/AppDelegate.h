//
//  AppDelegate.h
//  GoogleSDKLogin
//
//  Created by n01186 on 3/23/16.
//  Copyright © 2016 n01186. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end


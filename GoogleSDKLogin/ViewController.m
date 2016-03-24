//
//  ViewController.m
//  GoogleSDKLogin
//
//  Created by n01186 on 3/23/16.
//  Copyright © 2016 n01186. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [GIDSignIn sharedInstance].uiDelegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveToggleAuthUINotification:) name:@"ToggleAuthUINotification" object:nil];
    
    [self toggleAuthUI];
    [self statusText].text = @"Google Sign In\niOS Demo";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
    [self toggleAuthUI];
}

- (IBAction)didTapDisconnect:(id)sender {
    [[GIDSignIn sharedInstance] disconnect];
}

- (void)toggleAuthUI {
    if([GIDSignIn sharedInstance].currentUser.authentication == nil) {
        [self statusText].text = @"Google Sign in\niOS Demo";
        self.signInButton.hidden = NO;
        self.signOutButton.hidden = YES;
        self.disconnectButton.hidden =YES;
    } else {
        self.signInButton.hidden = YES;
        self.signOutButton.hidden = NO;
        self.disconnectButton.hidden = NO;
    }
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSString *userId = user.userID;
    NSString *idToken = user.authentication.idToken;
    NSString *name = user.profile.name;
    NSString *email = user.profile.email;
   
    NSLog(@"Customer details: %@ %@ %@ %@",userId, idToken, name, email);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ToggleAuthUINotification" object:nil];
}

- (void) receiveToggleAuthUINotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"ToggleAuthUINotification"]) {
        [self toggleAuthUI];
        self.statusText.text = [notification userInfo][@"statusText"];
    }
}
@end

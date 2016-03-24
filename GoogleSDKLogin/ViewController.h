//
//  ViewController.h
//  GoogleSDKLogin
//
//  Created by n01186 on 3/23/16.
//  Copyright © 2016 n01186. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface ViewController : UIViewController <GIDSignInUIDelegate>


@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;

@property (weak, nonatomic) IBOutlet UIButton *signOutButton;

@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;

@property (weak, nonatomic) IBOutlet UILabel *statusText;

@end


//
//  SignUpViewController.h
//  Ribbit
//
//  Created by Ambreen Hasan on 4/2/15.
//  Copyright (c) 2015 Ambreen Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)signUp:(id)sender;

@end

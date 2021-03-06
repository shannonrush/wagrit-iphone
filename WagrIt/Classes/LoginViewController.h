//
//  LoginViewController.h
//  WagrIt
//
//  Created by Shannon Rush on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface LoginViewController : BaseViewController <UITextFieldDelegate> {
	UITextField *loginField;
	UITextField *passwordField;
	UIActivityIndicatorView *loginActivity;
	UIButton *loginButton;
}

@property (nonatomic, retain) IBOutlet UITextField *loginField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loginActivity;
@property (nonatomic, retain) IBOutlet UIButton *loginButton;

-(IBAction)loginUser:(id)sender;
-(IBAction)signup:(id)sender;

@end

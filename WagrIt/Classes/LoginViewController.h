//
//  LoginViewController.h
//  WagrIt
//
//  Created by Shannon Rush on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController <UITextFieldDelegate> {
	UITextField *loginField;
	UITextField *passwordField;
}

@property (nonatomic, retain) IBOutlet UITextField *loginField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

- (IBAction)loginUser:(id)sender;

@end

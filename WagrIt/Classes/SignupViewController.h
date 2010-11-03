//
//  SignupViewController.h
//  WagrIt
//
//  Created by Shannon Rush on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface SignupViewController : BaseViewController <UITextFieldDelegate> {
	UITextField *firstNameField;
	UITextField *lastNameField;
	UITextField *emailField;
	UITextField *timeZoneField;
	UITextField *passwordField;
	UITextField *passwordConfirmationField;
	UIPickerView *timeZonePicker;
}

@property (nonatomic, retain) IBOutlet UITextField *firstNameField;
@property (nonatomic, retain) IBOutlet UITextField *lastNameField;
@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *timeZoneField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UITextField *passwordConfirmationField;
@property (nonatomic, retain) IBOutlet UIPickerView *timeZonePicker;

-(IBAction)pickTimeZone:(id)sender;
-(IBAction)signup:(id)sender;
@end
